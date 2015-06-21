class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.integer :quantity
      t.boolean :returnable, default: true
      t.integer :status, default: 1
      t.timestamps null: false
    end
  end
end
