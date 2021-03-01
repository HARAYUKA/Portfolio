class Parent < ApplicationRecord
  # childとの親子関係
  has_many :children, dependent: :destroy
  accepts_nested_attributes_for :children

  # 「remember_token」という仮想の属性を作成
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  # validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返します。
  def Parent.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。
  def Parent.new_token
    SecureRandom.urlsafe_base64
  end

   # 永続セッションのためハッシュ化したトークンをデータベースに記憶する
  def remember
    self.remember_token = Parent.new_token
    update_attribute(:remember_digest, Parent.digest(remember_token))
  end

  # トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 保護者一覧のsearch
  # １行目のjoinにすると、園児名やクラス名が登録されていないParentのレコードは拾ってこない為、シンプルに親情報検索のみに
  def self.search(search)
    return Parent.all unless search
    # Parent.joins(children: :classroom).where(['name LIKE? OR relationship LIKE? OR child_name LIKE? OR class_name LIKE?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
    # Parent.joins(:children).where(['name LIKE? OR relationship LIKE? OR child_name LIKE?', "%#{search}%", "%#{search}%", "%#{search}%"])
    Parent.where(['name LIKE? OR relationship LIKE?', "%#{search}%", "%#{search}%"])
  end

  # # LINEログイン
  # def self.from_omniauth(auth)
  #   parent = Parent.where('email = ?', auth.info.email).first
  #   if parent.blank?
  #     parent = Parent.new
  #   end
  #   parent.uid   = auth.uid
  #   parent.name  = auth.info.name
  #   parent.email = auth.info.email
  #   parent.oauth_token = auth.credentials.token
  #   parent.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #   parent
  # end
end
