class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name

      t.timestamps
    end
  end
  
  def down
    drop_table :materials
  end
end
