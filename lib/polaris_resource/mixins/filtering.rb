module PolarisResource
  module Filtering
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      def filter(name, &block)
        (@filters ||= []) << Filter.new(name, &block)
      end
      
      def find_filter(name)
        (@filters ||= []).find { |filter| filter.name == name }
      end
      
    end
    
  end
end