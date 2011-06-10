module PolarisResource
  module ResponseParsing
    extend ActiveSupport::Concern
    
    module ClassMethods
      
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
      
      def handle_response(response, id_or_ids = nil)
        case response.code
        when 200..299
          build_from_response(response)
        when 404
          raise_not_found(id_or_ids)
        end
      end
      private :handle_response

      def raise_not_found(id_or_ids)
        case id_or_ids
        when Array
          raise ResourceNotFound, "Couldn't find all #{model_name.pluralize} with IDs (#{id_or_ids.join(', ')})"
        when Integer
          raise ResourceNotFound, "Couldn't find #{model_name} with ID=#{id_or_ids}"
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