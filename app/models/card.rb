class Card < ActiveRecord::Base
	belongs_to :stack
	belongs_to :topic
end
