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
        parser.parse
      end
    end

    def parse
      case @response.code
      when 200..299
        build_from_response
      when 404
        raise_not_found
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

    def build_from_response
      if content
        if Array === content
          content.collect do |attributes|
            obj = @requesting_class.new(attributes)
          end
        else
          obj = @requesting_class.new(content)
        end
      end
    end

    def raise_not_found
      case
      when @metadata[:ids]
        raise ResourceNotFound, "Couldn't find all #{@requesting_class.to_s.pluralize} with IDs (#{@metadata[:ids].join(', ')})"
      when @metadata[:id]
        raise ResourceNotFound, "Couldn't find #{@requesting_class} with ID=#{@metadata[:id]}"
      else
        raise ResourceNotFound, "No resource was found at #{@request.url}"
      end
    end

  end
end