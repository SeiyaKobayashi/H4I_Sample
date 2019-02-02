class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :year
      t.string :major
      t.text :Q1
      t.text :Q2
      t.text :Q3
      t.text :Q4
      t.text :Q5
      t.text :Q6

      t.timestamps
    end
  end
end
