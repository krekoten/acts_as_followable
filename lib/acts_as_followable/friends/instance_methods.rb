module ActsAsFollowable
  module Friends
    module InstanceMethods
      def friends
        followed_by_me.find_all_by_approved true
      end
      
      def friend_ids
        ActsAsFollowable::Follow.connection.select_values("SELECT followers_id FROM follows WHERE follows_id = '#{self.id}' AND follows_type = '#{self.class.to_s}' AND approved = 1")
      end
      
      def become_friend_with friend
        ActsAsFollowable::Follow.follow self, friend, :approved => true
        ActsAsFollowable::Follow.follow friend, self, :approved => true
      end
      
      def request_friendship_with friend
        ActsAsFollowable::Follow.follow self, friend
      end
      
      def pending_friendships_for_me
        followed_me.find_all_by_approved false
      end
      alias :pending_friends_for_me, :pending_friendships_for_me
      
      def pending_friendships_by_me
        followed_by_me.find_all_by_approved false
      end
      alias :pending_friends_by_me, :pending_friendships_by_me
      
      def is_pending_friends_with? friend
        pending_friendships_by_me.include?(friend) || pending_friendships_for_me.include?(friend)
      end
      
      def is_friends_or_pending_with? friend
        friends.include?(friend) || is_pending_friends_with?(friend)
      end
      
      def accept_friendship_with friend
        if friendship = followed_me.find_by_followers_id_and_followers_type_and_approved(friend.id, friend.class.to_s, false)
          ActsAsFollowable::Follow.follow self, friend, :approved => true
        elsif friendship = friend.followed_me.find_by_followers_id_and_followers_type_and_approved(self.id, self.class.to_s, false)
          ActsAsFollowable::Follow.follow friend, self, :approved => true
        else
          raise ActiveRecord::RecordNotFound
        end
        friendship.update_attribute(:approved, true)
      end
      
      def delete_friendship_with friend
        followed_me.find_by_followers_id_and_followers_type!(friend.id, friend.class.to_s).destroy
        friend.followed_me.find_by_followers_id_and_followers_type!(self.id, self.class.to_s).destroy
      end
    end
  end
end