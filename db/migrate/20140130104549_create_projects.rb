class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :description, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.references :profile, index: true

      t.timestamps
    end
  end
end
