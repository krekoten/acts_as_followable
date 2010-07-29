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
  end
end