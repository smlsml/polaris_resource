module PolarisResource
  class Filter
    
    def initialize(name, &block)
      @name  = name
      @block = block
    end
    
    def name
      @name
    end
    
    def call(element)
      @block.call(element)
    end
    
  end
end