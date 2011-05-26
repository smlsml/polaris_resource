module Polaris
  module Resource
    class Base
      module Associations

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

      end
    end
  end
end