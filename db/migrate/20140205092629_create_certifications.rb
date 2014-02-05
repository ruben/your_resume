class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :name
      t.references :profile, index: true

      t.timestamps
    end
  end
end
