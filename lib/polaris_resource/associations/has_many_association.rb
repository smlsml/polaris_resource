module PolarisResource
  module Associations
    class HasManyAssociation < Association
      
      def load_target!
        @owner.id ? @options[:class_name].constantize.get(_uri) : []
      end
      
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
      
      def <<(one_of_many)
        @target ||= []
        @target << one_of_many
      end
      
      def transform_association_to_relation
        Relation.new(@association.to_s.classify.constantize).where(@options[:foreign_key] => @owner.id)
      end
      private :transform_association_to_relation
      
      def _uri
        owner_id = @owner.respond_to?(:polaris_id) ? @owner.polaris_id : @owner.id
        "/#{@owner.class.plural_url_name}/#{owner_id}/#{@association_class.plural_url_name}"
      end
      private :_uri
      
    end
  end
end