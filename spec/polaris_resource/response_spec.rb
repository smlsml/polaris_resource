require 'spec_helper'

describe PolarisResource::Response, ".cached?" do
  pending
end

describe PolarisResource::Response, ".respond_to?" do
  pending
end

describe PolarisResource::Response, ".method_missing" do

  it "wraps a Typhoeus::Response object" do
    @response = PolarisResource::Response.new
    Typhoeus::Response.new.methods.each do |method|
      @response.should respond_to(method.to_sym)
    end
  end

end