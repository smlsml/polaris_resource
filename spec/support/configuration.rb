Polaris::Resource::Configuration.host = 'http://localhost:3000'
Polaris::Resource::Configuration.hydra = Typhoeus::Hydra.new

RSpec.configure do |config|
  config.before(:each) do
    Polaris::Resource::Configuration.allow_net_connect = false
    Polaris::Resource::Mock.clear!
  end
end