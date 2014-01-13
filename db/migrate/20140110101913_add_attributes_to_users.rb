class AddAttributesToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :first_name
      t.string :last_name
      t.string :uid
      t.string :access_token
      t.timestamp :expires_at
    end
  end
end
