class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.string :title
      t.string :type_event
      t.string :description
      t.string :to_bring # money, material
      t.integer :minimum_participants #nullable
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :happen_at
      t.integer :duration # integer like timestamp or datetime?
      t.integer :privacy # private = 1 or public = 0
      t.string :location # google map
    end
  end
end
