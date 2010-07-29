$: << File.expand_path(File.join(File.dirname(__FILE__), '..'))
require 'rubygems'
require 'spec'
require 'active_record'

require 'init'

Spec::Runner.configure do |config|
  config.before :suite do
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => ':memory:'
    )
    
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    
    load 'db/schema.rb'
    
    User = Class.new(ActiveRecord::Base)
    User.acts_as_followable :friends
    
    Unfollowable = Class.new(ActiveRecord::Base)
    Unfollowable.set_table_name 'users'
    @unfollowable = Unfollowable.create(:login => 'unfollowable_user')
  end

  config.before :all do
    (1..5).each do |i|
      instance_eval %{
        @user#{i} ||= User.create(:login => 'user#{i}')
      }
    end
  end
end
