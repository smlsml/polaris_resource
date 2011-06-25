module PolarisResource
  module Associations
    class HasOneAssociation < Association
      
      def load_target!
        @options[:class_name].constantize.get(_uri) if @owner.id
      end
      
      def _uri
        owner_id = @owner.respond_to?(:polaris_id) ? @owner.polaris_id : @owner.id
        "/#{@owner.class.url_name}/#{owner_id}/#{@association}"
      end
      private :_uri
      
    end
  end
end