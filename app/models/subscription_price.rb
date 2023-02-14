require 'ostruct'

class SubscriptionPrice < ApplicationRecord
	MONTHLY_399 = OpenStruct.new({
		id: 'price_1MX4oZAmdFkvVlZzt27udfuw',
		name: 'monthly_399',
		amount: 399,
		currency: 'usd',
		interval: 'month'
	})

	def self.monthly_399
		MONTHLY_399
	end
end