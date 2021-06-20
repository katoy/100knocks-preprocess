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

### P-026: レシート明細データフレーム（df_receipt）に対し、顧客ID（customer_id）ごとに最も新しい売上日（sales_ymd）と古い売上日を求め、両者が異なるデータを10件表示せよ。

```console
df_tmp = df_receipt.groupby('customer_id').agg({'sales_ymd':['max','min']}).reset_index()
df_tmp.columns = ["_".join(pair) for pair in df_tmp.columns]
df_tmp.query('sales_ymd_max != sales_ymd_min').head(10)

Receipt.group(:customer_id).select('customer_id, MIN(sales_ymd) as first, MAX(sales_ymd) as last').having('MIN(sales_ymd) != MAX(sales_ymd)').limit(10)
=> Receipt Load (81.1ms)  SELECT customer_id, MIN(sales_ymd) as first, MAX(sales_ymd) as last FROM "receipts" GROUP BY "receipts"."customer_id" HAVING (MIN(sales_ymd) != MAX(sales_ymd)) LIMIT ?  [["LIMIT", 10]]
```

### P-027: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに売上金額（amount）の平均を計算し、降順でTOP5を表示せよ。

```console
df_receipt.groupby('store_cd').agg({'amount':'mean'}).reset_index().sort_values('amount', ascending=False).head(5)

Receipt.group(:store_cd).select('store_cd, AVG(amount) as average_amount').order(average_amount: :desc).limit(5)
=> Receipt Load (107.1ms)  SELECT store_cd, AVG(amount) as average_amount FROM "receipts" GROUP BY "receipts"."store_cd" ORDER BY "average_amount" DESC LIMIT ?  [["LIMIT", 5]]
```

### P-028: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに売上金額（amount）の中央値を計算し、降順でTOP5を表示せよ。

```console

# TODO:
```

### P-029: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに商品コード（product_cd）の最頻値を求めよ

```count

# TODO:
```

### P-030: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに売上金額（amount）の標本分散を計算し、降順でTOP5を表示せよ。

```console

# TODO:
```

### P-031: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに売上金額（amount）の標本標準偏差を計算し、降順でTOP5を表示せよ。

```console

# TODO:
```

### P-032: レシート明細データフレーム（df_receipt）の売上金額（amount）について、25％刻みでパーセンタイル値を求めよ。

```console

# TODO:
```

### P-033: レシート明細データフレーム（df_receipt）に対し、店舗コード（store_cd）ごとに売上金額（amount）の平均を計算し、330以上のものを抽出せよ。

```console
df_receipt.groupby('store_cd').amount.mean().reset_index().query('amount >= 330')

Receipt.group(:store_cd).select('store_cd, AVG(amount) as average_amount').having('AVG(amount) >= 330')
=> Receipt Load (93.9ms)  SELECT store_cd, AVG(amount) as average_amount FROM "receipts" GROUP BY "receipts"."store_cd" HAVING (AVG(amount) >= 330)
```

### P-034: レシート明細データフレーム（df_receipt）に対し、顧客ID（customer_id）ごとに売上金額（amount）を合計して全顧客の平均を求めよ。ただし、顧客IDが"Z"から始まるのものは非会員を表すため、除外して計算すること。

```console

# TODO:
```

### P-035: レシート明細データフレーム（df_receipt）に対し、顧客ID（customer_id）ごとに売上金額（amount）を合計して全顧客の平均を求め、平均以上に買い物をしている顧客を抽出せよ。ただし、顧客IDが"Z"から始まるのものは非会員を表すため、除外して計算すること。なお、データは10件だけ表示させれば良い。

```console

# TODO:
```

### S-036: レシート明細テーブル（receipt）と店舗テーブル（store）を内部結合し、レシート明細テーブルの全項目と店舗テーブルの店舗名（store_name）を10件表示させよ。

```console
pd.merge(df_receipt, df_store[['store_cd','store_name']], how='inner', on='store_cd').head(10)

Receipt.joins(:store).select('receipts.*, stores.store_name').limit(10)
=> Receipt Load (5.0ms)  SELECT receipts.*, stores.store_name FROM "receipts" INNER JOIN "stores" ON "stores"."store_cd" = "receipts"."store_cd" LIMIT ?  [["LIMIT", 10]]
```

### S-037: 商品テーブル（product）とカテゴリテーブル（category）を内部結合し、商品テーブルの全項目とカテゴリテーブルの小区分名（category_small_name）を10件表示させよ。

```console
pd.merge(df_product
         , df_category[['category_small_cd','category_small_name']]
         , how='inner', on='category_small_cd').head(10)

Product.joins(:category).select('products.*, categories.category_small_name').limit(10)
=> Product Load (13.2ms)  SELECT products.*, categories.category_small_name FROM "products" INNER JOIN "categories" ON "categories"."category_small_cd" = "products"."category_small_cd" LIMIT ?  [["LIMIT", 10]]
```

### P-038: 顧客データフレーム（df_customer）とレシート明細データフレーム（df_receipt）から、各顧客ごとの売上金額合計を求めよ。ただし、買い物の実績がない顧客については売上金額を0として表示させること。また、顧客は性別コード（gender_cd）が女性（1）であるものを対象とし、非会員（顧客IDが'Z'から始まるもの）は除外すること。なお、結果は10件だけ表示させれば良い。

```console

# TODO:
```

### P-039: レシート明細データフレーム（df_receipt）から売上日数の多い顧客の上位20件と、売上金額合計の多い顧客の上位20件を抽出し、完全外部結合せよ。ただし、非会員（顧客IDが'Z'から始まるもの）は除外すること。

```console

# TODO:
```

### P-040: 全ての店舗と全ての商品を組み合わせると何件のデータとなるか調査したい。店舗（df_store）と商品（df_product）を直積した件数を計算せよ

```console
df_store_tmp = df_store.copy()
df_product_tmp = df_product.copy()

df_store_tmp['key'] = 0
df_product_tmp['key'] = 0
len(pd.merge(df_store_tmp, df_product_tmp, how='outer', on='key'))

Product.count * Store.count
=> (115.6ms)  SELECT COUNT(*) FROM "products"
   (7.0ms)  SELECT COUNT(*) FROM "stores"
=> 531590
```

### S-041: レシート明細テーブル（receipt）の売上金額（amount）を日付（sales_ymd）ごとに集計し、前日からの売上金額増減を計算せよ。なお、計算結果は10件表示すればよい。

```console

# TODO:
```

### P-042: レシート明細データフレーム（df_receipt）の売上金額（amount）を日付（sales_ymd）ごとに集計し、各日付のデータに対し、１日前、２日前、３日前のデータを結合せよ。結果は10件表示すればよい。

```console

# TODO:
```
### P-043： レシート明細データフレーム（df_receipt）と顧客データフレーム（df_customer）を結合し、性別（gender）と年代（ageから計算）ごとに売上金額（amount）を合計した売上サマリデータフレーム（df_sales_summary）を作成せよ。性別は0が男性、1が女性、9が不明を表すものとする。

ただし、項目構成は年代、女性の売上金額、男性の売上金額、性別不明の売上金額の4項目とすること（縦に年代、横に性別のクロス集計）。また、年代は10歳ごとの階級とすること。

```console

# TODO:
```

### P-044： 前設問で作成した売上サマリデータフレーム（df_sales_summary）は性別の売上を横持ちさせたものであった。このデータフレームから性別を縦持ちさせ、年代、性別コード、売上金額の3項目に変換せよ。ただし、性別コードは男性を'00'、女性を'01'、不明を'99'とする

```console

# TODO:
```

### P-045: 顧客データフレーム（df_customer）の生年月日（birth_day）は日付型（Date）でデータを保有している。これをYYYYMMDD形式の文字列に変換し、顧客ID（customer_id）とともに抽出せよ。データは10件を抽出すれば良い。

```console
pd.concat([df_customer['customer_id'],
          pd.to_datetime(df_customer['birth_day']).dt.strftime('%Y%m%d')],
          axis = 1).head(10)

Customer.select('customer_id, birth_day, strftime("%Y%m%d", birth_day) as birthday').limit(10)
=> Customer Load (6.3ms)  SELECT customer_id, birth_day, strftime("%Y%m%d", birth_day) as birthday FROM "customers" LIMIT ?  [["LIMIT", 10]]
```

postgres なら TO_CHAR(birth_day, 'YYYYMMDD') を使う。

### P-046: 顧客データフレーム（df_customer）の申し込み日（application_date）はYYYYMMDD形式の文字列型でデータを保有している。これを日付型（dateやdatetime）に変換し、顧客ID（customer_id）とともに抽出せよ。データは10件を抽出すれば良い。

```console
pd.concat([df_customer['customer_id'],pd.to_datetime(df_customer['application_date'])], axis=1).head(10)

Customer.select('customer_id, application_date, strftime("%Y%m%d", application_date) as a_date').limit(10)
=> Customer Load (6.6ms)  SELECT customer_id, application_date, strftime("%Y%m%d", application_date) as a_date FROM "customers" LIMIT ?  [["LIMIT", 10]]
```

### P-047: レシート明細データフレーム（df_receipt）の売上日（sales_ymd）はYYYYMMDD形式の数値型でデータを保有している。これを日付型（dateやdatetime）に変換し、レシート番号(receipt_no)、レシートサブ番号（receipt_sub_no）とともに抽出せよ。データは10件を抽出すれば良い。

```console

# TODO:
```

### P-048: レシート明細データフレーム（df_receipt）の売上エポック秒（sales_epoch）は数値型のUNIX秒でデータを保有している。これを日付型（dateやdatetime）に変換し、レシート番号(receipt_no)、レシートサブ番号（receipt_sub_no）とともに抽出せよ。データは10件を抽出すれば良い

```console

# TODO:
```

### P-049: レシート明細データフレーム（df_receipt）の売上エポック秒（sales_epoch）を日付型（timestamp型）に変換し、"年"だけ取り出してレシート番号(receipt_no)、レシートサブ番号（receipt_sub_no）とともに抽出せよ。データは10件を抽出すれば良い。

```console

# TODO:
```

### P-050: レシート明細データフレーム（df_receipt）の売上エポック秒（sales_epoch）を日付型（timestamp型）に変換し、"月"だけ取り出してレシート番号(receipt_no)、レシートサブ番号（receipt_sub_no）とともに抽出せよ。なお、"月"は0埋め2桁で取り出すこと。データは10件を抽出すれば良い。

```console

# TODO:
```

### P-051: レシート明細データフレーム（df_receipt）の売上エポック秒（sales_epoch）を日付型（timestamp型）に変換し、"日"だけ取り出してレシート番号(receipt_no)、レシートサブ番号（receipt_sub_no）とともに抽出せよ。なお、"日"は0埋め2桁で取り出すこと。データは10件を抽出すれば良い。

```console

# TODO:
```

### P-052: レシート明細データフレーム（df_receipt）の売上金額（amount）を顧客ID（customer_id）ごとに合計の上、売上金額合計に対して2000円以下を0、2000円超を1に2値化し、顧客ID、売上金額合計とともに10件表示せよ。ただし、顧客IDが"Z"から始まるのものは非会員を表すため、除外して計算すること。

```console

```

### P-053: 顧客データフレーム（df_customer）の郵便番号（postal_cd）に対し、東京（先頭3桁が100〜209のもの）を1、それ以外のものを0に２値化せよ。さらにレシート明細データフレーム（df_receipt）と結合し、全期間において買い物実績のある顧客数を、作成した2値ごとにカウントせよ。

```console

# TODO:
```

### P-054: 顧客データデータフレーム（df_customer）の住所（address）は、埼玉県、千葉県、東京都、神奈川県のいずれかとなっている。都道府県毎にコード値を作成し、顧客ID、住所とともに抽出せよ。値は埼玉県を11、千葉県を12、東京都を13、神奈川県を14とすること。結果は10件表示させれば良い。

```console
pd.concat([df_customer[['customer_id', 'address']], df_customer['address'].str[0:3].map({'埼玉県': '11',
                                                                           '千葉県':'12',
                                                                           '東京都':'13',
                                                                           '神奈川':'14'})], axis=1).head(10)

sql = <<~SQL.squish
    customer_id,
    address,
    CASE SUBSTR(address,1, 3)
        WHEN '埼玉県' THEN '11'
        WHEN '千葉県' THEN '12'
        WHEN '東京都' THEN '13'
        WHEN '神奈川' THEN '14'
    END AS prefecture_cd
SQL
Customer.select(sql).limit(10)
=>  Customer Load (4.6ms)  SELECT customer_id, address, CASE SUBSTR(address,1, 3) WHEN '埼玉県' THEN '11' WHEN '千葉県' THEN '12' WHEN '東京都' THEN '13' WHEN '神奈川' THEN '14' END AS prefecture_cd FROM "customers" LIMIT ?  [["LIMIT", 10]]
```

### P-055: レシート明細データフレーム（df_receipt）の売上金額（amount）を顧客ID（customer_id）ごとに合計し、その合計金額の四分位点を求めよ。その上で、顧客ごとの売上金額合計に対して以下の基準でカテゴリ値を作成し、顧客ID、売上金額と合計ともに表示せよ。カテゴリ値は上から順に1〜4とする。結果は10件表示させれば良い。

最小値以上第一四分位未満
第一四分位以上第二四分位未満
第二四分位以上第三四分位未満
第三四分位以上

```consoke

# TODO:
```

### P-056: 顧客データフレーム（df_customer）の年齢（age）をもとに10歳刻みで年代を算出し、顧客ID（customer_id）、生年月日（birth_day）とともに抽出せよ。ただし、60歳以上は全て60歳代とすること。年代を表すカテゴリ名は任意とする。先頭10件を表示させればよい。

```console

# TODO:
```

### P-057: 前問題の抽出結果と性別（gender）を組み合わせ、新たに性別×年代の組み合わせを表すカテゴリデータを作成せよ。組み合わせを表すカテゴリの値は任意とする。先頭10件を表示させればよい。

```console

# TODO:
```

### P-058: 顧客データフレーム（df_customer）の性別コード（gender_cd）をダミー変数化し、顧客ID（customer_id）とともに抽出せよ。結果は10件表示させれば良い。

```console

# TODO:
```

### P-059: レシート明細データフレーム（df_receipt）の売上金額（amount）を顧客ID（customer_id）ごとに合計し、合計した売上金額を平均0、標準偏差1に標準化して顧客ID、売上金額合計とともに表示せよ。標準化に使用する標準偏差は、不偏標準偏差と標本標準偏差のどちらでも良いものとする。ただし、顧客IDが"Z"から始まるのものは非会員を表すため、除外して計算すること。結果は10件表示させれば良い。

```console

# TODO:
```

### P-060: レシート明細データフレーム（df_receipt）の売上金額（amount）を顧客ID（customer_id）ごとに合計し、合計した売上金額を最小値0、最大値1に正規化して顧客ID、売上金額合計とともに表示せよ。ただし、顧客IDが"Z"から始まるのものは非会員を表すため、除外して計算すること。結果は10件表示させれば良い。

```console

# TODO:
```