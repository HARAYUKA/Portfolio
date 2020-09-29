class Parent < ApplicationRecord
  # schoolとの親子関係
  belongs_to :school
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
  def self.search(search)
    return Parent.all unless search
    Parent.where(['name LIKE? OR relationship LIKE? OR child_name LIKE? OR child_class LIKE? OR class_teacher LIKE?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
