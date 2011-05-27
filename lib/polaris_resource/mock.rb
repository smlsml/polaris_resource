module Polaris
  module Resource
    class Mock

      def initialize(mock_class, id, attributes = {})
        @mock_class = mock_class.to_s
        @attributes = HashWithIndifferentAccess.new(attributes).merge({ 'id' => id })
        
        @attributes.keys.each do |attribute|
          (class << self; self; end).class_eval do
            define_method attribute do
              @attributes[attribute]
            end
            
            define_method "#{attribute}=" do |value|
              @attributes[attribute] = value
            end
          end
        end
        
        stub_finder_methods!
      end

      def id
        @attributes[:id]
      end

      def self.mock(mock_class, id)
        new(mock_class, id)
      end
      
      private
      
      def stub_finder_methods!
        stub_find_one!
      end
      
      def stub_find_one!
        response = Typhoeus::Response.new(:code => 200, :headers => "", :body => @attributes.merge({ :id => 1 }).to_json, :time => 0.3)
        Polaris::Resource::Configuration.hydra.stub(:get, find_one_uri).and_return(response)
      end
      
      def find_one_uri
        "#{Polaris::Resource::Configuration.host}/#{@mock_class.underscore.pluralize}/#{id}"
      end

    end
  end
end