module PolarisResource
  class TypeCaster

    class << self

      def cast(value, typecast_class)
        case typecast_class
        when NilClass
          value
        when :string
          parse_string(value)
        when :integer
          parse_integer(value)
        when :datetime
          parse_datetime(value)
        when :date
          parse_date(value)
        when :time
          parse_time(value)
        when :boolean
          parse_boolean(value)
        else
          raise UnrecognizedTypeCastClass, "Can't typecast to #{typecast_class}!"
        end
      end

      private

      def parse_string(value)
        value.to_s
      end

      def parse_integer(value)
        if value.respond_to?(:to_i)
          value.to_i
        else
          case value
          when TrueClass  then 1
          when FalseClass then 0
          when Date       then value.to_time.utc.to_i
          end
        end
      end

      def parse_datetime(value)
        if value.respond_to?(:to_datetime)
          value.to_datetime
        else
          DateTime.parse(value) unless [TrueClass, FalseClass, NilClass, Fixnum].include?(value.class)
        end
      rescue ArgumentError
        nil
      end

      def parse_date(value)
        if value.respond_to?(:to_time)
          parse_time(value).try(:to_date)
        else
          Date.parse(value) unless [TrueClass, FalseClass, NilClass, Fixnum].include?(value.class)
        end
      end

      def parse_time(value)
        if value.respond_to?(:to_time)
          value.to_time
        else
          Time.parse(value) unless [TrueClass, FalseClass, NilClass, Fixnum].include?(value.class)
        end
      rescue ArgumentError
        nil
      end

      def parse_boolean(value)
        !["nil", nil, "false", false, "0", 0].include?(value)
      end

    end

  end
end