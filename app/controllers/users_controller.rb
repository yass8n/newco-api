class UsersController < ApplicationController
	def index
	end
	def edit_profile
		@current_festival = {}
		@current_festival[:url] =  params[:api_url].strip
		@current_festival[:api_key] =  params[:api_key].strip
	    current_user = {}
		current_user['username'] = params[:username].strip
		current_user['password'] = params[:confirm_password]
		current_user['url'] = params[:url].strip
		current_user['about'] = params[:about].strip
		current_user['position'] =  params[:position].strip
		current_user['company'] = params[:company].strip
		current_user['name'] = params[:name].strip
		current_user['email'] = params[:email].strip 
		current_user['sched_id']  = params[:sched_id].strip 
		current_user['privacy_mode'] = "0"
		current_user['privacy_mode'] = "1" if params[:privacy_mode] == "true"
		@picture = Picture.new
		if (!params[:avatar].nil?)
			@picture.attachment = params[:avatar]
			@picture.name = current_user["sched_id"]
			@picture.user_id = User.all[0]
		    if ( (Picture::is_image(params[:avatar].content_type) && (@picture.save) ) )
				current_user['avatar'] = GlobalConstants::S3_YASEEN_URL + "photos/" + @picture.name + "/" + params[:avatar].original_filename 
			end
		end

		if (current_user["email"] =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i).nil?
			render json: {error: "Invalid email address.", status:"error"}
			return
		end

		basic_result = User.edit_user!(current_user, @picture, @current_festival )

		if  (basic_result.include?("ERR") && !basic_result.include?("ERR: Can't change user's password."))
			render json: {error: basic_result.gsub("ERR: ", ""), status:"error"}
			return
		end

		if (!@picture.id.nil?)
			avatar = User.get_avatar(current_user['username'], @current_festival)["avatar"]
			current_user['avatar'] = avatar
		end
		render json: { user: current_user, status:"success"}
		return
	end
end
