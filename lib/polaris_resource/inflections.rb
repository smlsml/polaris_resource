ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular /^(*)?class/i, '\1'
end