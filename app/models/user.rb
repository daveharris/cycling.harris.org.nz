class User < ActiveRecord::Base
  include Clearance::User

  has_many :results

  def collection_select_name
    "#{first_name} #{last_name}"
  end
end
