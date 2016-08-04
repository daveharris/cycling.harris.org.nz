# Create custom date formats, including :default
# Date#to_s is aliased to Date#to_formatted_s(:default) which is set from locales/en.yml
# See http://apidock.com/rails/Date/to_formatted_s

formats = YAML.load_file(::File.expand_path('../../locales/en.yml', __FILE__))
formats['en']['date']['formats'].each do |name, format|
  Date::DATE_FORMATS[name.to_sym] = format
end

# formats['en']['time']['formats'].each do |name, format|
#   Time::DATE_FORMATS[name.to_sym] = format
# end