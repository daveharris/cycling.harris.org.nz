class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :results

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  private

  def attributes_for_inspect
    %w[id name]
  end
end
