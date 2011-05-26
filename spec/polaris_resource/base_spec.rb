require 'spec_helper'

describe Polaris::Resource::Base do
  pending
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Associations" do
  
  it "includes the Polaris::Resource::Base::Associations module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Associations)
  end
  
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Attributes" do
  
  it "includes the Polaris::Resource::Base::Attributes module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Attributes)
  end
  
end

describe Polaris::Resource::Base, "implements Polaris::Resource::Base::Finders" do
  
  it "includes the Polaris::Resource::Base::Finders module" do
    Polaris::Resource::Base.included_modules.should include(Polaris::Resource::Base::Finders)
  end
  
end