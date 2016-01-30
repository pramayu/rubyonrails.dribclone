class AddWebsiteToUser < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :website, :string
    add_column :users, :bio, :text
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :github, :string
    add_column :users, :instagram, :string
    add_column :users, :cm, :string
  end
end
