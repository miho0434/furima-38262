class ShippingAddress < ApplicationRecord
  belongs_to :purchase
  # バリデーションはformオブジェクト（PurchaseFormモデル）にまとめて記述
end
