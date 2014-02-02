class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.string :content
      t.string :category
      t.boolean :in_practice_pile?
      t.boolean :in_reserve_pile?
      t.boolean :in_already_learned_pile?
      t.integer :stack_id

      t.timestamps
    end
  end
end
