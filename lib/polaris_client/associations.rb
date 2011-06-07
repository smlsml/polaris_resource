module PolarisClient
  module Associations
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def belongs_to_resource(association_id)
        klass = association_id.to_s.classify
        module_eval <<-"end_eval"
        def #{association_id.to_s}
          @#{association_id} ||= '#{klass}'.constantize.find(self.#{association_id}_id) rescue nil
        end

        def #{association_id.to_s}=(_object)
          self.#{association_id}_id = _object.id rescue nil
          @#{association_id} = _object
        end
        end_eval
      end

    end
  end
end