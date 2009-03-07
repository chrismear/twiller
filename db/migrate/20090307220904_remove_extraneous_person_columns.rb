class RemoveExtraneousPersonColumns < ActiveRecord::Migration
  def self.up
    remove_column :people, :activation_code
    remove_column :people, :activated_at
    remove_column :people, :state
    remove_column :people, :deleted_at
  end

  def self.down
    add_column :people, :deleted_at, :datetime
    add_column :people, :state, :string,                                    :default => "passive"
    add_column :people, :activated_at, :datetime
    add_column :people, :activation_code, :string,           :limit => 40
  end
end
