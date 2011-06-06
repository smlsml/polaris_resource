module PolarisClient
  class LogSubscriber < ActiveSupport::LogSubscriber

    def request(event)
      debug "#{event.payload[:method].upcase} #{event.payload[:path]} #{event.payload[:params].inspect} [#{event.duration} ms]"
    end
    
    def response(event)
      debug "#{event.payload[:response].code}"
    end

    def logger
      PolarisResource::Configuration.logger
    end

  end
end

PolarisClient::LogSubscriber.attach_to :polaris_resource