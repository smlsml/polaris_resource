module PolarisResource
  module Introspection
    extend ActiveSupport::Concern
    
    module InstanceMethods
      
      def valid?
        true
      end
      
      def persisted?
        !id.nil?
      end
      
      def new_record?
        !persisted?
      end
      
      def destroyed?
        false
      end

      def respond_to?(method)
        attributes.include?(method) ? true : super
      end
      
    end
  end
end