module PolarisClient
  class Railtie < Rails::Railtie

    if defined?(ActiveRecord)
      ActiveRecord::Base.send(:include, PolarisClient::Associations)
      ActiveRecord::Base.send(:include, PolarisResource::UrlSupport)
    end

    initializer "polaris_client.configure_request_cache" do |app|
      app.middleware.use PolarisResource::RequestQueue
      app.middleware.use PolarisResource::RequestCache
    end

    initializer "polaris_resource.configure_logger", :after => :initialize_logger do |app|
      PolarisResource::Configuration.logger = Rails.logger
    end

    initializer "polaris_client.log_subscriber", :after => "polaris_resource.configure_logger" do
      PolarisClient::LogSubscriber.attach_to :polaris_resource
    end

  end

end