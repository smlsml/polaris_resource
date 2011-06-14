module PolarisResource
  module ResponseParsing
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      def response_from_request(request, metadata)
        ActiveSupport::Notifications.instrument('request.polaris_resource', :path => request.path, :params => request.params, :method => request.method, :class => self, :response => request.response) do
          handle_response(request, metadata)
        end
      end
      
      def build_from_response(response)
        content = Yajl::Parser.parse(response.body)['content']
        if content
          if Array === content
            content.collect do |attributes|
              obj = new(attributes)
            end
          else
            obj = new(content)
          end
        end
      end
      
      def handle_response(request, metadata)
        response = request.response
        case response.code
        when 200..299
          build_from_response(response)
        when 404
          raise_not_found(request)
        end
      end
      private :handle_response

      def raise_not_found(request)
        case
        when request.params[:ids]
          raise ResourceNotFound, "Couldn't find all #{model_name.pluralize} with IDs (#{request.params[:ids].join(', ')})"
        when request.params[:id]
          raise ResourceNotFound, "Couldn't find #{model_name} with ID=#{request.params[:id]}"
        else
          raise ResourceNotFound
        end
      end
      private :raise_not_found
      
    end
    
    module InstanceMethods
      
      def build_from_response(response)
        content = Yajl::Parser.parse(response.body)['content']
        merge_attributes(content)
      end
      private :build_from_response
      
    end
  end
end