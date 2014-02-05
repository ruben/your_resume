class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.references :profile, index: true

      t.timestamps
    end
  end
end
