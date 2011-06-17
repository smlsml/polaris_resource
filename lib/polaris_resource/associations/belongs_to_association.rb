module PolarisResource
  module Associations
    class BelongsToAssociation < Association
      
      def load_target!
        if association_id = @owner.send("#{@association}_id".to_sym)
          polymorphic_class = @options[:polymorphic] ? @owner.send("#{@association}_type".to_sym).constantize : @options[:class_name].constantize
          polymorphic_class.send(:find, association_id)
        end
      end
      
    end
  end
end