class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :image_name
      t.string :encrypted_email
      t.string :encrypted_email_iv
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.string :email
      t.string :password
      t.string :password_confirmation
      t.string :search_key

      t.timestamps
    end
  end
end
