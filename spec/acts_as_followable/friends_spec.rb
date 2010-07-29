require 'spec_helper'

module ActsAsFollowable
  describe Friends do
    describe 'when user3 requests friendship with user4' do
      before :all do
        @user3.request_friendship_with @user4
      end
      
      it 'user3 should have 1 pending friendships' do
        @user3.should have(1).pending_friendships_by_me
      end
      
      it 'user3 should have 0 friends' do
        @user3.should have(0).friends
      end
      
      it 'user4 should have 1 pending friendship request' do
        @user4.should have(1).pending_friendships_for_me
      end
      
      it 'user4 should have 0 friends' do
        @user4.should have(0).friends
      end
      
      describe 'and user4 accepts friendship request' do
        before :all do
          @user4.accept_friendship_with @user3
        end
        
        it 'than user3 should have 1 friend' do
          @user3.should have(1).friends
        end
        
        it 'than user4 should have 1 friend' do
          @user4.should have(1).friend
        end
        
        describe 'and than user4 delete friendship with user3' do
          before :all do
            @user4.delete_friendship_with @user3
          end
          
          it 'than user4 shoud have 0 friends' do
            @user4.should have(0).friend
          end
          
          it 'than user3 shoud have 0 friends' do
            @user3.should have(0).friend
          end
        end
      end
    end
  end
end