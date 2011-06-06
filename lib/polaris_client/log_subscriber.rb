module PolarisClient
  class LogSubscriber < ActiveSupport::LogSubscriber

    def request(event)
      debug "#{event[:method].upcase} #{event[:path]} #{event[:params].inspect} [#{event.duration} ms]"
    end
    
    def response(event)
      debug "#{event[:response].code}"
    end

    def logger
      PolarisResource::Configuration.logger
    end

  end
end

PolarisClient::LogSubscriber.attach_to :polaris_resource