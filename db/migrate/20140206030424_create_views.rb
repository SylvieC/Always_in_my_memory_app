class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :value

      t.timestamps
    end
  end
end
