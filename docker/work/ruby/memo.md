# タイトル

## コマンド

``` console
rails new knocks100 --skip-test
cd knocks100

rails g model Customer customer_id:string customer_name:string gender_cd:string gender:string birth_day:date age:integer postal_cd:string  address:string application_store_cd:string application_date:date status_cd:string --no-timestamps --force

rails g model Category category_major_cd:string category_major_name:string category_medium_cd:string category_medium_name:string category_small_cd:string category_small_name:string  --no-timestamps --force

rails g model Product product_cd:string category_major_cd:string category_medium_cd:string category_small_cd:string unit_price:float unit_cost:float category_major_name:string category_medium_name:string category_small_name:string --no-timestamps --force

rails g model Receipt sales_ymd:date sales_epoch:integer store_cd:string receipt_no:integer receipt_sub_no:integer customer_id:string product_cd:string quantity:integer amount:integer --no-timestamps --force

rails g model Store store_cd:string store_name:string prefecture_cd:string prefecture:string address:string address_kana:string tel_no:string "longitude:decimal{11,8}" "latitude:decimal{11,8}" floor_area:string --no-timestamps --force

rails g model Geocode postal_cd:string prefecture:string city:string town:string street:string address:string full_address:string "longitude:decimal{11,8}" "latitude:decimal{11,8}" --no-timestamps --force

rails db:drop
rails db:create
rails db:migrate
rails db:seed

あるいは
rails db:reset
```

## ER　図の姿勢

```conosle
bundle exec erd --filetype=svg
```
