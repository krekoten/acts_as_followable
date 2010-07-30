module ActsAsFollowable
  module InstanceMethods
    def followable?
      true
    end
    
    # Follows followable object
    def follow followed
      raise ActsAsFollowable::UnfollowableObjectError unless followed.respond_to?(:followable?) && followed.followable?
      following = ActsAsFollowable::Follow.follow self, followed
    end
    
    # Unfollow user
    # Raises ActiveRecord::RecordNotFound if unfollowing user that is not followed
    def unfollow followed
      raise ActsAsFollowable::UnfollowableObjectError unless followed.respond_to?(:followable?) && followed.followable?
      if following = followed_by_me.find_by_follows_id!(followed)
        following.destroy
      end
    end
    
    # Collection of followed objects
    def follows
      followed_by_me
    end
    
    # Collection of objects following us
    def followers
      followed_me
    end
    
    def follows_ids
      ActsAsFollowable::Follow.connection.select_values(
        "SELECT follows_id FROM follows WHERE followers_id = '#{self.id}' AND followers_type = '#{self.class.to_s}'"
      )
    end
    
    def followers_id
      ActsAsFollowable::Follow.connection.select_values(
        "SELECT followers_id FROM follows WHERE follows_id = '#{self.id}' AND follows_type = '#{self.class.to_s}'"
      )
    end
  end
end