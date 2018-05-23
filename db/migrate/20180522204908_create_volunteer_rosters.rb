class CreateVolunteerRosters < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_rosters do |t|
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :role, null: false
      t.timestamps
    end
  end
end
