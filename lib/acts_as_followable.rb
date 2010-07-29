module ActsAsFollowable
  
  class UnfollowableObjectError < StandardError; end
  
  load_dir = File.join(File.dirname(__FILE__), 'acts_as_followable')

  autoload :ClassMethods,             File.join(load_dir, 'class_methods')
  autoload :InstanceMethods,          File.join(load_dir, 'instance_methods')
  autoload :Follow,                   File.join(load_dir, 'follow')
  autoload :Friends,                  File.join(load_dir, 'friends')
  
  class << self
    def included base
      base.send :extend, ClassMethods
      base.send :include, InstanceMethods
    end
    
    attr_writer :logger
    
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end