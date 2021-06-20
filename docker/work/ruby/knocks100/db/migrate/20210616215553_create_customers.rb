class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers, id: false do |t|
      t.string :customer_id, null: false, primary_key: true
      t.string :customer_name
      t.string :gender_cd
      t.string :gender
      t.date :birth_day
      t.integer :age
      t.string :postal_cd
      t.string :address
      t.string :application_store_cd
      t.string :application_date
      t.string :status_cd
    end
  end
end
