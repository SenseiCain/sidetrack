class CreateJoinTablePostCategory < ActiveRecord::Migration[6.0]
  def change
    create_table :posts_categories do |t|
      t.integer "post_id", null: false
      t.integer "category_id", null: false
    end
  end
end
