class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_many :chickens
	has_many :coops
  has_many :subscriptions

  def has_active_subscription?
    !self.subscriptions.find_by(status: 'active').nil?
  end

  def active_subscription
    self.subscriptions.find_by(status: 'active')
  end
end
