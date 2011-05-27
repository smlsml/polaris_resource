Polaris::Resource::Configuration.host = 'http://localhost:3000'

RSpec.configure do |config|
  config.before(:each) do
    Polaris::Resource::Configuration.hydra.clear_stubs
  end
end