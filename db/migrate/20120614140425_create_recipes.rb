class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name

      t.timestamps
    end
  end
  
  def down
    drop_table :recipes
  end
end
