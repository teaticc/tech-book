class Book < ActiveRecord::Base
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  has_one :dealing
  has_many :categories
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  validates :title, :price, :postage, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 50 }
  acts_as_taggable_on :categories
  mount_uploader :image, ImageUploader
end
