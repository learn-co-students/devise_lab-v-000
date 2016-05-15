class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, default: 'facebook'
    add_index :users, :provider
    add_column :users, :uid, :string
    add_index :users, :uid
  end
end
