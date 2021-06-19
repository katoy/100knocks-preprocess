# レッスン

##　起動

python は http://localhost:8888  
ruby は docke-compos run -rm app bash してから bin/rails c  

## 課題

### P-001: レシート明細のデータフレーム（df_receipt）から全項目の先頭10件を表示し、どのようなデータを保有しているか目視で確認せよ。

```console
df_receipt.head(10)
df_receipt[:10]

Receipt.limit(10)
=> SELECT "receipts".* FROM "receipts" LIMIT ?  [["LIMIT", 10]]
```

### P-002: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、10件表示させよ

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']].head(10)
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']][:10]

Receipt.select(:sales_ymd, :customer_id, :product_cd, :amount).limit(10)
=> SELECT "receipts"."sales_ymd", "receipts"."customer_id", "receipts"."product_cd", "receipts"."amount" FROM "receipts" LIMIT ?  [["LIMIT", 10]]
```

### P-003: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、10件表示させよ。ただし、sales_ymdはsales_dateに項目名を変更しながら抽出すること。

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']].rename(columns={'sales_ymd': 'sales_date'}).head(10)

Receipt.select('sales_ymd as sales_date, customer_id, product_cd, amount').limit(10)
=> Receipt Load (0.4ms)  SELECT sales_ymd as sales_date, customer_id, product_cd, amount FROM "receipts" LIMIT ?  [["LIMIT", 10]]
```

### P-004: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、以下の条件を満たすデータを抽出せよ。  
顧客ID（customer_id）が"CS018205000001"

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']].query('customer_id == "CS018205000001"')

Receipt.where(customer_id: 'CS018205000001').select('sales_ymd as sales_date, customer_id, product_cd, amount')
=>   Receipt Load (21.9ms)  SELECT sales_ymd as sales_date, customer_id, product_cd, amount FROM "receipts" WHERE "receipts"."customer_id" = ?  [["customer_id", "CS018205000001"]]
```

### P-005: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、以下の条件を満たすデータを抽出せよ。

顧客ID（customer_id）が"CS018205000001"  
売上金額（amount）が1,000以上  

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']] \
            .query('customer_id == "CS018205000001" & amount >= 1000')

Receipt.where(customer_id: 'CS018205000001').where('amount >= ?', 1000).select('sales_ymd as sales_date, customer_id, product_cd, amount')
=> Receipt Load (17.2ms)  SELECT sales_ymd as sales_date, customer_id, product_cd, amount FROM "receipts" WHERE "receipts"."customer_id" = ? AND (amount >= 1000)  [["customer_id", "CS018205000001"]]
```

### P-006: レシート明細データフレーム「df_receipt」から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上数量（quantity）、売上金額（amount）の順に列を指定し、以下の条件を満たすデータを抽出せよ。

顧客ID（customer_id）が"CS018205000001"  
売上金額（amount）が1,000以上または売上数量（quantity）が5以上  

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'quantity', 'amount']].query('customer_id == "CS018205000001" & (amount >= 1000 | quantity >=5)')

Receipt.where(customer_id: 'CS018205000001').where('amount >= :amount or quantity >= :quantity', amount: 1000, quantity: 5).select(:sales_ymd, :customer_id, :product_cd, :amount)
>= Receipt Load (18.3ms)  SELECT "receipts"."sales_ymd", "receipts"."customer_id", "receipts"."product_cd", "receipts"."amount" FROM "receipts" WHERE "receipts"."customer_id" = ? AND (amount >= 1000 or quantity >= 5)  [["customer_id", "CS018205000001"]]
```

### P-007: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、以下の条件を満たすデータを抽出せよ。

顧客ID（customer_id）が"CS018205000001"  
売上金額（amount）が1,000以上2,000以下  

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']] \
    .query('customer_id == "CS018205000001" & 1000 <= amount <= 2000')

Receipt.where(customer_id: 'CS018205000001').where(amount: (1000..2000)).select(:sales_ymd, :customer_id, :product_cd, :amount)
=> Receipt Load (16.6ms)  SELECT "receipts"."sales_ymd", "receipts"."customer_id", "receipts"."product_cd", "receipts"."amount" FROM "receipts" WHERE "receipts"."customer_id" = ? AND "receipts"."amount" BETWEEN ? AND ?  [["customer_id", "CS018205000001"], ["amount", 1000], ["amount", 2000]]
```

### P-008: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、以下の条件を満たすデータを抽出せよ。

顧客ID（customer_id）が"CS018205000001"  
商品コード（product_cd）が"P071401019"以外  

```console
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']] \
    .query('customer_id == "CS018205000001" & product_cd != "P071401019"')

Receipt.where(customer_id: 'CS018205000001').where.not(product_cd: 'P071401019').select(:sales_ymd, :customer_id, :product_cd, :amount)
=> Receipt Load (17.5ms)  SELECT "receipts"."sales_ymd", "receipts"."customer_id", "receipts"."product_cd", "receipts"."amount" FROM "receipts" WHERE "receipts"."customer_id" = ? AND "receipts"."product_cd" != ?  [["customer_id", "CS018205000001"], ["product_cd", "P071401019"]]
```

### P-009: 以下の処理において、出力結果を変えずにORをANDに書き換えよ。

df_store.query('not(prefecture_cd == "13" | floor_area > 900)')

```console
df_store.query('prefecture_cd != "13" & floor_area <= 900')

Store.where.not(prefecture_cd: '13').where('floor_area <= ?', 900)
=> Store Load (0.7ms)  SELECT "stores".* FROM "stores" WHERE "stores"."prefecture_cd" != ? AND (floor_area <= 900)  [["prefecture_cd", "13"]]
```

### P-010: 店舗データフレーム（df_store）から、店舗コード（store_cd）が"S14"で始まるものだけ全項目抽出し、10件だけ表示せよ。

```console
df_store.query("store_cd.str.startswith('S14')", engine='python').head(10)

Store.where('store_cd like ?', 'S14%').limit(10)
=> Store Load (1.0ms)  SELECT "stores".* FROM "stores" WHERE (store_cd like 'S14%') LIMIT ?  [["LIMIT", 10]]
```

### P-011: 顧客データフレーム（df_customer）から顧客ID（customer_id）の末尾が1のものだけ全項目抽出し、10件だけ表示せよ。

```console
df_customer.query("customer_id.str.endswith('1')", engine='python').head(10)

Customer.where('customer_id like ?', '%1').limit(10)
=> Customer Load (0.3ms)  SELECT "customers".* FROM "customers" WHERE (customer_id like '%1') LIMIT ?  [["LIMIT", 10]]
```

### P-012: 店舗データフレーム（df_store）から横浜市の店舗だけ全項目表示せよ

```console
df_store.query("address.str.contains('横浜市')", engine='python')

Store.where('address like ?', '%横浜市%')
=> Store Load (0.4ms)  SELECT "stores".* FROM "stores" WHERE (address like '%横浜市%')
```

### P-013: 顧客データフレーム（df_customer）から、ステータスコード（status_cd）の先頭がアルファベットのA〜Fで始まるデータを全項目抽出し、10件だけ表示せよ。

```console
df_customer.query("status_cd.str.contains('^[A-F]', regex=True)", engine='python').head(10)

Customer.where('status_cd like :a or status_cd like :b', a: 'A%', b:'B%').limit(10)
=> Customer Load (0.4ms)  SELECT "customers".* FROM "customers" WHERE (status_cd like 'A%' or status_cd like 'B%') LIMIT ?  [["LIMIT", 10]]
```

sqlite3 では正規表現検索は使えない。  
postgresql SQLなら  
　　SELECT * FROM customer WHERE status_cd ~ '^［A-F]' LIMIT 10  
とできる。 そこで activeredord から find_by_sql で直接 SQL を指定して検索することになる。  

### P-014: 顧客データフレーム（df_customer）から、ステータスコード（status_cd）の末尾が数字の1〜9で終わるデータを全項目抽出し、10件だけ表示せよ。

```console
df_customer.query("status_cd.str.contains('[1-9]$', regex=True)", engine='python').head(10)

```

### P-015: 顧客データフレーム（df_customer）から、ステータスコード（status_cd）の先頭がアルファベットのA〜Fで始まり、末尾が数字の1〜9で終わるデータを全項目抽出し、10件だけ表示せよ。

```console
df_customer.query("status_cd.str.contains('^[A-F].*[1-9]$', regex=True)", engine='python').head(10)
```

### P-016: 店舗データフレーム（df_store）から、電話番号（tel_no）が3桁-3桁-4桁のデータを全項目表示せよ。

```console
df_store.query("tel_no.str.contains('^[0-9]{3}-[0-9]{3}-[0-9]{4}$', regex=True)", engine='python')

Store.where('tel_no like ?', '___-___-____').select(:store_cd, :tel_no)
=> Store Load (0.8ms)  SELECT "stores"."store_cd", "stores"."tel_no" FROM "stores" WHERE (tel_no like '___-___-____')

Store.where('tel_no like ?', '___-___-____').count
=> 34
irb(main):079:0> Store.where.not('tel_no like ?', '___-___-____').count
=> 19
irb(main):080:0> Store.count
=> 53
```

正規表現をつかわずに、like 検索をつかってみました。

### P-17: 顧客データフレーム（df_customer）を生年月日（birth_day）で高齢順にソートし、先頭10件を全項目表示せよ。

```console
df_customer.sort_values('birth_day', ascending=True).head(10)

Customer.order(birth_day: :asc).select(:customer_id, :customer_name, :birth_day).limit(10)
=> Customer Load (6.0ms)  SELECT "customers"."customer_id", "customers"."customer_name", "customers"."birth_day" FROM "customers" ORDER BY "customers"."birth_day" ASC LIMIT ?  [["LIMIT", 10]]
```

### P-19: レシート明細データフレーム（df_receipt）に対し、1件あたりの売上金額（amount）が高い順にランクを付与し、先頭10件を抽出せよ。項目は顧客ID（customer_id）、売上金額（amount）、付与したランクを表示させること。なお、売上金額（amount）が等しい場合は同一順位を付与するものとする。

```console
df_tmp = pd.concat([df_receipt[['customer_id', 'amount']] ,df_receipt['amount'].rank(method='min', ascending=False)], axis=1)
df_tmp.columns = ['customer_id', 'amount', 'ranking']
df_tmp.sort_values('ranking', ascending=True).head(10)

Receipt.order(amount: :desc).select('customer_id, amount, RANK() OVER(ORDER BY amount DESC) as ranking').limit(10)
=> Receipt Load (62.2ms)  SELECT customer_id, amount, RANK() OVER(ORDER BY amount DESC) as ranking FROM "receipts" ORDER BY "receipts"."amount" DESC LIMIT ?  [["LIMIT", 10]]
```

### P-020: レシート明細データフレーム（df_receipt）に対し、1件あたりの売上金額（amount）が高い順にランクを付与し、先頭10件を抽出せよ。項目は顧客ID（customer_id）、売上金額（amount）、付与したランクを表示させること。なお、売上金額（amount）が等しい場合でも別順位を付与すること。

```console
df_tmp = pd.concat([df_receipt[['customer_id', 'amount']] ,df_receipt['amount'].rank(method='first', ascending=False)], axis=1)
df_tmp.columns = ['customer_id', 'amount', 'ranking']
df_tmp.sort_values('ranking', ascending=True).head(10)

Receipt.order(amount: :desc).select('customer_id, amount, ROW_NUMBER() OVER(ORDER BY amount DESC) as ranking').limit(10)
=> Receipt Load (98.5ms)  SELECT customer_id, amount, ROW_NUMBER() OVER(ORDER BY amount DESC) as ranking FROM "receipts" ORDER BY "receipts"."amount" DESC LIMIT ?  [["LIMIT", 10]]
```

### P-021: レシート明細データフレーム（df_receipt）に対し、件数をカウントせよ

```console
len(df_receipt)

Receipt.count
=> (8.5ms)  SELECT COUNT(*) FROM "receipts"
```

### P-022: レシート明細データフレーム（df_receipt）の顧客ID（customer_id）に対し、ユニーク件数をカウントせよ。

```console
len(df_receipt['customer_id'].unique())

Receipt.select(:customer_id).distinct.count
=> (80.3ms)  SELECT COUNT(DISTINCT "receipts"."customer_id") FROM "receipts"
```

### P-023: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに売上金額（amount）と売上数量（quantity）を合計せよ。

```console
df_receipt.groupby('store_cd').agg({'amount':'sum', 'quantity':'sum'}).reset_index()

Receipt.group(:store_cd).select('store_cd, SUM(amount) as amount, SUM(quantity) as quantity')
=> Receipt Load (153.2ms)  SELECT store_cd, SUM(amount) as amount, SUM(quantity) as quantity FROM "receipts" GROUP BY "receipts"."store_cd"
```

### P-024: レシート明細データフレーム（df_receipt）に対し、顧客ID（customer_id）ごとに最も新しい売上日（sales_ymd）を求め、10件表示せよ。

```console
df_receipt.groupby('customer_id').sales_ymd.max().reset_index().head(10)

Receipt.group(:store_cd).select('store_cd, MAX(sales_ymd) as latest').limit(10)
=> Receipt Load (146.9ms)  SELECT store_cd, MAX(sales_ymd) as latest FROM "receipts" GROUP BY "receipts"."store_cd" LIMIT ?  [["LIMIT", 10]]
```

### S-025: レシート明細テーブル（receipt）に対し、顧客ID（customer_id）ごとに最も古い売上日（sales_ymd）を求め、10件表示せよ

```console
df_receipt.groupby('customer_id').sales_ymd.max().reset_index().head(10)

Receipt.group(:store_cd).select('store_cd, MIN(sales_ymd) as first').limit(10)
=> Receipt Load (88.7ms)  SELECT store_cd, MIN(sales_ymd) as first FROM "receipts" GROUP BY "receipts"."store_cd" LIMIT ?  [["LIMIT", 10]]
```
