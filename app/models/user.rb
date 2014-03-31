class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email, :country_code
  
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  has_many :user_skill_category
  has_many :user_skill
  has_many :user_duration

  def self.has_email?(email)
  	self.where(:email => email).limit(1).size > 0
  end

  def self.has_account(account)
  	self.where(:account => account).limit(1).size > 0
  end

  def self.signup(first_name, last_name, email, country_code, account, password, how_to_know, receive_information)
  	User.create! do |user|
  	  user.first_name = first_name
  	  user.last_name = last_name
  	  user.email = email

  	end
  end

  def self.signup_with_social
  end
end
