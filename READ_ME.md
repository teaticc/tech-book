# TECH::BOOK

## Concept
技術書に特化したシェアリングサービス

1. 解決する問題
    - 本を売る人
        - 読み終わって不要になった技術書が家にあるとかさばるため置きたくない。
        - お金をそんなに持っているわけではないため、本を売ることで別の本を読むための資金を得たい。
    - 本を買う人
        - 技術書は一つ一つが高い。
        - なるべく安いものを買いたい。

2. ターゲット
    - エンジニアとして働いて1, 2年目の若手エンジニア。
    - 技術力向上に意欲的なため、週末はいつも書店により技術書を買っている。
    - 週1,2冊は普段技術書を読む。

3. ユースケース
    - 技術書を読み終わった土日。
    - 今週末に何の本を読むか平日のランチで考えている時。

## MODEL
### User
- Association
    - has_many books
    - has_many dealings as buyer
    - has_many dealings as seller
- Property
    - first_name
    - family_name
    - email
    - address
    - post_number
    - phone_number

### Book
- Association
    - belongs_to user
    - has_one dealing
- Property
    - title
    - category(=>tag)
    - price
    - postage
    - detail
    - state(=>tag)
    - user_id

### Dealing
- Association
    - belongs_to buyer, seller, book
- Property
    - seller_id
    - buyer_id
    - book_id

## Controller
### UsersController
- show
#### Devise
    - new
    - create
    - edit
    - update
    - destroy

### BooksController
- index
- show
#### Later
    - new
    - create
    - edit

### DealingsController
##### path => /books/:id/dealings/~~
- new
- create
