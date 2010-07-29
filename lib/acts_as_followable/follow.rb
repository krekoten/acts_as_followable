module ActsAsFollowable
  class Follow < ActiveRecord::Base
    set_table_name 'follows'
    
    belongs_to :follows, :polymorphic => true
    belongs_to :followers, :polymorphic => true
    
    class << self
      
      # Create following
      def follow follower, follows, options = {}
        create(options.merge({:followers => follower, :follows => follows}))
      end
    end
  end
end