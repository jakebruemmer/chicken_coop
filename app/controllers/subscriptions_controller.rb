# https://ryanboland.com/blog/one-day-stripe-integration
class SubscriptionsController < ApplicationController
	def new
	end

	def index
	end

	def show
	end

	def create
		manager = SubscriptionCreator.new(
				price_id: params[:stripe_price_id],
				card_token: params[:card_token],
				user: current_user
		).call

		if manager.success?
			redirect_to user_path(current_user)
		else
			flash.now[:alert] = manager.error
			render :new
		end
	end

	def cancel
		 Stripe::Subscription.cancel(current_user.active_subscription.external_id)
		 flash.now[:alert] = "Your subscription has been canceled"
		 redirect_to user_path(current_user.id)
	end

	def manage

		portal = Stripe::BillingPortal::Session.create({
			customer: current_user.stripe_customer_id,
			return_url: root_url
		})

		redirect_to portal["url"], allow_other_host: true
	end
end