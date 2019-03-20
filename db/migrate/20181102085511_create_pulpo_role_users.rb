class CreatePulpoRoleUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :pulpo_role_users do |t|
      t.references :role, foreign_key: { to_table: :pulpo_roles }, index: true
      t.references :user, foreign_key: { to_table: :pulpo_users }, index: true

      t.timestamps
    end
  end
end
