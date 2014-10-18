class AddPhotoToUser < ActiveRecord::Migration
  def up
    add_column :users, :photo_url, :string
  end

  def down
    remove_column :users, :photo_url, :string
  end
end
