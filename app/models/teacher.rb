class Teacher < ApplicationRecord
  # Classroomとの親子関係
  belongs_to :classroom

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

  # 渡された文字列のハッシュ値を返す
  def Teacher.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def Teacher.new_token
    SecureRandom.urlsafe_base64
  end

   # 永続セッションのためハッシュ化したトークンをデータベースに記憶する
  def remember
    self.remember_token = Teacher.new_token
    update_attribute(:remember_digest, Teacher.digest(remember_token))
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

  # 保育者一覧のsearch
  def self.search(search)
    return Teacher.all unless search
    # 下記コードの問題点は、クラス名が登録されていないTeacherのレコードは拾ってこない事
    Teacher.joins(:classroom).where(['name LIKE? OR staff_id LIKE? OR class_name LIKE?', "%#{search}%", "%#{search}%", "%#{search}%"])
    # Teacher.joins(:classroom).where(classroom: {['class_name LIKE?', "%#{search}%"]})
    #                          .where(['name LIKE? OR staff_id LIKE?', "%#{search}%", "%#{search}%"])
    # Teacher.where(['name LIKE? OR staff_id LIKE?', "%#{search}%", "%#{search}%"])
  end

  # # LINEログイン
  # def self.from_omniauth(auth)
  #   teacher = Teacher.where('email = ?', auth.info.email).first
  #   if teacher.blank?
  #     teacher = Teacher.new
  #   end
  #   teacher.uid   = auth.uid
  #   teacher.name  = auth.info.name
  #   teacher.email = auth.info.email
  #   teacher.oauth_token = auth.credentials.token
  #   teacher.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #   teacher
  # end
end
