# Serving as the superclass to all resources, PolarisResource::Base
# should be subclassed and extended from within your application.
# The Base class consists of the main components one would need to
# use the PolarisResource API. The behavior of the class is contained
# in several module 'mix-ins'. Each of these modules will be explained
# within itself. Just know that the Base class includes these modules
# for you.
module PolarisResource
  class Base
    extend  ActiveModel::Naming
    include ActiveModel::Validations
    include ActiveModel::Dirty
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml

    # These modules wrap distinct behavior that is used within the Base class.
    # In many cases they rely upon other classes in the library to complete
    # their functionality. The helper classes can be used stand-alone, but
    # are most effective when used as collaborators to the mix-in behaviors.
    include Associations
    include Attributes
    include Conversion
    include Filtering
    include Finders
    include Introspection
    include Persistence
    include Reflections
    include RequestHandling
    include ResponseParsing
    include UrlSupport

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
        self.class.send(:define_attribute_accessor, m)
        send(m, *args, &block)
      else
        super
      end
    end

  end
end