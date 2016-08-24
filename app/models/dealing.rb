class Dealing < ActiveRecord::Base
  belongs_to :book
  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
  validates :registered, acceptable: true
end
