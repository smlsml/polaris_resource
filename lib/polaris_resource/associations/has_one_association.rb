module PolarisResource
  module Associations
    class HasOneAssociation < Association
      
      def initialize(owner, association, target = nil, options = {})
        super
        @options[:foreign_key] = options[:foreign_key] || "#{@owner.class.to_s.underscore}_id".to_sym
      end
      
      def load_target!
        @options[:class_name].constantize.get(_uri) if @owner.id
      end
      
      def _uri
        owner_id = @owner.respond_to?(:polaris_id) ? @owner.polaris_id : @owner.id
        "/#{@owner.class.plural_url_name}/#{owner_id}/#{@association_class.singular_url_name}"
      end
      private :_uri
      
    end
  end
end