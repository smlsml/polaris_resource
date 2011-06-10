module PolarisResource
  module ResponseParsing
    extend ActiveSupport::Concern
    
    module ClassMethods
      
      def build_from_response(response)
        content = Yajl::Parser.parse(response.body)['content']
        if content
          if Array === content
            content.collect do |attributes|
              obj = new.merge_attributes(attributes)
            end
          else
            obj = new.merge_attributes(content)
          end
        end
      end
      
    end
    
    module InstanceMethods
      
      def build_from_response(response)
        content = Yajl::Parser.parse(response.body)['content']
        merge_attributes(content)
      end
      
    end
  end
end