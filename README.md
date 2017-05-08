## Database Design

  ### 1.Users table
|column|type|option|
|:----:|:-:|:----:|
|name |string| index: true, null: false, unique: true|
|email|string| index: true, unique: true|

 #####  Association

   - has_many :groups, through: :group_users
   - has_many :group_users
   - has_many :messaged_groups, through: :messages, source: :group
   - has_many :messages


### 2.Groups table

|column|type|option|
|:----:|:--:|:----:|
|name|string|index: true, unique: true, null: false|

#####  Association

   - has_many :users, through: :group_users
   - has_many :group_users
   - has_many :messaged_users, through: :messages, source: :user
   - has_many :messages

### 3.Group_users table

|column|type|option|
|:----:|:--:|:----:|
|user_id|references|foreign_key: true |
|group_id|references|foreign_key: true|

#####  Association

   - belongs_to :user
   - belongs_to :group

### 4.Massages table
|column|type|option|
|:----:|:--:|:----:|
|body|text|null: false|
|image|string|  |
|user_id|references|foreign_key: true |
|group_id|references|foreign_key: true|

#####  Association

   - belongs_to :user
   - belongs_to :group
