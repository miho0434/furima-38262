class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image,                     presence: true
  validates :name,                      presence: true, length: { maximum: 40 }
  validates :description,               presence: true, length: { maximum: 1000 }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :status_id,                 numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_charge_burden_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,            numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_day_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :price,                     presence: true,
                                        numericality: { greater_than: 299, less_than: 10_000_000, message: ' is out of setting range' },
                                        format: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge_burden
  belongs_to :prefecture
  belongs_to :delivery_day
end
