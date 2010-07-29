module ActsAsFollowable
  module Friends
    load_dir = File.join(File.dirname(__FILE__), 'friends')

    autoload :ClassMethods,             File.join(load_dir, 'class_methods')
    autoload :InstanceMethods,          File.join(load_dir, 'instance_methods')
    
    def self.included base
      base.send :extend, ClassMethods
      base.send :include, InstanceMethods
    end
  end
end