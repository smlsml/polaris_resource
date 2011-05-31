require 'spec_helper'

describe PolarisResource::Response do

  it "wraps a Typhoeus::Response object" do
    @response = PolarisResource::Response.new
    Typhoeus::Response.new.methods.each do |method|
      @response.should respond_to(method.to_sym)
    end
  end

end