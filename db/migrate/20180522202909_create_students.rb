class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.references :address, foreign_key: true
      t.string :email
      t.string :phone
      t.date :birth_date
      t.integer :gender

      t.timestamps
    end
  end
end
