require 'polaris_resource/base/associations'
require 'polaris_resource/base/attributes'
require 'polaris_resource/base/finders'

module Polaris
  module Resource
    class Base
      include Attributes
      include Associations
      include Finders

      # def self.model_name
      #   self.name.split('::').last
      # end
      # 
      # def self.build_from_response(response)
      #   if response.success?
      #     content = Yajl::Parser.parse(response.body)['content']
      #     if Array === content
      #       content.collect do |attributes|
      #         new(attributes)
      #       end
      #     else
      #       new(content)
      #     end
      #   else
      #     []
      #   end
      # end
      # 
      # def initialize(new_attributes = {})
      #   self.class.send(:property, :id, Integer)
      #   
      #   new_attributes = HashWithIndifferentAccess.new(new_attributes)
      #   attributes.keys.each do |attribute|
      #     attributes[attribute] = new_attributes[attribute]
      #   end
      # end
      # 
      # def to_param
      #   id.to_s
      # end

    end
  end
end