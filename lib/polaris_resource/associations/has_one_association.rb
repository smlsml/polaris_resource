module PolarisResource
  module Associations
    class HasOneAssociation < Association

      # The initializer calls out to the superclass' initializer and then
      # sets the options particular to itself.
      def initialize(owner, association, settings = {})
        super
        
        # The foreign key is used to generate the url for the association
        # request when the association is transformed into a relation.
        # The default is to use the class of the owner object with an '_id'
        # suffix.
        @options[:foreign_key] ||= "#{@owner.class.to_s.underscore}_id".to_sym

        # The primary key is used in the generated url for the target. It
        # defaults to :id.
        @options[:primary_key] ||= :id
      end

      def with_filter(filter)
        HasOneAssociation.new(@owner, @association, :target => @target, :filters => @filters.dup.push(filter), :options => @options)
      end

      # When loading the target, the primary key is first checked. If the
      # key is nil, then an nil is returned. Otherwise, the target
      # is requested at the generated url. For a has_one :meeting
      # association on a class called Course, the generated url might look
      # like this: /meetings?course_id=1, where the 1 is the primary key.
      def load_target!
        if primary_key = @owner.send(@options[:primary_key])
          Relation.new(@association.to_s.classify.constantize).where(@options[:foreign_key] => primary_key).limit(1).first
        end
      end

    end
  end
end