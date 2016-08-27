class Book < ActiveRecord::Base
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  has_one :dealing
  has_many :categories
  validates :title, :price, :postage, presence: true
  acts_as_taggable_on :categories
  mount_uploader :image, ImageUploader
end
