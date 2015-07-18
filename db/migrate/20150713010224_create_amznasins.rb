class CreateAmznasins < ActiveRecord::Migration
  def change
    create_table :amznasins do |t|
    	t.string :asin
      t.timestamps null: false
    end
  end
end
