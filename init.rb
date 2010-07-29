$: << File.join(File.dirname(__FILE__), 'lib')

require 'acts_as_followable'

ActiveRecord::Base.send :include, ActsAsFollowable