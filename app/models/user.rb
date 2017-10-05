class User < ActiveRecord::Base
  include Clearance::User

  has_many :results

  scope :alphabetical, -> { order(first_name: :asc, last_name: :asc) }

  def to_s
    "#{first_name} #{last_name}"
  end
  alias_method :collection_select_name, :to_s
end
