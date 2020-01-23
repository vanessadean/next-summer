class AddPhotoToUser < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :photo_url, :string
  end

  def down
    remove_column :users, :photo_url, :string
  end
end
