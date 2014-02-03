class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.string :content
      t.boolean :in_practice_pile?, default: false
      t.boolean :in_reserve_pile?, default: true
      t.boolean :in_already_learned_pile?, default: true

      t.timestamps
    end
  end
end

