module PolarisResource
  class Request
    
    def self.get(path, params = {})
      response = Typhoeus::Request.get(build_path(path), params)
      PolarisResource::Response.new(response)
    end

    def self.post(path, params = {})
      response = Typhoeus::Request.post(build_path(path), params)
      PolarisResource::Response.new(response)
    end

    def self.put(path, params = {})
      response = Typhoeus::Request.put(build_path(path), params)
      PolarisResource::Response.new(response)
    end
    
    def self.build_path(path)
      "#{PolarisResource::Configuration.host}#{path}"
    end
    
  end
end