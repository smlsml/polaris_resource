module Polaris
  module Resource
    class Base
      module Attributes

        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods

          def property(name, klass)
            default_attributes.store(name.to_sym, nil)
            
            define_method name.to_sym do
              attributes[name.to_sym]
            end
            
            define_method "#{name}=".to_sym do |value|
              attributes[name.to_sym] = value
            end
          end
          
          def default_attributes
            @attributes ||= HashWithIndifferentAccess.new(superclass.respond_to?(:default_attributes) ? superclass.default_attributes : {})
          end

        end
        
        def attributes
          @attributes ||= self.class.default_attributes.dup
        end

      end
    end
  end
end