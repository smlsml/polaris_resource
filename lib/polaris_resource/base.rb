module PolarisResource
  class Base
    extend  ActiveModel::Naming
    include Associations
    include Attributes
    include Conversion
    include Finders
    include Introspection
    include Persistence
    include ResponseParsing

    property :id
    attr_reader :errors

    def initialize(new_attributes = {})
      @errors = ActiveModel::Errors.new(self)
      
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