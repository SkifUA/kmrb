class CreateGroupAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :group_admins do |t|
      t.string "name"
      t.integer "user", default: 1
      t.integer "admin", default: 1
      t.integer "group_admin", default: 0
      t.timestamps
    end
  end
end
