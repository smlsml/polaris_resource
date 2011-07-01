ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular /^(.+)ss$/i, '\1ss'
end