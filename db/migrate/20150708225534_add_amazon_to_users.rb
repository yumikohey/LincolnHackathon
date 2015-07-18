class AddAmazonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :amzn_email, :string
    add_column :users, :real_name, :string
    add_column :users, :oauth_token, :string
  end
end
