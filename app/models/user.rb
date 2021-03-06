class User < ActiveRecord::Base
  attr_accessor :login

  validates :username, presence: true, uniqueness: true,
    length: { minimum: 3, maximum: 20 }
  validates :first_name, presence: true,
    length: { minimum: 3, maximum: 20 }
  validates :last_name, presence: true,
    length: { minimum: 3, maximum: 20 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [ :login ]

  has_many :posts
  has_many :comments

  # Avoid conflicts between username & email being the same.
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
end
