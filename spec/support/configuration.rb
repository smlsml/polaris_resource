PolarisResource::Configuration.host = 'http://localhost:3000'
PolarisResource::Configuration.hydra = Typhoeus::Hydra.new

RSpec.configure do |config|
  config.before(:each) do
    PolarisResource::Configuration.allow_net_connect = false
    PolarisResource::Mock.clear!
  end
end