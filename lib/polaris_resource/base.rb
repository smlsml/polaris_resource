require 'polaris_resource/base/associations'
require 'polaris_resource/base/attributes'
require 'polaris_resource/base/finders'
require 'polaris_resource/base/persistence'

module Polaris
  module Resource
    class Base
      include Attributes
      include Associations
      include Finders
      include Persistence

      property :id

      def self.model_name
        self.name.split('::').last
      end
      
      def initialize(new_attributes = {})
        new_attributes = HashWithIndifferentAccess.new(new_attributes)
        attributes.keys.each do |attribute|
          attributes[attribute] = new_attributes[attribute]
        end
      end

      def to_param
        id.to_s if id
      end

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

      # def initialize(new_attributes = {})
      #   self.class.send(:property, :id)
      #   
      #   new_attributes = HashWithIndifferentAccess.new(new_attributes)
      #   attributes.keys.each do |attribute|
      #     attributes[attribute] = new_attributes[attribute]
      #   end
      # end

    end
  end
end