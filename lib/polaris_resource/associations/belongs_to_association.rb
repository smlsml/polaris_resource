module PolarisResource
  module Associations
    class BelongsToAssociation < Association
      
      def load_target!
        if association_id = @owner.send("#{@association}_id".to_sym)
          klass = @options[:polymorphic] ? @owner.send("#{@association}_type".to_sym).constantize : @association.to_s.classify.constantize
          klass.send(:find, association_id)
        end
      end
      
    end
  end
end