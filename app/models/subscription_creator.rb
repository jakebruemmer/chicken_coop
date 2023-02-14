# https://ryanboland.com/blog/one-day-stripe-integration
class SubscriptionCreator
	class HasActiveSubscriptionError < StandardError; end

	attr_accessor :error

	def initialize(user:, price_id:, card_token:)
		@user = user
		@price_id = price_id
		@card_token = card_token
	end

	def call
		create
		self
	end

	def success?
		error.nil?
	end

	private

	def create
		customer = create_or_update_customer
		create_subscription(customer)

		rescue HasActiveSubscriptionError => e
			self.error = "User already has active subscription"
		rescue Stripe::CardError => e
			puts [e.message, *e.backtrace].join($/)
			self.error = e.message
		rescue StandardError => e
			puts [e.message, *e.backtrace].join($/)
			self.error = "Error creating subscription. Please contact customer support."
	end

	def create_or_update_customer
		customer = nil

		# Lock the user to prevent multiple records getting
		# created on Stripe side
		@user.with_lock do
			customer_params = {
				source: @card_token
			}

			if @user.stripe_customer_id
				# Updates customer if it already exists on Stripe
				customer = Stripe::Customer.update(@user.stripe_customer_id, customer_params)
			else
				customer = Stripe::Customer.create(customer_params)
				@user.update!(stripe_customer_id: customer.id)
			end
		end
		customer
	end

	def create_subscription(customer)
		if @user.has_active_subscription?
			raise HasActiveSubscriptionError.new
		end
		
		@user.with_lock do
			stripe_sub = Stripe::Subscription.create(
				customer: customer.id,
				items: [{price: @price_id}]
			)

			subscription = Subscription.new(external_id: stripe_sub.id, user: @user)
			subscription.assign_stripe_attrs(stripe_sub)
			subscription.save!
		end
	end
end