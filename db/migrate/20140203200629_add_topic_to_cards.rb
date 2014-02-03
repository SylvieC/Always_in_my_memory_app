class AddTopicToCards < ActiveRecord::Migration
  def change
    add_reference :cards, :topic, index: true
  end
end
