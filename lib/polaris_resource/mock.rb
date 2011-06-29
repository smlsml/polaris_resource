# The Mock class is used to mock out single instances of a remote resource.
# It will stub any requests to /:class_name/:id.
module PolarisResource
  class Mock

    def initialize(mock_class, id, attributes = {}, options = {})
      @mock_class = mock_class.to_s
      @attributes = HashWithIndifferentAccess.new(attributes).merge({ 'id' => id })
      @options    = options

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

    def status
      @options[:status] || 200
    end

    def ==(other_object)
      HashWithIndifferentAccess.new(other_object.attributes) == @attributes && other_object.class.to_s == @mock_class
    end

    def self.mock(mock_class, id, attributes = {}, options = {})
      new(mock_class, id, attributes, options)
    end

    def self.clear!
      Configuration.hydra.clear_stubs
    end

    private

    def stub_finder_methods!
      stub_find_one!
    end

    def stub_find_one!
      response = PolarisResource::Response.new(:code => status, :headers => "", :body => stub_find_one_body, :time => 0.3)
      Configuration.hydra.stub(:get, find_one_uri).and_return(response)
    end

    def stub_find_one_body
      { :status  => status, :content => @attributes.merge({ :id => 1 }) }.to_json
    end

    def find_one_uri
      "#{Configuration.host}/#{@mock_class.underscore.pluralize}/#{id}"
    end

  end
end