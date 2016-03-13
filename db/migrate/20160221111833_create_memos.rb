class CreateMemos < ActiveRecord::Migration
  def change
    create_table :memos do |t|
      t.decimal  "lat",   precision: 11, scale: 8
      t.decimal  "long",  precision: 11, scale: 8
      
      t.timestamps null: false
    end
  end
end
