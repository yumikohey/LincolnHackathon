class AddIndexToPhotofeeds < ActiveRecord::Migration
  def change
  	add_index :photofeeds, :user_id
  	add_index :photofeeds, :amznasin_id
  end
end
