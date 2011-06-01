module PolarisResource
  class TypeCaster
    
    def self.cast(value, typecast_class)
      if typecast_class
        case typecast_class
        when :string
          value.to_s
        when :integer
          value.to_i
        when :datetime
          DateTime.parse(value)
        when :date
          Date.parse(value)
        when :time
          Time.parse(value)
        else
          raise UnrecognizedTypeCastClass, "Can't typecast to #{typecast_class}!"
        end
      else
        value
      end
    end
    
  end
end