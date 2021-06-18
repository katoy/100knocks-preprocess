require "csv"

INFOS = {
  Customer: '/tmp/data/customer.csv',
  Category: '/tmp/data/category.csv',
  Product: '/tmp/data/product.csv',
  Receipt: '/tmp/data/receipt.csv',
  Store: '/tmp/data/store.csv',
  Geocode: '/tmp/data/geocode.csv'
}.freeze

NUM= 40_000

INFOS.each do |model, path|
  puts model
  ar_model = model.to_s.constantize
  CSV.foreach(path, headers: true).each_slice(NUM) do |rows|
    ar_model.insert_all!(rows.map(&:to_h))
  end
end
