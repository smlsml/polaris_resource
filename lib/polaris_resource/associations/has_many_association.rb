module PolarisResource
  module Associations
    class HasManyAssociation < Association
      
      # The initializer calls out to the superclass' initializer and then
      # sets the options particular to itself.
      def initialize(owner, association, target = nil, options = {})
        super
        
        # The foreign key is used to generate the url for the association
        # request when the association is transformed into a relation.
        # The default is to use the class of the owner object with an '_id'
        # suffix.
        @options[:foreign_key] = options[:foreign_key] || "#{@owner.class.to_s.underscore}_id".to_sym
        
        # The primary key is used in the generated url for the target. It
        # defaults to :id.
        @options[:primary_key] = options[:primary_key] || :id
      end
      
      # When loading the target, the primary key is first checked. If the
      # key is nil, then an empty array is returned. Otherwise, the target
      # is requested at the generated url. For a has_many :meetings
      # association on a class called Course, the generated url might look
      # like this: /courses/1/meetings, where the 1 is the primary key.
      def load_target!
        if primary_key = @owner.send(@options[:primary_key])
          uri = "/#{@owner.class.plural_url_name}/#{primary_key}/#{@association_class.plural_url_name}"
          @options[:class_name].constantize.get(uri)
        else
          []
        end
      end
      
      # The where, limit, and page methods delegate to a Relation object.
      # The association generates a relation, and then calls the very
      # same where, limit, or page method on that relation object.
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
      
      def transform_association_into_relation
        Relation.new(@association.to_s.classify.constantize).where(@options[:foreign_key] => @owner.send(@options[:primary_key]))
      end
      private :transform_association_into_relation
      
      # The append operator is used to append new resources to the association.
      def <<(one_of_many)
        @target ||= []
        @target << one_of_many
      end
      
    end
  end
end