module PolarisClient
  class Railtie < Rails::Railtie

    ActiveRecord::Base.send(:include, PolarisClient::Associations) if defined?(ActiveRecord)

    initializer "polaris_client.configure_request_cache" do |app|
      app.middleware.use PolarisResource::RequestCache
    end

  end
end