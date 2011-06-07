require 'spec_helper'

describe PolarisResource::TypeCaster, "#cast" do

  context "when the type_class is nil" do

    it "casts 'hello' to 'hello'" do
      PolarisResource::TypeCaster.cast('hello', nil).should eql('hello')
    end

    it "casts '2011-04-10' to '2011-04-10'" do
      PolarisResource::TypeCaster.cast('2011-04-10', nil).should eql('2011-04-10')
    end

    it "cast '3' to '3'" do
      PolarisResource::TypeCaster.cast('3', nil).should eql('3')
    end

    it "casts '10-04-2011T05:00:00Z' to '10-04-2011T05:00:00Z'" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', nil).should eql('10-04-2011T05:00:00Z')
    end

    it "casts 'true' to 'true'" do
      PolarisResource::TypeCaster.cast('true', nil).should eql('true')
    end

    it "casts 4 to 4" do
      PolarisResource::TypeCaster.cast(4, nil).should eql(4)
    end

    it "casts true to true" do
      PolarisResource::TypeCaster.cast(true, nil).should eql(true)
    end

    it "cast DateTime to DateTime" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), nil).should eql(DateTime.parse('10-04-2011T05:00:00Z'))
    end

    it "casts Date to Date" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), nil).should eql(Date.parse('2011-04-10'))
    end

    it "casts Time to Time" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), nil).should eql(Time.parse('10-04-2011T05:00:00Z'))
    end

  end

  context "when the type_class is String" do

    it "casts 'hello' to 'hello'" do
      PolarisResource::TypeCaster.cast('hello', :string).should eql('hello')
    end

    it "casts '2011-04-10' to '2011-04-10'" do
      PolarisResource::TypeCaster.cast('2011-04-10', :string).should eql('2011-04-10')
    end

    it "cast '3' to '3'" do
      PolarisResource::TypeCaster.cast('3', :string).should eql('3')
    end

    it "casts '10-04-2011T05:00:00Z' to '10-04-2011T05:00:00Z'" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', :string).should eql('10-04-2011T05:00:00Z')
    end

    it "casts 'true' to 'true'" do
      PolarisResource::TypeCaster.cast('true', :string).should eql('true')
    end

    it "casts 4 to '4'" do
      PolarisResource::TypeCaster.cast(4, :string).should eql('4')
    end

    it "casts true to 'true'" do
      PolarisResource::TypeCaster.cast(true, :string).should eql('true')
    end

    it "cast DateTime to '10-04-2011T05:00:00Z'" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), :string).should eql('2011-04-10T05:00:00+00:00')
    end

    it "casts Date to '2011-04-10'" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), :string).should eql('2011-04-10')
    end

    it "casts Time to '10-04-2011T05:00:00Z'" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), :string).should eql('Sun Apr 10 05:00:00 UTC 2011')
    end

  end

  context "when the type_class is Integer" do

    it "casts 'hello' to 0" do
      PolarisResource::TypeCaster.cast('hello', :integer).should eql(0)
    end

    it "casts '2011-04-10' to 10" do
      PolarisResource::TypeCaster.cast('2011-04-10', :integer).should eql(2011)
    end

    it "cast '3' to 3" do
      PolarisResource::TypeCaster.cast('3', :integer).should eql(3)
    end

    it "casts '10-04-2011T05:00:00Z' to 10" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', :integer).should eql(10)
    end

    it "casts 'true' to 0" do
      PolarisResource::TypeCaster.cast('true', :integer).should eql(0)
    end

    it "casts 4 to 4" do
      PolarisResource::TypeCaster.cast(4, :integer).should eql(4)
    end

    it "casts true to 1" do
      PolarisResource::TypeCaster.cast(true, :integer).should eql(1)
    end

    it "casts false to 0" do
      PolarisResource::TypeCaster.cast(false, :integer).should eql(0)
    end

    it "cast DateTime to 1302411600" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), :integer).should eql(1302411600)
    end

    it "casts Date to 1302393600" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), :integer).should eql(1302418800)
    end

    it "casts Time to 1302411600" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), :integer).should eql(1302411600)
    end

  end

  context "when the type_class is DateTime" do

    it "casts 'hello' to nil" do
      PolarisResource::TypeCaster.cast('hello', :datetime).should eql(nil)
    end

    it "casts '2011-04-10' to DateTime" do
      PolarisResource::TypeCaster.cast('2011-04-10', :datetime).should eql(DateTime.parse('2011-04-10'))
    end

    it "cast '3' to nil" do
      PolarisResource::TypeCaster.cast('3', :datetime).should eql(nil)
    end

    it "casts '10-04-2011T05:00:00Z' to DateTime" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', :datetime).should eql(DateTime.parse('10-04-2011T05:00:00Z'))
    end

    it "casts 'true' to nil" do
      PolarisResource::TypeCaster.cast('true', :datetime).should eql(nil)
    end

    it "casts 4 to nil" do
      PolarisResource::TypeCaster.cast(4, :datetime).should eql(nil)
    end

    it "casts true to nil" do
      PolarisResource::TypeCaster.cast(true, :datetime).should eql(nil)
    end

    it "cast DateTime to DateTime" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), :datetime).should eql(DateTime.parse('10-04-2011T05:00:00Z'))
    end

    it "casts Date to DateTime" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), :datetime).should eql(DateTime.parse('2011-04-10'))
    end

    it "casts Time to DateTime" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), :datetime).should eql(DateTime.parse('10-04-2011T05:00:00Z'))
    end

  end

  context "when the type_class is Date" do

    it "casts 'hello' to nil" do
      PolarisResource::TypeCaster.cast('hello', :date).should eql(nil)
    end

    it "casts '2011-04-10' to Date" do
      PolarisResource::TypeCaster.cast('2011-04-10', :date).should eql(Date.parse('10-04-2011'))
    end

    it "cast '3' to nil" do
      PolarisResource::TypeCaster.cast('3', :date).should eql(nil)
    end

    it "casts '10-04-2011T05:00:00Z' to Date" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', :date).should eql(Date.parse('10-04-2011T05:00:00Z'))
    end

    it "casts 'true' to nil" do
      PolarisResource::TypeCaster.cast('true', :date).should eql(nil)
    end

    it "casts 4 to nil" do
      PolarisResource::TypeCaster.cast(4, :date).should eql(nil)
    end

    it "casts true to nil" do
      PolarisResource::TypeCaster.cast(true, :date).should eql(nil)
    end

    it "cast DateTime to Date" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), :date).should eql(Date.parse('10-04-2011T05:00:00Z'))
    end

    it "casts Date to Date" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), :date).should eql(Date.parse('2011-04-10'))
    end

    it "casts Time to Date" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), :date).should eql(Date.parse('10-04-2011T05:00:00Z'))
    end

  end

  context "when the type_class is Time" do

    it "casts 'hello' to nil" do
      PolarisResource::TypeCaster.cast('hello', :time).should eql(nil)
    end

    it "casts '2011-04-10' to Time" do
      PolarisResource::TypeCaster.cast('2011-04-10', :time).should eql('2011-04-10'.to_time)
    end

    it "cast '3' to nil" do
      PolarisResource::TypeCaster.cast('3', :time).should eql(nil)
    end

    it "casts '10-04-2011T05:00:00Z' to Time" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', :time).should eql(Time.parse('10-04-2011T05:00:00Z'))
    end

    it "casts 'true' to nil" do
      PolarisResource::TypeCaster.cast('true', :time).should eql(nil)
    end

    it "casts 4 to nil" do
      PolarisResource::TypeCaster.cast(4, :time).should eql(nil)
    end

    it "casts true to nil" do
      PolarisResource::TypeCaster.cast(true, :time).should eql(nil)
    end

    it "cast DateTime to Time" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), :time).should eql(Time.parse('10-04-2011T05:00:00Z'))
    end

    it "casts Date to Time" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), :time).should eql(Time.parse('2011-04-10'))
    end

    it "casts Time to Time" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), :time).should eql(Time.parse('10-04-2011T05:00:00Z'))
    end

  end

  context "when the type_class is a boolean" do

    it "casts 'hello' to true" do
      PolarisResource::TypeCaster.cast('hello', :boolean).should eql(true)
    end

    it "casts '2011-04-10' to true" do
      PolarisResource::TypeCaster.cast('2011-04-10', :boolean).should eql(true)
    end

    it "cast '3' to true" do
      PolarisResource::TypeCaster.cast('3', :boolean).should eql(true)
    end

    it "casts '10-04-2011T05:00:00Z' to true" do
      PolarisResource::TypeCaster.cast('10-04-2011T05:00:00Z', :boolean).should eql(true)
    end

    it "casts 'true' to true" do
      PolarisResource::TypeCaster.cast('true', :boolean).should eql(true)
    end

    it "casts 4 to true" do
      PolarisResource::TypeCaster.cast(4, :boolean).should eql(true)
    end

    it "casts true to true" do
      PolarisResource::TypeCaster.cast(true, :boolean).should eql(true)
    end

    it "casts nil to false" do
      PolarisResource::TypeCaster.cast(nil, :boolean).should eql(false)
    end

    it "casts 'false' to false" do
      PolarisResource::TypeCaster.cast('false', :boolean).should eql(false)
    end

    it "casts 1 to true" do
      PolarisResource::TypeCaster.cast(1, :boolean).should eql(true)
    end

    it "casts '0' to false" do
      PolarisResource::TypeCaster.cast('0', :boolean).should eql(false)
    end

    it "cast DateTime to true" do
      PolarisResource::TypeCaster.cast(DateTime.parse('10-04-2011T05:00:00Z'), :boolean).should eql(true)
    end

    it "casts Date to true" do
      PolarisResource::TypeCaster.cast(Date.parse('2011-04-10'), :boolean).should eql(true)
    end

    it "casts Time to true" do
      PolarisResource::TypeCaster.cast(Time.parse('10-04-2011T05:00:00Z'), :boolean).should eql(true)
    end

  end
  
  context "when the type_class is unknown" do
    
    it "raises an error" do
      lambda {
        PolarisResource::TypeCaster.cast(nil, :made_up_class)
      }.should raise_error(PolarisResource::UnrecognizedTypeCastClass, "Can't typecast to made_up_class!")
    end
    
  end

end