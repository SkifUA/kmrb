class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.integer "user_id"
      t.integer "group_admin_id", default: 1
      t.index ["user_id"], name: "index_admins_on_user_id"
      t.timestamps
    end
  end
end
