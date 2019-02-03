class CreateOutlets < ActiveRecord::Migration[5.2]
  def change
    create_table :outlets do |t|
  	  t.string :outlet_name
  	  t.text :imageurl
  	  t.text :siteurl
  	  t.integer :total_records
      t.timestamps
    end

	add_index :outlets, :outlet_name
  end
end
