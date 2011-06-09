require 'polaris_resource/base/attributes'
require 'polaris_resource/base/finders'
require 'polaris_resource/base/persistence'

module PolarisResource
  class Base
    extend  ActiveModel::Naming
    include PolarisResource::Associations
    include Attributes
    include Finders
    include Persistence

    property :id
    attr_reader :errors

    def self.build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      if content
        if Array === content
          content.collect do |attributes|
            obj = new.merge_attributes(attributes)
          end
        else
          obj = new.merge_attributes(content)
        end
      end
    end

    def initialize(new_attributes = {})
      @errors = ActiveModel::Errors.new(self)
      
      new_attributes = HashWithIndifferentAccess.new(new_attributes)
      new_attributes.each do |attribute, value|
        self.class.default_attributes.store(attribute.to_sym, nil) unless self.class.attribute_defined?(attribute)
        update_attribute(attribute, value)
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
      !id.nil?
    end
    
    def to_key
      attributes.keys if persisted?
    end

    def build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      merge_attributes(content)
    end

    def new_record?
      !persisted?
    end
    
    def self.base_class
      self
    end

    def destroyed?
      false
    end
    
    def respond_to?(method)
      attributes.include?(method) ? true : super
    end

    def ==(comparison_object)      
      comparison_object.equal?(self) ||
      (comparison_object.instance_of?(self.class) && comparison_object.id == id && !comparison_object.new_record?)
    end
    
    def method_missing(m, *args, &block)
      m_without_equals = m.to_s.delete('=')
      
      if attributes.keys.include?(m_without_equals)
        
        if m.to_s.include?('=')
          self.class.send(:define_method, m) do |value|
            attributes[m_without_equals] = value
          end
        else
          self.class.send(:define_method, m) do
            attributes[m]
          end
        end
        
        send(m, *args, &block)
      else
        super
      end
    end

  end
end