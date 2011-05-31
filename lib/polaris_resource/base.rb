require 'polaris_resource/base/associations'
require 'polaris_resource/base/attributes'
require 'polaris_resource/base/finders'
require 'polaris_resource/base/persistence'

module PolarisResource
  class Base
    extend  ActiveModel::Naming
    include ActiveModel::Validations
    include Attributes
    include Associations
    include Finders
    include Persistence

    property :id

    def self.build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      if content
        if Array === content
          content.collect do |attributes|
            obj = new
            obj.merge_attributes(attributes)
            obj
          end
        else
          obj = new
          obj.merge_attributes(content)
          obj
        end
      end
    end

    def initialize(new_attributes = {})
      new_attributes = HashWithIndifferentAccess.new(new_attributes)
      attributes.keys.each do |attribute|
        attributes[attribute] = new_attributes[attribute] unless attribute.to_sym == :id
      end
    end

    def to_model
      self
    end

    def to_param
      id.to_s unless new_record?
    end

    def errors
      obj = Object.new
      def obj.[](key)
        []
      end
      def obj.full_messages()
        []
      end
      obj
    end
    
    def valid?
      true
    end
    
    def persisted?
      true
    end
    
    def to_key
      attributes.keys if persisted?
    end

    def build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      merge_attributes(content)
    end

    def new_record?
      id.nil?
    end

    def ==(comparison_object)      
      comparison_object.equal?(self) ||
      (comparison_object.instance_of?(self.class) && comparison_object.id == id && !comparison_object.new_record?)
    end

  end
end