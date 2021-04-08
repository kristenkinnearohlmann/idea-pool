class User < ActiveRecord::Base
    has_secure_password
    has_many :ideas
    has_many :projects

    validates :email, :password, :full_name, presence: true
    validates :full_name, length: { minimum: 2 }
    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "needs to be valid formatted email address."}
end