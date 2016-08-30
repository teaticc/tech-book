class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:nickname]
  validates :nickname, presence: true, uniqueness: true
  has_many :seller_books, class_name: "Book", foreign_key: "seller_id"
  has_many :buyer_books, class_name: "Book", foreign_key: "buyer_id"
  has_one :address, as: :addressable

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #認証の条件式を変更する
      where(conditions).where(["nickname = :value", { :value => nickname }]).first
    else
      where(conditions).first
    end
  end
end
