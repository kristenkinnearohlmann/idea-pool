class User < ActiveRecord::Base
    has_secure_password
    has_many :ideas
    has_many :projects
end