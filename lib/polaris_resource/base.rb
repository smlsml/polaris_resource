# Serving as the superclass to all resources, PolarisResource::Base
# should be subclassed and extended from within your application.
module PolarisResource
  class Base
    extend  ActiveModel::Naming
    include ActiveModel::Validations
    include ActiveModel::Dirty
    include Associations
    include Attributes
    include Conversion
    include Finders
    include Introspection
    include Persistence
    include Reflections
    include RequestHandling
    include ResponseParsing

    # Defines a default 'id' property on all instances of PolarisResource::Base and subclasses
    property :id, :integer

    def initialize(new_attributes = {})
      new_attributes = HashWithIndifferentAccess.new(new_attributes)
      new_attributes.each do |attribute, value|
        self.class.default_attributes.store(attribute.to_sym, nil) unless self.class.attribute_defined?(attribute)
        update_attribute(attribute, value)
      end
    end

    def ==(comparison_object)      
      comparison_object.equal?(self) ||
        (comparison_object.instance_of?(self.class) && comparison_object.id == id && !comparison_object.new_record?)
    end
    
    def self.base_class
      self
    end
    
    private
    
    def method_missing(m, *args, &block)
      if attributes.keys.include?(m.to_s.delete('='))
        # Defines attribute accessors when the missing method can be found in the attributes hash
        define_attribute_accessor(m)
        send(m, *args, &block)
      else
        super
      end
    end

  end
end