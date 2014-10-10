class CreateActivityTags < ActiveRecord::Migration
  def up
    create_table :activity_tags do |t|
      t.integer :tag_id
      t.integer :activity_id
    end
  end

  def down
    drop_table :activity_tags
  end
end
