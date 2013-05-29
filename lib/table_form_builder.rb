class TableFormBuilder < ActionView::Helpers::FormBuilder

  (field_helpers - %w(hidden_field label)).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options = {})
        original_options = options.dup
        original_options.delete :td_options
        original_options.delete :after
        original_options.delete :label
        original_options.delete :simple_tag
        options.reverse_merge! :after => '', :td_options => {}
        begin
          model = self.object_name.to_s.camelize.constantize
        rescue
        end
        options[:td_options].reverse_merge! :class => 'field_descriptor'
        if options.delete(:simple_tag)
          super(field, original_options)
        else
          @template.content_tag('tr', 
            @template.content_tag('td', label(field, options[:label] || object.class.human_attribute_name(field)), options[:td_options]) +
            @template.content_tag('td', super(field, original_options) + options[:after])
          )
        end
      end
    END_SRC
    class_eval src, __FILE__, __LINE__
    
  end

end