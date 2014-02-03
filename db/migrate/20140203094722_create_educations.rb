class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name, null: false
      t.string :degree, null: false
      t.string :field_of_study
      t.date :start_date, null: false
      t.date :end_date
      t.references :profile, index: true

      t.timestamps
    end
  end
end
