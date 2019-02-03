class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :description
	  t.text :source_id
      t.text :outlet_name
      t.text :author
      t.text :title
      t.text :url
      t.text :urltoimage
      t.timestamp :published_at
      t.integer :record_number

      t.references :outlet, foreign_key: true
      t.timestamps
    end
	
	add_index :articles, [:outlet_name, :published_at]
	add_index :articles, :url, unique: true
  end
end
