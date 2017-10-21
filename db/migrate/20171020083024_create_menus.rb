class CreateMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :menus, id: false do |t|
      t.integer :id, options: 'PRIMARY KEY', index: true
      t.string :name, index: true
      t.string :sponsor
      t.string :event
      t.string :venue
      t.string :place
      t.string :physical_description
      t.string :occasion
      t.string :notes
      t.string :call_number
      t.string :keywords
      t.string :language
      t.date :date
      t.string :location
      t.string :location_type
      t.string :currency
      t.string :currency_symbol
      t.string :status
      t.integer :page_count
      t.integer :dish_count

      t.timestamps
    end
  end
end
