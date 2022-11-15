require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できない場合' do
      it '画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名ががないと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明がないと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報がないと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態の情報がないと出品できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担の情報がないと出品できない' do
        @item.delivery_charge_burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge burden can't be blank")
      end
      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.delivery_charge_burden_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge burden can't be blank")
      end

      it '発送元の地域の情報がないと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数の情報がないと出品できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.delivery_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end

      it '価格の情報ががないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格は¥299以下だと出品できない' do
        @item.price = '290'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は ¥300~9,999,999 の間で半角数字で指定してください")
      end
      it '価格は￥10,000,000以上だと出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は ¥300~9,999,999 の間で半角数字で指定してください")
      end
      it '価格は半角数値以外だと出品できない' do
        @item.price = '５００あ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は ¥300~9,999,999 の間で半角数字で指定してください")
      end

      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

    end
  end
end
