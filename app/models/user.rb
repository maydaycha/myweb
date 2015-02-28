class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable,
    :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :weibo, :linkedin]

  # validates :password, :presence => true, :format => { :with  => /(?=.*\d)(?=.*[a-zA-Z])/, :allow_blank => false, :message => "must include at least one letter, and one digit" }

  before_save :ensure_authentication_token

  validates_presence_of :first_name, :message => "姓氏未填寫"
  validates_presence_of :last_name, :message => "名字未填寫"
  # validates_presence_of :country_code, :message => "地區未選取"
  validates_presence_of :email, :message => "Email未填寫"
  validates_presence_of :username, :message => "帳號未填寫"
  validates_uniqueness_of :email, :message => "Email重複了"
  validates_uniqueness_of :username, :message => "帳號重複了"

  has_many :user_authentications, dependent: :destroy
  has_many :user_employer_personals, dependent: :destroy
  has_many :user_employer_companies, dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :user_skill_categories, dependent: :destroy
  has_many :user_educations, dependent: :destroy
  has_many :user_experiences, dependent: :destroy
  has_many :user_favorites, dependent: :destroy
  has_many :user_certifications, dependent: :destroy
  has_many :user_portfolios, dependent: :destroy
  has_many :user_favorite_projects, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :user_applying_projects, dependent: :destroy
  has_many :user_contact_persons, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :snapshots, dependent: :destroy
  has_many :working_histories, dependent: :destroy

  has_many :user_conversations
  has_many :conversations, :through => :user_conversations
  has_many :messages, :through => :conversations


  accepts_nested_attributes_for :user_skill_categories

  acts_as_messageable

  def name
    email
  end

  def mailboxer_email(object)
    email
  end

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


  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
    # Todo : if token expired, regenerate a new token
  end


  private


  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end



  # private
  # def password_complexity
    # if password.present? and not password.match(/(?=.*\d)(?=.*[a-zA-Z])/)
      # errors.add :password, "must include at least one letter, and one digit"
      # puts errors.to_json
    # end
  # end

end
