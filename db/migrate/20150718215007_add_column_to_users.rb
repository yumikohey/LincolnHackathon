class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :funding, :float, :default => 0
    add_column :users, :visit, :integer, :default => 0
  end
end
