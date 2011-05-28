module Polaris
  module Resource
    class Base
      module Associations
        
        def self.included(base)
          base.extend(ClassMethods)
        end
        
        module ClassMethods
          
          def belongs_to(association)
            attribute_id_sym  = "#{association}_id".to_sym
            attribute_uri_sym = "_#{association}_uri".to_sym
            
            property attribute_id_sym, Integer
            
            define_method association do
            end
            
            define_method attribute_uri_sym do
              "/#{association.to_s.pluralize}/#{attributes[attribute_id_sym]}" if attributes[attribute_id_sym]
            end
            private attribute_uri_sym
          end
          
          def has_many(association)
            attribute_uri_sym = "_#{association}_uri".to_sym
            
            define_method association do
            end
            
            define_method attribute_uri_sym do
              "/#{self.class.model_name.underscore.pluralize}/#{id}/#{association.to_s.pluralize}" if id
            end
            private attribute_uri_sym
          end
          
          def has_one(association)
            attribute_uri_sym = "_#{association}_uri".to_sym
            
            define_method association do
            end
            
            define_method attribute_uri_sym do
              "/#{self.class.model_name.underscore.pluralize}/#{id}/#{association}" if id
            end
            private attribute_uri_sym
          end
          
        end

        # def self.belongs_to(name)
        #   attribute_name = "#{name}_id"
        #   property attribute_name.to_sym, Integer
        # 
        #   define_method "_belongs_to_#{name}_uri" do
        #     "#{Polaris::Configuration.host}/#{name.to_s.pluralize}/#{attributes[attribute_name.to_sym]}"
        #   end
        # 
        #   define_method name.to_sym do
        #     response = Typhoeus::Request.get(send("_belongs_to_#{name}_uri".to_sym))
        #     self.class.build_from_response(response)
        #   end
        # end
        # 
        # def self.has_many(name)
        #   define_method "_has_many_#{name}_uri" do
        #     "#{Polaris::Configuration.host}/#{self.class.model_name.underscore}/#{id}/#{name.to_s.pluralize}"
        #   end
        # 
        #   define_method name.to_sym do
        #     response = Typhoeus::Request.get(send("_has_many_#{name}_uri".to_sym))
        #     "Polaris::Client::#{name.to_s.singularize.camelize}".constantize.build_from_response(response)
        #   end
        # end
        # 
        # def self.has_one(name)
        #   define_method "_has_one_#{name}_uri" do
        #     "#{Polaris::Configuration.host}/#{self.class.model_name.underscore}/#{id}/#{name.to_s}"
        #   end
        # 
        #   define_method name.to_sym do
        #     response = Typhoeus::Request.get(send("_has_many_#{name}_uri".to_sym))
        #     "Polaris::Client::#{name.to_s.camelize}".constantize.build_from_response(response)
        #   end
        # end

      end
    end
  end
end