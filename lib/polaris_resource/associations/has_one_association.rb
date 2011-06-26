module PolarisResource
  module Associations
    class HasOneAssociation < Association
      
      def initialize(owner, association, target = nil, options = {})
        super
        @options[:foreign_key] = options[:foreign_key] || "#{@owner.class.to_s.underscore}_id".to_sym
        @options[:primary_key] = options[:primary_key] || :id
      end
      
      def load_target!
        if primary_key = @owner.send(@options[:primary_key])
          uri = "/#{@owner.class.plural_url_name}/#{primary_key}/#{@association_class.singular_url_name}"
          @options[:class_name].constantize.get(uri)
        end
      end
      
    end
  end
end