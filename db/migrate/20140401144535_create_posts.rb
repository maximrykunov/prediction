class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :name
      t.string :content
      t.datetime :event_date

      t.timestamps
    end
  end
end
