class AddMaximumParticipantsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :maximum_participants, :integer
  end
end
