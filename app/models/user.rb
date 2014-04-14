class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  
  validates_presence_of :first_name, :message => "姓氏未填寫"
  validates_presence_of :last_name, :message => "名字未填寫"
  validates_presence_of :country_code, :message => "地區未選取"
  validates_presence_of :email, :message => "Email未填寫"
  validates_presence_of :username, :message => "帳號未填寫"
  validates_uniqueness_of :email, :message => "Email重複了"
  validates_uniqueness_of :username, :message => "帳號重複了"

  has_many :user_authentications

  def self.has_email?(email)
    self.where(:email => email).limit(1).size > 0
  end

  def self.has_username?(account)
    self.where(:username => account).limit(1).size > 0
  end

  def apply_omniauth(omni)
    user_authentications.build(:provider => omni['provider'], 
                               :uid => omni['uid'], 
                               :token => omni['credentials'].token, 
                               :token_secret => omni['credentials'].secret)
  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :provider_uid)).first_or_create do |user|
      user.provider = auth.provider
      user.provider_uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = auth.info.image
    end
  end

  def password_required?
    (user_authentications.empty? || !password.blank?) && super #&& provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["first_name"] if user.first_name.blank?
        user.last_name = data["last_name"] if user.last_name.blank?
      end
    end
  end

end
