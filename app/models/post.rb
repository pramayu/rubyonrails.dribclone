class Post < ActiveRecord::Base
	acts_as_votable
  acts_as_taggable
	belongs_to :user
	has_many :comments
	has_attached_file :image, styles: { maxlarge: "800x600>", large: "800x600#", medium: "400x300#", thumb: "200x150#", attach: "126x95#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	
  	has_many :impressions, :as=>:impressionable

  	def impression_count
    	impressions.size
  	end

  	def unique_impression_count
    	impressions.group(:ip_address).size #UNTESTED: might not be correct syntax
      #impressionist_count(:filter=>:ip_address).size
      #impressionist_count(:filter=>:session_hash)
      #impressionist_count :unique => [:impressionable_type, :impressionable_id, :session_hash]
  	end
end
