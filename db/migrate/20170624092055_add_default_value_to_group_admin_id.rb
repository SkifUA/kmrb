class AddDefaultValueToGroupAdminId < ActiveRecord::Migration[5.1]
  def up
    change_column_default :admins, :group_admin_id, 1
  end
end
