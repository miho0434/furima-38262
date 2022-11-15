class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image,                     presence: true
  validates :name,                      presence: true, length: { maximum: 40 }
  validates :description,               presence: true, length: { maximum: 1000 }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :status_id,                 numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_burden_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,             numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_day_id,           numericality: { other_than: 1, message: "can't be blank" }
  validates :price,                     presence: true,
                                        numericality:{ only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は ¥300~9,999,999 の間で半角数字で指定してください" }


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge_burden
  belongs_to :prefecture
  belongs_to :delivery_day
end
