class PurchaseForm
  # 通常のモデルのようにvalidationなどを使えるようにする記述
  include ActiveModel::Model
  # purchaseとshippinng_adressテーブルに保存したいカラム名すべてを記述
  # purchase_idを入力すると、「Purchase can't be blank」が表示されるので不要
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: ' is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street_number
    validates :phone_number, format: { with: /\A[0-9]{11}\z/, message: 'is invalid' }
    # purchase_idを入力すると、「Purchase can't be blank」が表示されるので不要
    validates :token
  end

  def save
    # 各テーブルに対してcreateメソッドでインスタンスの作成・保存をする記述
    # 購入情報を保存し、変数purchaseに代入
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    # 住所の保存・purchase_idには、変数purchaseのidと指定する
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id,
                           city: city, street_number: street_number, building_name: building_name,
                           phone_number: phone_number, purchase_id: purchase.id)
  end
end
