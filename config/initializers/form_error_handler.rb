# Implement the PicoCSS Validation States
# See https://picocss.com/docs/forms/input#validation-states

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  next html_tag if html_tag.start_with?("<label")

  html_tag.sub!(/<\w+/) { %(#{it} aria-invalid="true") }

  method_name = instance.instance_variable_get(:@method_name)
  error_dom_id = "#{ActionView::RecordIdentifier.dom_id(instance.object, method_name)}_error"
  message = instance.error_message.join(", ")

  html_tag.sub!(/<\w+/) { %(#{it} aria-describedby="#{error_dom_id}") }

  html_tag.html_safe + "\n<small id=\"#{error_dom_id}\">#{message}</small>".html_safe
end
