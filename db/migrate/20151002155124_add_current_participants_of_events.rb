class AddCurrentParticipantsOfEvents < ActiveRecord::Migration
  def change
    add_column :events, :current_participants, :integer
  end
end
