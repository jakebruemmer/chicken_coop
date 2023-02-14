class Subscription < ApplicationRecord
	belongs_to :user

	enum status: {
		active: 'active',
		past_due: 'past_due',
		canceled: 'canceled'
	}

	ACCESS_GRANTING_STATUSES = ['active', 'past_due']
	validates :external_id, presence: true

	scope :active_or_trialing, -> { where(status: ACCESS_GRANTING_STATUSES) }
	scope :recent, -> { order("current_period_end DESC NULLS LAST") }

	def active_or_trailing?
		ACCESS_GRANTING_STATUSES.include?(status)
	end

	def assign_stripe_attrs(stripe_sub)
		assign_attributes(
			status: stripe_sub.status,
			cancel_at_period_end: stripe_sub.cancel_at_period_end,
			current_period_start: Time.at(stripe_sub.current_period_start),
			current_period_end: Time.at(stripe_sub.current_period_end)
		)
	end
end