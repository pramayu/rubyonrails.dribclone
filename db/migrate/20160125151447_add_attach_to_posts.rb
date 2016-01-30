class AddAttachToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :attach, :boolean
  end
end
