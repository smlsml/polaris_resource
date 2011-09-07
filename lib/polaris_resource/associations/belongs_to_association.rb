module PolarisResource
  module Associations
    class BelongsToAssociation < Association

      # The initializer calls out to the superclass' initializer, then will set the
      # options particular to itself.
      def initialize(owner, association, settings = {})
        super

        # The foreign key is used to generate the url for a request. The default uses
        # the association name with an '_id' suffix as the generated key. For example,
        # belongs_to :school, will have the foreign key :school_id.
        @options[:foreign_key] ||= "#{@association.to_s}_id".to_sym

        # The primary key defaults to :id.
        @options[:primary_key] ||= :id

        # Associations can be marked as polymorphic. These associations will use
        # the returned type to instantiate the associated object.
        @options[:polymorphic] = settings[:polymorphic] || false
      end

      def with_filter(filter)
        BelongsToAssociation.new(@owner, @association, :target => @target, :filters => @filters.dup.push(filter), :options => @options)
      end

      # When loading the target, the association will only be loaded if the foreign_key
      # has been set. Additionally, the class used to find the record will be inferred
      # by calling the method which is the name of the association with a '_type' suffix.
      # Alternatively, the class name can be set by using the :class_name option.
      def load_target!
        if association_id = @owner.send(@options[:foreign_key])
          polymorphic_class = @options[:polymorphic] ? @owner.send("#{@association}_type".to_sym).constantize : @options[:class_name].constantize
          attributes = [UrlBuilder.belongs_to(polymorphic_class, association_id), nil, { :id => association_id }]
          polymorphic_class.find(association_id)
        end
      end

    end
  end
end