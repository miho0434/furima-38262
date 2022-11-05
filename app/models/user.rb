class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム
  validates :nickname, presence: true

  # メールアドレス
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: EMAIL_REGEX, message: '[@文字列.文字列]を含めて入力してください' }, allow_blank: true

  # パスワード
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: 'には6文字以上の半角英数字を使用して設定してくさいだ' }, allow_blank: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  # 苗字・名前をグループ化
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください', allow_blank: true } do
    validates :family_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'に全角カナを使用してください', allow_blank: true } do
    validates :family_name_kana
    validates :first_name_kana
  end

  # 生年月日
  validates :date_of_birth, presence: true
end
