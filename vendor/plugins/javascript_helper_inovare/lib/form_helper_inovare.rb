module ActionView::Helpers
  
  class FormBuilder
    def select_ou_crie_um_novo(method, choices, options = {}, html_options = {})
      @template.select_ou_crie_um_novo(@object_name, method, choices, objectify_options(options), @default_options.merge(html_options))
    end  
  end
  
end

module ActionView::Helpers::FormOptionsHelper

  def select_ou_crie_um_novo(object, method, choices, options = {}, html_options = {}, text_field_options = {})
    text_field_para_criar_novo = text_field(object, "novo_#{method}", text_field_options)
    
    if choices.length > 0
      select(object, method, choices, options.merge(:include_blank => true), html_options) + 
        " #{ options[:mensagem] || 'ou crie um novo' }: " +
        text_field_para_criar_novo
    else
      text_field_para_criar_novo
    end
  end
  
end
