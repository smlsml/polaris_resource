module PolarisResource
  module Associations
    class HasOneAssociation < Association
      
      def initialize(owner, association, target = nil, options = {})
        super
        @options[:foreign_key] = options[:foreign_key] || "#{@owner.class.to_s.underscore}_id".to_sym
        @options[:primary_key] = options[:primary_key] || :id
      end
      
      def load_target!
        @options[:class_name].constantize.get(_uri) if @owner.id
      end
      
      def _uri
        primary_key = @owner.send(@options[:primary_key])
        "/#{@owner.class.plural_url_name}/#{primary_key}/#{@association_class.singular_url_name}"
      end
      private :_uri
      
    end
  end
end