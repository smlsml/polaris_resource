= RESTful API Client
Working toward a DSL that is very ActiveResource/ActiveRecord-like with some features stolen from other great libraries like DataMapper.

For Example:

    class Dummy < PolarisResource::Base
      property :name
      property :created_at
      property :has_smarts

      belongs_to :thingy
      has_many :thingamabobs
      has_one :doohickey
    end

    @dummy = Dummy.new(
      :name       => "Dumb",
      :has_smarts => false,
      :thingy_id  => 2)                                # => #<Dummy:0x1016858d8>
    @dummy.new_record?                                 # => true
    @dummy.save                                        # => POST http://localhost/dummies

    @dummy = Dummy.find(1)                             # => GET http:localhost/dummies/1
    @dummy.new_record?                                 # => false
    @dummy.name                                        # => "Dumb"
    @dummy.name = "Dumber"                             # => "Dumber"
    @dummy.save                                        # => PUT http://localhost/dummies/1
    @dummy.update_attributes(:has_smarts => true)      # => PUT http://localhost/dummies/1

    @dummy.thingy                                      # => GET http://localhost/thingies/2
    @dummy.thingamabobs                                # => GET http://localhost/dummies/1/thingamabobs
    @dummy.doohickey                                   # => GET http://localhost/dummies/1/doohickey

    Dummy.all                                          # => GET http://localhost/dummies
    Dummy.find(1,2,3)                                  # => GET http://localhost/dummies?ids=1,2,3
    Dummy.find([1,2,3])                                # => GET http://localhost/dummies?ids=1,2,3

    Dummy.where(:name => "Dumb")                       # => GET http://localhost/dummies?name=Dumb
    Dummy.where(:name => "Dumb", :has_smarts => false) # => GET http://localhost/dummies?name=Dumb&has_smarts=false
    Dummy.limit(1)                                     # => GET http://localhost/dummies?limit=1
    Dummy.result_per_page = 25                         # => 25
    Dummy.page(3)                                      # => GET http://localhost/dummies?limit=25&offset=50

Design informed by Service-Oriented Design with Ruby and Rails by Paul Dix, @Amazon[http://www.amazon.com/Service-Oriented-Design-Rails-Addison-Wesley-Professional/dp/0321659368]