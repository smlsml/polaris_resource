Autotest.add_discovery do
  'rspec2'
end

Autotest.add_hook :initialize do |autotest|
  ['.git', 'spec/dummy/log'].each { |exception| autotest.add_exception(exception) }
end