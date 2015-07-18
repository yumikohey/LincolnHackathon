class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :account_type
      t.float :cashback
      t.integer :click
      t.integer :feed
      t.string :link
      t.string :description, :default => 'We love Fashion.'

      t.timestamps null: false
    end
  end
end
