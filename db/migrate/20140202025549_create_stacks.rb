class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.string :type
      t.integer :times_viewed_today

      t.timestamps
    end
  end
end
