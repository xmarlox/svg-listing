class CreateIllustrations < ActiveRecord::Migration[7.0]
  def change
    create_table :illustrations do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :illustrations, :slug, unique: true
  end
end
