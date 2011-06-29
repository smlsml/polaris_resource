module PolarisClient
  class LogSubscriber < ActiveSupport::LogSubscriber

    def initialize
      super
      @odd_or_even = false
    end

    def request(event)
      debug "  #{event.payload[:response].cached? ? cached_request(event) : uncached_request(event)}"
    end

    def uncached_request(event)
      duration          = event.payload[:response].time * 1000
      request_statement = "#{event.payload[:class].to_s} #{event.payload[:method].to_s.upcase} (#{duration}ms)"
      if odd?
        request_statement = color(request_statement, MAGENTA, true)
        payload           = color(payload(event), nil, true)
      else
        request_statement = color(request_statement, CYAN, true)
        payload           = payload(event)
      end

      response_color = case event.payload[:response].code
      when 200..299 then GREEN
      when 400..599 then RED
      else               YELLOW
      end
      response_statement = color("[#{event.payload[:response].code}]", response_color, true)

      "#{request_statement} #{response_statement} #{payload}"
    end

    def cached_request(event)
      duration          = event.duration
      request_statement = "CACHE (#{duration}ms)"
      if odd?
        request_statement = color(request_statement, MAGENTA, true)
        payload           = color(payload(event), nil, true)
      else
        request_statement = color(request_statement, CYAN, true)
        payload           = payload(event)
      end
      "#{request_statement} #{payload}"
    end

    def payload(event)
      payload  = "#{event.payload[:url]}"
      payload << " #{event.payload[:params].inspect}" unless event.payload[:params].blank?
      payload
    end

    def logger
      PolarisResource::Configuration.logger
    end

    def odd?
      @odd_or_even = !@odd_or_even
    end

  end
end