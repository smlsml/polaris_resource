require 'polaris_resource/base/associations'
require 'polaris_resource/base/attributes'
require 'polaris_resource/base/finders'
require 'polaris_resource/base/persistence'

module PolarisResource
  class Base
    include Attributes
    include Associations
    include Finders
    include Persistence

    property :id

    def self.model_name
      self.name.split('::').last
    end

    def self.build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      if content
        if Array === content 
          content.collect do |attributes|
            new(attributes)
          end
        else
          new(content)
        end
      end
    end

    def initialize(new_attributes = {})
      new_attributes = HashWithIndifferentAccess.new(new_attributes)
      attributes.keys.each do |attribute|
        attributes[attribute] = new_attributes[attribute]
      end
    end

    def to_param
      id.to_s if id
    end

    def build_from_response(response)
      content = Yajl::Parser.parse(response.body)['content']
      merge_attributes(content)
      @new_record = false
    end

    def new_record?
      @new_record.nil? ? true : @new_record
    end

    # def self.build_from_response(response)
    #   if response.success?
    #     content = Yajl::Parser.parse(response.body)['content']
    #     if Array === content
    #       content.collect do |attributes|
    #         new(attributes)
    #       end
    #     else
    #       new(content)
    #     end
    #   else
    #     []
    #   end
    # end

  end
end