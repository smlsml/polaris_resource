module PolarisResource
  module Associations
    class HasManyAssociation < Association
      
      def load_target!
        @owner.id ? @association.to_s.classify.constantize.send(:_get, _uri) : []
      end
      
      def _uri
        "/#{@owner.class.model_name.underscore.pluralize}/#{@owner.id}/#{@association.to_s.pluralize}"
      end
      
    end
  end
end