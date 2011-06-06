module PolarisClient
  class LogSubscriber < ActiveSupport::LogSubscriber

    def request(event)
      debug "  #{color(event.payload[:method].to_s.upcase, BLUE)} #{event.payload[:path]} #{event.payload[:params].inspect} [#{event.duration} ms]"
    end
    
    def response(event)
      debug "  #{color(event.payload[:response].code, GREEN)}"
    end

    def logger
      PolarisResource::Configuration.logger
    end

  end
end

PolarisClient::LogSubscriber.attach_to :polaris_resource