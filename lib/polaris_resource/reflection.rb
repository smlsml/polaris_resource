module PolarisResource
  class Reflection
    attr_reader :macro, :name, :options

    def initialize(macro, name, options = {})
      @macro, @name, @options = macro, name, options
    end

    def klass
      @klass ||= class_name.constantize
    end

    def class_name
      name.to_s.singularize.camelize
    end

    def build_association(*options)
      klass.new(*options)
    end

  end
end