module Refinery
  module Blog
    module Admin
      class ChannelsController < ::Refinery::AdminController

        crudify :'refinery/blog/channel',
                :order => 'title ASC'

      end
    end
  end
end
