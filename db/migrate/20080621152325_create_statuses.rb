class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.string :body
      t.integer :author_id
      t.timestamp :created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
