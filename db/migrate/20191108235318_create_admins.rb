class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |a|
      a.string :first_name
      a.string :last_name
      a.string :email
      a.string :google_token
      a.string :google_refresh_token

      #a.string :encrypted_first_name
      #a.string :encrypted_last_name
      #a.string :encrypted_email
      #a.string :encrypted_google_token
      #a.string :encrypted_google_refresh_token
    end
  end
end
