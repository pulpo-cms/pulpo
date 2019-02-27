class CreatePulpoRoleUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :pulpo_role_users do |t|
      t.references :role, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
