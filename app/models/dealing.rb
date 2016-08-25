class Dealing < ActiveRecord::Base
  belongs_to :book
  has_one :address, as: :addressable
  validates_uniqueness_of :book_id
  accepts_nested_attributes_for :address
  validates :registered, acceptance: { message: "ボックスにチェックを入れてください"}
end
