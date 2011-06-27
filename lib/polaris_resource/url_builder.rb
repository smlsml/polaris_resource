module PolarisResource
  class UrlBuilder
    
    class << self
      
      def find_one(klass, id)
        "/#{klass.plural_url_name}/#{id}"
      end
      
      def find_some(klass, ids)
        ["/#{klass.plural_url_name}", { :ids => ids }]
      end
      
      def find_all(klass)
        "/#{klass.plural_url_name}"
      end
      
      def belongs_to(klass, id)
        "/#{klass.plural_url_name}/#{id}"
      end
      
      def has_one(primary_class, primary_key, foreign_class)
        "/#{primary_class.plural_url_name}/#{primary_key}/#{foreign_class.singular_url_name}"
      end
      
      def has_many(primary_class, primary_key, foreign_class)
        "/#{primary_class.plural_url_name}/#{primary_key}/#{foreign_class.plural_url_name}"
      end
      
      def relation(klass, parameters = {})
        url_base = "/#{klass.plural_url_name}"
        if parameters.empty?
          url_base
        else
          [url_base, parameters]
        end
      end
      
    end
    
  end
end