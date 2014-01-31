class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :company, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.string :title, null: false
      t.text :summary, null: false
      t.references :profile, index: true

      t.timestamps
    end
  end
end
