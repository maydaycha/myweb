class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
  
  validates_presence_of :first_name, :message => "姓氏未填寫"
  validates_presence_of :last_name, :message => "名字未填寫"
  validates_presence_of :country_code, :message => "地區未選取"
  validates_presence_of :email, :message => "Email未填寫"
  validates_presence_of :account, :message => "帳號未填寫"
  validates_uniqueness_of :email, :message => "Email重複了"
  validates_uniqueness_of :account, :message => "帳號重複了"

  def self.has_email?(email)
    self.where(:email => email).limit(1).size > 0
  end

  def self.has_account(account)
    self.where(:account => account).limit(1).size > 0
  end

end
