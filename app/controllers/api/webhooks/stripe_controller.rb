# https://ryanboland.com/blog/one-day-stripe-integration

module Api::Webhooks
	class StripeController < ApplicationController

		skip_before_action :verify_authenticity_token

		def webhook
			event = nil

			begin 
				event = Stripe::Webhook.construct_event(
					request.body.read,
					request.env['HTTP_STRIPE_SIGNATURE'],
					ENV['STRIPE_WEBHOOK_SECRET'],
				)
			rescue JSON::ParserError => e
				head 400
				return
			rescue Stripe::SignatureVerificationError => e
				head 400
				return
			end

			# Handle event types
			case event.type
			when 'invoice.payment_succeeded'
				invoice = event.data.object
				subscription = Stripe::Subscription.retrieve(invoice.subscription)
				update_database_subscription(subscription)
			when 'invoice.payment_failed'
				invoice = event.data.object
				subscription = Stripe::Subscription.retrieve(invoice.subscription)
				update_database_subscription(subscription)
			when 'invoice.payment_created'
			when 'customer.subscription.deleted'
				subscription = event.data.object
				update_database_subscription(subscription)
			when 'customer.subscription.updated'
				subscription = event.data.object
				update_database_subscription(subscription)
			else
				puts "Stripe webhooks - unhandled event: #{event.type}"
			end

			head 200
		end

		private

		def update_database_subscription(stripe_sub)
			subscription = Subscription.find_by(external_id: stripe_sub.id)
			subscription.assign_stripe_attrs(stripe_sub)
			subscription.save!
		end
	end
end