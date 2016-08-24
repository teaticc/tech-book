class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  validate :dealing_address

  def dealing_address
    if addressable_type == "Dealing"
      validates :first_name, :family_name, :street_address, :post_number, :order_email, presence: true
    end
  end
end
