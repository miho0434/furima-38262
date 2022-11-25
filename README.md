## usersテーブル(ユーザー管理機能)

| Column             | Type       | Options                  |
| ----------------   | --------   | ------------             |
| email              | string     | null: false ,unique: true|
| encrypted_password | string     | null: false              |
| nickname           | string     | null: false              |
| family_name        | string     | null: false              |
| first_name         | string     | null: false              |
| family_name_kana   | string     | null: false              |
| first_name_kana    | string     | null: false              |
| date_of_birth      | date       | null: false              |

### Association
has_many :items
has_many :purchase_records


===========================================================
## itemsテーブル(商品出品機能)

| Column                    | Type       | Options                        |
| ----------------          | --------   | ------------                   |
| name                      | string     | null: false                    |
| description               | text       | null: false                    |
| category_id               | integer    | null: false                    |
| status_id                 | integer    | null: false                    |
| delivery_charge_burden_id | integer    | null: false                    |
| prefecture_id             | integer    | null: false                    |
| delivery_day_id           | integer    | null: false                    |
| price                     | integer    | null: false                    |
| user                      | references | null: false ,foreign_key: true |

### Association
belongs_to :user
has_one :purchase_record


===========================================================
## purchasesテーブル(購入管理機能)

| Column             | Type       | Options                        |
| ----------------   | --------   | ------------                   |
| item               | references | null: false ,foreign_key: true |
| user               | references | null: false ,foreign_key: true |


### Association
belongs_to :user
belongs_to :item
has_one :shipping_address

===========================================================
## shipping_addressesテーブル（配送先情報）

| Column             | Type       | Options                        |
| ----------------   | --------   | ------------                   |
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| street_number      | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| purchase_record    | references | null: false ,foreign_key: true |


### Association
belongs_to :purchase_record




