class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  # バリデーションはformオブジェクト（PurchaseFormモデル）にまとめて記述
end
