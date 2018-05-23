class CreateVolunteerRosters < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_rosters do |t|

      t.timestamps
    end
  end
end
