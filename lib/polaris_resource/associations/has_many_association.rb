module PolarisResource
  module Associations
    class HasManyAssociation < Association
      
      def load_target!
        @owner.id ? @association.to_s.classify.constantize.get(_uri) : []
      end
      
      def _uri
        "/#{@owner.class.model_name.underscore.pluralize}/#{@owner.id}/#{@association.to_s.pluralize}"
      end
      private :_uri
      
      def where(query_attributes)
        return @mock if @mock
        transform_association_to_relation.where(query_attributes)
      end
      
      def limit(amount)
        return @mock if @mock
        transform_association_to_relation.limit(amount)
      end
      
      def page(page_number)
        return @mock if @mock
        transform_association_to_relation.page(page_number)
      end
      
      def transform_association_to_relation
        Relation.new(@association.to_s.classify.constantize).where("#{@owner.class.to_s.underscore}_id".to_sym => @owner.id)
      end
      
      def <<(one_of_many)
        @target ||= []
        @target << one_of_many
      end
        
      private :transform_association_to_relation
      
    end
  end
end