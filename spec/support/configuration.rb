PolarisResource::Configuration.host = 'http://localhost:3000'
PolarisResource::Configuration.hydra = Typhoeus::Hydra.new
PolarisResource::Configuration.allow_net_connect = false

module PolarisResourceHelper
  
  def build_polaris_response(status, content, errors = nil)
    body = {
      :status  => status,
      :content => content
    }
    body.merge!(errors) if errors
    PolarisResource::Response.new(:code => status, :headers => "", :body => body.to_json, :time => 0.3)
  end
  
end

RSpec.configure do |config|
  config.include(PolarisResourceHelper)
  
  config.before(:each) do
    PolarisResource::Configuration.hydra.clear_stubs
    PolarisResource::RequestQueue.queue.clear
    PolarisResource::RequestCache.cache.clear
  end
end