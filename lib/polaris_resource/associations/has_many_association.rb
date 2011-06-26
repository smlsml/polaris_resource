module PolarisResource
  module Associations
    class HasManyAssociation < Association
      
      def initialize(owner, association, target = nil, options = {})
        super
        @options[:foreign_key] = options[:foreign_key] || "#{@owner.class.to_s.underscore}_id".to_sym
        @options[:primary_key] = options[:primary_key] || :id
      end
      
      def load_target!
        if primary_key = @owner.send(@options[:primary_key])
          uri = "/#{@owner.class.plural_url_name}/#{primary_key}/#{@association_class.plural_url_name}"
          @options[:class_name].constantize.get(uri)
        else
          []
        end
      end
      
      def where(query_attributes)
        return @mock if @mock
        transform_association_into_relation.where(query_attributes)
      end
      
      def limit(amount)
        return @mock if @mock
        transform_association_into_relation.limit(amount)
      end
      
      def page(page_number)
        return @mock if @mock
        transform_association_into_relation.page(page_number)
      end
      
      def <<(one_of_many)
        @target ||= []
        @target << one_of_many
      end
      
      def transform_association_into_relation
        Relation.new(@association.to_s.classify.constantize).where(@options[:foreign_key] => @owner.send(@options[:primary_key]))
      end
      private :transform_association_into_relation
      
    end
  end
end