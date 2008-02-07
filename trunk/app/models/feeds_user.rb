class FeedsUser < ActiveRecord::Base
		
	belongs_to :feed
    belongs_to :user

	validates_presence_of   :user_id
	validates_presence_of   :feed_id
	
end
