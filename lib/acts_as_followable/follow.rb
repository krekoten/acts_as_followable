module ActsAsFollowable
  class Follow < ActiveRecord::Base
    set_table_name 'follows'
    
    belongs_to :followed, :polymorphic => true
    belongs_to :follower, :polymorphic => true
    
    class << self
      
      # Create following
      def follow follower, followed, options = {}
        create(options.merge({:follower => follower, :followed => followed}))
      end
    end
  end
end