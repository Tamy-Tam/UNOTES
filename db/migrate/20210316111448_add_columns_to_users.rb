class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :github_account, :string
    add_column :users, :linkedin_account, :string
    add_column :users, :photo, :string
  end
end
