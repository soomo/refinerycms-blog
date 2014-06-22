module Refinery
  module Blog
    class CategoriesController < BlogController

      def show
        @category = Refinery::Blog::Category.find(params[:id])
        @channel = Refinery::Blog::Channel.where("slug = ?", params[:channel]).first

        if !@channel.nil?
          @posts = @category.posts.live.includes(:comments, :categories).with_globalize.where("channel_id = ?", @channel.id).page(params[:page])
          @categories = @channel.categories
        else
          error_404
        end
      end

    end
  end
end
