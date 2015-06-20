class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.integer :quantity
      t.integer :status

      t.timestamps null: false
    end
  end
end
