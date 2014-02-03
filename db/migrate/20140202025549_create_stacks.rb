class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.string :name, default: "reserve"
      t.integer :times_viewed_today, default: 0

      t.timestamps
    end
  end
end
