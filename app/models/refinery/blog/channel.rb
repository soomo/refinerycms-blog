module Refinery
  module Blog
    class Channel < ActiveRecord::Base
      extend FriendlyId
      friendly_id :slug, :use => [:slugged]

      has_many :posts

      validates :slug, :presence => true, :uniqueness => true

      attr_accessible :slug, :title, :sub_title, :description, :published, :thumbnail_image_id, :id, :in_splitter

      belongs_to :thumbnail_image, :class_name => '::Refinery::Image'

      def post_count
        posts.select(&:live?).count
      end

      # how many items to show per page
      self.per_page = Refinery::Blog.posts_per_page

      # Categories in Channel
      def categories
        category_ids = posts.all.map{ |post| post.category_ids}.flatten.uniq
        Refinery::Blog::Category.where("id IN (?)", category_ids)
      end

    end
  end
end
