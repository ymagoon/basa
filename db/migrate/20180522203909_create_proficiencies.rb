class CreateProficiencies < ActiveRecord::Migration[5.2]
  def change
    create_table :proficiencies do |t|
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true
      t.integer :role, null: false
      t.timestamps
    end
  end
end
