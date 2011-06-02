require 'polaris_resource/base/associations'
require 'polaris_resource/base/attributes'
require 'polaris_resource/base/finders'
require 'polaris_resource/base/persistence'

module PolarisResource
  class Base
    extend  ActiveModel::Naming
    include Attributes
    include Associations
    include Finders
    include Persistence

    property :id
    attr_reader :errors

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
      @errors = ActiveModel::Errors.new(self)
      
      new_attributes = HashWithIndifferentAccess.new(new_attributes)
      attributes.keys.each do |attribute|
        attributes[attribute] = new_attributes[attribute]
      end
    end

    def to_model
      self
    end

    def to_param
      id.to_s unless new_record?
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
    
    def method_missing(m, *args, &block)
      if @attributes.keys.include?(m.to_s)
        define_method m do
          @attributes[m]
        end
        
        define_method "#{m}=" do |value|
          @attributes[m] = value
        end
      else
        super
      end
    end

  end
end