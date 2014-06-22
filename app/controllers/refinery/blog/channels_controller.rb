module Refinery
	module Blog
		class ChannelsController < BlogController

			def index
				@page = Refinery::Page.find_by_slug("blogs")
				@channels = Refinery::Blog::Channel.where("published = ? and in_splitter = ?", true, true)
			end

			def show
				@channel = Refinery::Blog::Channel.where("slug = ? and published = ?", params[:channel], true).first

				if !@channel.nil?
					@posts = @channel.posts.live.includes(:comments, :categories).page(params[:page])
					@categories = @channel.categories
			else
				error_404
			end
			end

		end
	end
end
