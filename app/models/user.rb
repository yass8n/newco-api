require_dependency 'url_module'

class User < ActiveRecord::Base
	include ApplicationHelper
	include UrlModule
	require 'json'
	require "net/http"
	require "uri"

	def self.edit_user!(user, picture_model, festival)
		if !user["avatar"].nil? and user["avatar"] != ""
			avatar = user["avatar"]
			request = Net::HTTP::Get.new(UrlModule.url_encode("/api/user/mod?api_key=#{festival[:api_key]}&about=#{user["about"]}&url=#{user["url"]}&position=#{user["position"]}&company=#{user["company"]}&full_name=#{user["name"]}&email=#{user["email"]}&location=#{user["location"]}&uid=#{user["sched_id"]}&privacy=#{user["privacy_mode"]}&avatar=#{avatar}"))
			Thread.new do
			    ActiveRecord::Base.connection_pool.with_connection do |conn|
					sleep 30
					#wait 10 seconds then delete the photo from the AWS bucket
					# s3 = AWS::S3.new
					# extension = avatar.split("/")
					# extension = extension[extension.size-2] + "/" + extension[extension.size-1]
					# avatar = s3.buckets[ENV['S3_BUCKET']].objects['photos/' + extension]
					# avatar.delete
					picture_model.destroy #this deletes from our database as well as the s3 instance
				end

			end
		else
			request = Net::HTTP::Get.new(UrlModule.url_encode("/api/user/mod?api_key=#{festival[:api_key]}&about=#{user["about"]}&url=#{user["url"]}&position=#{user["position"]}&company=#{user["company"]}&full_name=#{user["name"]}&email=#{user["email"]}&location=#{user["location"]}&uid=#{user["id"]}&privacy=#{user["privacy_mode"]}"))
		end
		response = UrlModule.getHttp(festival[:url]).request(request)
		return response.body 

	end

	#return Avatar
	def self.get_avatar(username, festival)
		request = Net::HTTP::Get.new(UrlModule.url_encode("/api/user/get?api_key=#{festival[:api_key]}&by=username&term=#{username}&format=json&fields=avatar"))
		response = UrlModule.getHttp(festival[:url]).request(request)
		return "ERR" if response.body.include? "ERR"

		return JSON.parse(response.body)
	end
end