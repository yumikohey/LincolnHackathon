class Photofeed < ActiveRecord::Base
	belongs_to :user
	belongs_to :amznasin
	has_attached_file :photo
	validates_attachment :photo, :presence => true,
  :content_type => { :content_type => /\Aimage\/.*\Z/ },
  :size => { :in => 0..1000.kilobytes }
end
