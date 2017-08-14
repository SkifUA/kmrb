class User < ApplicationRecord
  has_one :admin
  after_create :send_invite_email

  has_secure_password validates: false

  VISIBLE_COLUMNS = [
      'id',
      'first_name',
      'last_name',
      'email',
      'created_at',
      'activated'
  ]

  EDIBLE_COLUMNS = [
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
  ]

  NAME_LENGTH_MAX = 50
  PASSWORD_LENGTH_MAX = 32
  PASSWORD_LENGTH_MIN = 4
  EMAIL_LENGTH_MAX = 250
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save   :downcase_email
  validates :first_name,
            presence: true,
            length: { maximum: NAME_LENGTH_MAX }
  validates :last_name,
            presence: true,
            length: { maximum: NAME_LENGTH_MAX }
  validates :email,
            presence: true,
            length: { maximum: EMAIL_LENGTH_MAX },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: PASSWORD_LENGTH_MIN,
                      maximum: PASSWORD_LENGTH_MAX },
            if: -> (m) { !m.password.nil? }


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(activation_digest).is_password?(remember_token)
  end

  def reset?(reset_token)
    BCrypt::Password.new(reset_digest).is_password?(reset_token)
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Activates /an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def send_invite_email
    begin
      UserMailer.account_activation(self).deliver_now
    rescue
      puts "Invite mail did't sent to #{self.email}"

    end
  end

  def admin?
    self.admin.present?
  end

  def self.visible_columns
    VISIBLE_COLUMNS
  end

  def self.edible_columns
    EDIBLE_COLUMNS
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.last_name = auth.info.last_name
      user.first_name = auth.info.first_name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user
    end
  end

  # def self.exist_by_email(email)
  #   User.exis
  # end

  private

  # Converts email to all lower-case.a
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
