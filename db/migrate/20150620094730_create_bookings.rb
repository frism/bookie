class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :item, index: true, foreign_key: true
      t.integer :quantity
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status

      t.timestamps null: false
    end
  end
end
