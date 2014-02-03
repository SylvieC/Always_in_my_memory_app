class AddStackToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :stack, index: true
  end
end
