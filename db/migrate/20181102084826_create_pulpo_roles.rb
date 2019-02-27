class CreatePulpoRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :pulpo_roles do |t|
      t.string :name

      t.timestamps
    end
    add_index :pulpo_roles, :name, unique: true
  end
end
