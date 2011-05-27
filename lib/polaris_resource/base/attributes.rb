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
            
            # Getter
            define_method name.to_sym do
              attributes[name.to_sym]
            end
            
            # Setter
            define_method "#{name}=".to_sym do |value|
              attributes[name.to_sym] = value
            end
          end
          
          def default_attributes
            @attributes ||= {}
          end

        end
        
        def attributes
          @attributes ||= self.class.default_attributes.dup
        end

      end
    end
  end
end