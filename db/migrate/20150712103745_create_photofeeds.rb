class CreatePhotofeeds < ActiveRecord::Migration
  def change
    create_table :photofeeds do |t|
    	t.string :asin
    	t.string :description
    	t.attachment :photo
    	t.references :user
    	t.references :amznasin
      t.timestamps null: false
    end
  end
end
