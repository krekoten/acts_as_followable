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
      if following = followed_by_me.find_by_followed_id!(followed)
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
        "SELECT followed_id FROM followed WHERE follower_id = '#{self.id}' AND follower_type = '#{self.class.to_s}'"
      )
    end
    
    def followers_ids
      ActsAsFollowable::Follow.connection.select_values(
        "SELECT follower_id FROM followed WHERE followed_id = '#{self.id}' AND followed_type = '#{self.class.to_s}'"
      )
    end
  end
end