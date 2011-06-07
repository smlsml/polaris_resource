module PolarisResource
  module Associations
    class HasOneAssociation < Association
      
      def load_target!
        @association.to_s.classify.constantize.send(:_get, _uri) if @owner.id
      end
      
      def _uri
        "/#{@owner.class.model_name.underscore.pluralize}/#{@owner.id}/#{@association}"
      end
      
    end
  end
end