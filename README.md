## usersテーブル(ユーザー管理機能)

| Column             | Type       | Options                |
| ----------------   | --------   | ------------           |
| email              | string     | null: false  ユニーク制約|
| encrypted_password | string     | null: false            |
| nickname           | string     | null: false            |

### Association
has_many :items
has_many :comments
has_one :profile

===========================================================
## itemsテーブル(商品出品機能)

| Column                 | Type       | Options                |
| ----------------       | --------   | ------------           |
| name                   | string     | null: false            |
| description            | text 　    | null: false            |
| category               | string     | null: false            |
| price                  | integer    | null: false            |
| status                 | string     | null: false            |
| delivery_charge_burden | boolean    | null: false            |
| delivery_area          | string     | null: false            |
| delivery_days          | integer    | null: false            |
| user                   | references | null: false    外部キー |

### Association
belongs_to :users
has_many :comments
has_one :purchase_items


===========================================================
## purchase_recordテーブル(購入機能)

| Column             | Type       | Options                |
| ----------------   | --------   | ------------           |
| user               | references | null: false    外部キー |
| item               | references | null: false    外部キー |


### Association
belongs_to :items
has_one :profiles


===========================================================
## profilesテーブル(購入者機能)

| Column             | Type       | Options                |
| ----------------   | --------   | ------------           |
| name               | string     | null: false            |
| postal_code        | integer    | null: false            |
| prefecture         | string     | null: false            |
| city               | string     | null: false            |
| street_number      | integer    | null: false            |
| building_name      | string     | null: false            |
| tel                | integer    | null: false            |
| user               | references | null: false    外部キー |

### Association
belongs_to :users
belongs_to :purchase_items

===========================================================
## commentsテーブル(コメント機能)

| Column             | Type       | Options                |
| ----------------   | --------   | ------------           |
| user               | references | null: false    外部キー |
| item               | references | null: false    外部キー |
| text               | text       | null: false            |

### Association
belongs_to :users
belongs_to :comments


