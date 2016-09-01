class Dealing < ActiveRecord::Base
  belongs_to :book
  has_one :address, as: :addressable
  validates_uniqueness_of :book_id
  accepts_nested_attributes_for :address
  validates :registered, acceptance: { message: "ボックスにチェックを入れてください"}
  validates_presence_of :payment, message: "を選択してください"
  enum payment: { credit_card: 0, bank_account: 1 }
end
