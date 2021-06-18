# レッスン

##　起動

python は http://localhost:8888  
ruby は docke-compos run -rm app bash してから bin/rails c  

## 課題

1. P-001: レシート明細のデータフレーム（df_receipt）から全項目の先頭10件を表示し、どのようなデータを保有しているか目視で確認せよ。

```
df_receipt.head(10)
df_receipt[:10]

Receipt.limit(10)
=> SELECT "receipts".* FROM "receipts" LIMIT ?  [["LIMIT", 10]]
```

2. P-002: レシート明細のデータフレーム（df_receipt）から売上日（sales_ymd）、顧客ID（customer_id）、商品コード（product_cd）、売上金額（amount）の順に列を指定し、10件表示させよ

```
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']].head(10)
df_receipt[['sales_ymd', 'customer_id', 'product_cd', 'amount']][:10]

Receipt.select(:sales_ymd, :customer_id, :product_cd, :amount).limit(10)
=> SELECT "receipts"."sales_ymd", "receipts"."customer_id", "receipts"."product_cd", "receipts"."amount" FROM "receipts" LIMIT ?  [["LIMIT", 10]]
```

