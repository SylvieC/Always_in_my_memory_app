class AddImgurlToCards < ActiveRecord::Migration
  def change
    add_column :cards, :imgurl, :text
  end
end
