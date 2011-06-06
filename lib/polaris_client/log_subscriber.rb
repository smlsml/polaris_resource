module PolarisClient
  class LogSubscriber < ActiveSupport::LogSubscriber

    def request(event)
      debug "#{event.inspect}"
    end
    
    def response(event)
      debug "#{event.inspect}"
    end

    def logger
      PolarisResource::Configuration.logger
    end

  end
end

PolarisClient::LogSubscriber.attach_to :polaris_resource