module PolarisResource
  class ResponseParser

    def initialize(owner, request, metadata)
      @requesting_class = owner
      @request          = request
      @response         = request.response
      @metadata         = metadata
    end

    def self.parse(owner, request, metadata)
      parser = new(owner, request, metadata)

      ActiveSupport::Notifications.instrument('request.polaris_resource', :url => request.url, :params => request.params, :method => request.method, :class => owner, :response => request.response) do
        @parsed_response = parser.parse
      end
      RequestCache.cache.clear unless request.method == :get
      @parsed_response
    end

    def parse
      case @response.code
      when 200..299
        build_from_response
      when 404
        raise_not_found
      when 422
        build_from_response
      when 500.599
        raise ServerError
      when 0
        raise RemoteHostConnectionFailure
      end
    end

    private

    def content
      @content ||= Yajl::Parser.parse(@response.body).try(:[], 'content')
    end
    
    def response_errors
      @response_errors ||= Yajl::Parser.parse(@response.body).try(:[], 'errors')
    end

    def build_from_response
      if content
        if Array === content
          content.collect do |attributes|
            obj = build_object_with_attributes(attributes)
          end
        else
          obj = @requesting_class.new(content)
        end
      end
    end
    
    def build_object_with_attributes(attributes)
      if attributes.keys.include?('type')
        attributes['type'].constantize.new(attributes)
      else
        @requesting_class.new(attributes)
      end
    end

    def raise_not_found
      case
      when @metadata[:ids]
        raise ResourceNotFound, "Couldn't find all #{@requesting_class.to_s.pluralize} with IDs (#{@metadata[:ids].join(', ')})"
      when @metadata[:id]
        raise ResourceNotFound, "Couldn't find #{@requesting_class} with ID=#{@metadata[:id]}"
      else
        raise ResourceNotFound, "No resource was found at #{@request.url} #{response_errors.inspect if response_errors}"
      end
    end

  end
end