class CreateActivities < ActiveRecord::Migration
  def up
    create_table :activities do |t|
      t.string :description
      t.string :link
    end
  end

  def down
    drop_table :activities
  end
end
