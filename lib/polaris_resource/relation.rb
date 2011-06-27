module PolarisResource
  class Relation < ActiveSupport::BasicObject
    
    def initialize(owner)
      @owner  = owner
      @target = nil
      @params = {}
    end
    
    def where(attributes)
      @params.merge!(attributes)
      self
    end
    
    def limit(amount)
      @params.merge!(:limit => amount)
      self
    end
    
    def page(page_number)
      offset = (page_number - 1) * @owner.results_per_page
      @params.merge!(:limit => @owner.results_per_page, :offset => offset)
      self
    end
    
    def all
      loaded_target
    end
    
    def to_a
      loaded_target
    end
    
    def to_json(*args)
      to_a.to_json(*args)
    end
    
    private
    
    def loaded_target
      @target ||= load_target!
    end
    
    def load_target!
      @owner.get(@owner.find_all_uri, @params)
    end
    
    def method_missing(m, *args, &block)
      if Array.method_defined?(m)
        loaded_target.send(m, *args, &block)
      elsif loaded_target.respond_to?(m)
        loaded_target.send(m, *args, &block)
      else
        super
      end
    end
    
  end
end