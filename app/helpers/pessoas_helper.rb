module PessoasHelper



  def diferenciar_PF_PJ
    update_page do |page|
      page.if "$('pessoa_tipo_pessoa').value == '#{Pessoa::FISICA}'" do
        page.replace_html "nome", 'Nome*'
        page.hide :razao_social
        page.hide :contato
        page.hide :segmento
        page.hide :telefone_contato
        page.hide :email_contato
        page.show :cpf
        page.hide :cnpj
        page.replace_html "rg_ie",'RG'
      end
      page.if "$('pessoa_tipo_pessoa').value == '#{Pessoa::JURIDICA}'" do
        page.replace_html "nome", 'Nome Fantasia '
        page.show :razao_social
        page.show :contato
        page.show :segmento
        page.show :telefone_contato
        page.show :email_contato
        page.show :cnpj
        page.hide :cpf
        page.replace_html "rg_ie",'IE'
      end
    end
  end


end
