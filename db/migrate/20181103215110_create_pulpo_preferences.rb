class CreatePulpoPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :pulpo_preferences do |t|
      t.text :value
      t.string :key

      t.timestamps
    end
    add_index :pulpo_preferences, :key, unique: true
  end
end
