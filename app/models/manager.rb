class Manager < ApplicationRecord
  has_many :transactions

  def self.sample
    offset(rand(count)).first
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
