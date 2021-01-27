class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.decimal :price, :precision => 12, :scale => 2
      t.string :category
      t.bigint :menu_id

      t.timestamps
    end
  end
end
