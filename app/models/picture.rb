class Picture < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :user

	def self.is_image(content_type)
		if ( (content_type.include?("jpe")) || (content_type.include?("jpeg")) || (content_type.include?("jpg")) || (content_type.include?("ico")) || (content_type.include?("png")) || (content_type.include?("gif")) )
			return true
		else
			return false
		end
	end
end
