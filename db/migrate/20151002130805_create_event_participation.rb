class CreateEventParticipation < ActiveRecord::Migration
  def change
    create_table :event_participations do |t|
      t.references :user
      t.references :event
      t.integer :will_participate
    end
  end
end
