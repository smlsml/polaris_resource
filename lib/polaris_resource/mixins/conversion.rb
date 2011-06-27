module PolarisResource
  module Conversion
    extend ActiveSupport::Concern

    module InstanceMethods

      def to_model
        self
      end

      def to_param
        id.to_s unless new_record?
      end

      def to_key
        attributes.keys if persisted?
      end

    end
  end
end