class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def inspect
    attrs = attributes_for_inspect.map do |attr|
      "#{attr}: #{attribute_for_inspect(attr)}"
    end.join(", ")

    "#{self.class}(#{attrs})"
  end
end
