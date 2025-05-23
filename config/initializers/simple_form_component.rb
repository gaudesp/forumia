module InputGroup
  def prepend(wrapper_options = nil)
    span_tag = content_tag(:span, options[:prepend], class: "input-group-text")
    template.content_tag(:div, span_tag, class: "input-group-prepend")
  end

  def append(wrapper_options = nil)
    span_tag = content_tag(:span, options[:append], class: "input-group-text")
    template.content_tag(:div, span_tag, class: "input-group-append")
  end
end

SimpleForm.include_component(InputGroup)