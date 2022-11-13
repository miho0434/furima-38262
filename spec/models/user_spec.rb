require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nickname、email、passwordとpassword_confirmation、family_name、
      first_name、family_name_kana、family_name_kana、date_of_birthが
      存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には6文字以上の半角英数字を使用して設定してください')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には6文字以上の半角英数字を使用して設定してください')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = '11111ａ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には6文字以上の半角英数字を使用して設定してください')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'family_nameが半角では登録できない' do
        @user.family_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it 'family_name_kanaが半角では登録できない' do
        @user.family_name_kana = 'ｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana に全角カナを使用してください')
      end

      it 'family_name_kanaが漢字では登録できない' do
        @user.family_name_kana = '亜'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana に全角カナを使用してください')
      end

      it 'family_name_kanaがひらがなでは登録できない' do
        @user.family_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana に全角カナを使用してください')
      end

      it 'family_name_kanaがアルファベットでは登録できない' do
        @user.family_name_kana = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana に全角カナを使用してください')
      end

      it 'family_name_kanaが数字では登録できない' do
        @user.family_name_kana = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana に全角カナを使用してください')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = 'ｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana に全角カナを使用してください')
      end

      it 'first_name_kanaが漢字では登録できない' do
        @user.first_name_kana = '亜'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana に全角カナを使用してください')
      end

      it 'first_name_kanaがひらがなでは登録できない' do
        @user.first_name_kana = 'あ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana に全角カナを使用してください')
      end

      it 'first_name_kanaがアルファベットでは登録できない' do
        @user.first_name_kana = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana に全角カナを使用してください')
      end

      it 'first_name_kanaが数字では登録できない' do
        @user.first_name_kana = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana に全角カナを使用してください')
      end

      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
