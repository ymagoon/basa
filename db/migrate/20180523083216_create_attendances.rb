class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :student, foreign_key: true
      t.references :session, foreign_key: true
      t.integer :present, default: 0

      t.timestamps
    end
  end
end
