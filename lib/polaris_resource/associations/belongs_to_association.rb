module PolarisResource
  module Associations
    class BelongsToAssociation < Association
      
      def load_target!
        if association_id = @owner.send("#{@association}_id".to_sym)
          @association.to_s.classify.constantize.send(:find, association_id)
        end
      end
      
    end
  end
end