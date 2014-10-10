class CreateUserActivities < ActiveRecord::Migration
  def up
    create_table :user_activities do |t|
      t.integer :user_id
      t.integer :activity_id
      t.boolean :done
    end
  end

  def down
    drop_table :user_activities
  end
end
