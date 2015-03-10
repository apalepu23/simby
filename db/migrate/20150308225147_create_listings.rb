class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
		t.string :category
		t.string :title
		t.text :description
		t.decimal :price
		t.string :sale_type
		t.integer :user_id
     	t.timestamps
    end

    add_index :listings, :user_id
  end
end
