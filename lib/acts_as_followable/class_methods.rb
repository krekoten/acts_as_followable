module ActsAsFollowable
  module ClassMethods
    def acts_as_followable *plugins
      has_many :followed_by_me, :as => :followers, :class_name => 'ActsAsFollowable::Follow'
      has_many :followed_me, :as => :follows, :class_name => 'ActsAsFollowable::Follow'
      
      plugins.each do |plugin|
        _init_plugin plugin
      end
    end
    
    protected
    
    def _init_plugin plugin
      begin
        _plugin = case plugin
        when String, Symbol
          ActsAsFollowable.const_get plugin.to_s.capitalize
        else
          plugin
        end
      
        include _plugin
      rescue NameError
        ActsAsFollowable.logger.error "[ActsAsFollowable] Unknown plugin: #{plugin}"
      end
    end
  end
end