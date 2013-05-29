# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def campo_para_busca_por_data campo
    calendar_date_select_tag_com_mascara "busca[#{campo}]", params[:busca][campo]
  end

  def google_maps_javascript_include_tag
    $GOOGLE_MAPS_KEYS ||= YAML::load File.read(RAILS_ROOT + '/config/google_maps_key.yml')
    content_tag 'script', '', :src => "http://maps.google.com/maps?file=api&amp;v=2&amp;key=#{$GOOGLE_MAPS_KEYS[Rails::env]}", :type => 'text/javascript'
  end

  def retorna_mes(mes)
    m = {1=>"Janeiro",
      2=>"Fevereiro",
      3=>"Março",
      4=>"Abril",
      5=>"Maio",
      6=>"Junho",
      7=>"Julho",
      8=>"Agosto",
      9=>"Setembro",
      10=>"Outubro",
      11=>"Novembro",
      12=>"Dezembro",
    }
    m[mes]
  end
  
  def link_para_imposto_rateio(tipo,parcela = nil,entidade = nil,conta = nil)
    tipo == 'imposto' ? "criaImpostoDaParcela(#{render(:partial => 'parcelas/imposto_da_parcela',:locals=>{:chave=>nil,:entidade_id => entidade.id,:valor_doc=>conta.valor_do_documento,:parcela=>parcela.valor,:data_da_baixa=>parcela.data_da_baixa}).to_json},#{parcela.lancamento_impostos.length},#{parcela.valor});":
      "criaItemRateio(#{render(:partial => 'parcelas/itens_rateio',:locals=>{:indice=>nil}).to_json},#{parcela.dados_do_rateio.length});"
  end

  def campo_para_busca_por_faixa_de_data campo
    campo_para_busca_por_data("#{campo}_min") + '  <b>a</b>  ' + campo_para_busca_por_data("#{campo}_max")
  end

  def campo_de_cadastro label, valor
    '<tr><td class="field_descriptor">' + label + '</td><td>' + valor + '</td></tr>'
  end

  def calendar_date_select_tag_com_mascara *args
    calendar_date_select_tag(*args) + mascara_para_data(sanitize_to_id(args.first))
  end
  
  def calendar_date_select_com_mascara(f,nome)
    f.calendar_date_select(nome) + mascara_para_data(f.object_name+"_"+nome)
  end
  
  def esta_na_tela_de_login
    params[:controller] == 'sessao'
  end

  def textile(texto)
    p "-----------------------------------------"
    p texto
    require 'redcloth'
    RedCloth.new(texto).to_html
  end


  def show_unless_blank(label, campo, options = {})
    campo = h campo unless options[:safe_html]
    "<tr><td class='field_descriptor' style=text-align:right;>#{label}:</td><td>#{campo}</td></tr>" unless campo.blank?
  end

  def data_formatada(data)
    unless data.blank?
      data.to_date.to_s_br
    end
  end

  def mascara_para_valor(id)
    javascript_tag "oNumberMask = new Mask('###.00', 'number'); oNumberMask.attach($('#{id}')); $('#{id}').onblur();"
  end
  
  def mascara_para_data(id)
    javascript_tag "$('#{id}').onkeyup=function(){AplicaMascara('XX/XX/XXXX', this)};"
  end

  def mascara_para_validade_cartao(id)
    javascript_tag "$('#{id}').onkeyup=function(){AplicaMascara('XX/XX', this)};"
  end

  def preco_formatado(preco , cifrao = '')
    number_to_currency(preco, :unit => cifrao, :separator => ",", :delimiter => ".") rescue nil
  end

  def preco_formatado_com_ponto(preco)
    number_to_currency(preco / 100.0, :separator => ".", :unit => '').to_s.strip
  end

  def mensagem_da_pesquisa(busca)
    if (busca rescue true)
      "<b>Não foram encontrados registros com estes parâmetros de busca.</b>"
    else
      "<b>Entre com os parâmetros válidos para a pesquisa.</b>"
    end
  end
  
  def data_formatada(data)
    data.to_date.to_s_br unless data.blank?
  end
  
 
  def listagem_table(options = {})
    if options[:permissoes].blank?
      @permissoes_links_new_edit_delete = true
    else
      @permissoes_links_new_edit_delete = current_usuario.possui_permissao_para(options[:permissoes])
    end
    @ocultar_ultima_th = options[:ocultar_ultima_th]
   
    table_tag = content_tag('table', '', :class => 'listagem', :cellspacing => 0, :style => options[:style]).gsub '</table>', ''
    concat table_tag
    if headers = options.delete(:headers)
#      concat "<thead><tr><td colspan=\"#{ headers.length + (@ocultar_ultima_th ? 0 : 1) }\"></td></tr><tr>"
      concat "<thead><tr>"
      headers.each do |header|
        concat "<th>#{header}</th>"
      end
      if options[:new]
        concat '<th class="ultima_coluna">'        
        concat link_to("Novo", options[:new]) if @permissoes_links_new_edit_delete
        concat '</th>'
      end
      concat '</tr></thead>'
    end
    yield
    concat '</table>'
  end
  
  def listagem_table(options = {})
    if options[:permissoes].blank?
      @permissoes_links_new_edit_delete = true
    else
      @permissoes_links_new_edit_delete = current_usuario.possui_permissao_para(options[:permissoes])
    end
    @ocultar_ultima_th = options[:ocultar_ultima_th]

    table_tag = content_tag('table', '', :class => 'listagem', :cellspacing => 0, :style => options[:style]).gsub '</table>', ''
    concat table_tag
    if headers = options.delete(:headers)
#      concat "<thead><tr><td colspan=\"#{ headers.length + (@ocultar_ultima_th ? 0 : 1) }\"></td></tr><tr>"
      concat "<thead><tr>"
      headers.each do |header|
        concat "<th>#{header}</th>"
      end
      if options[:new]
        concat '<th class="ultima_coluna">'
        concat link_to("Novo", options[:new])  if @permissoes_links_new_edit_delete
        concat '</th>'
      end
      concat '</tr></thead>'
    end
    yield
    concat '</table>'
  end


    def campo_com_label_para_mobile(campo, options={})
    caption_iphone = options.delete(:caption)
    caption_html = caption_iphone
    caption_iphone ||= options.delete(:iphone)
    caption_html ||= options.delete(:html)
    if controller.iphone_request?
      '<div class="row"><label>' + caption_iphone + '</label> ' + campo + '</div>'
    else
      caption_html + ' ' + campo
    end
  end

  def image_submit_tag_mobile(options={})
    caption_iphone = options.delete(:iphone)
    image_html = options.delete(:html)
    if controller.mobile_request?
      link_to_function caption_iphone, "this.up('form').submit()", :class => 'whiteButton'
    else
      image_submit_tag image_html, options
    end
  end

  def link_to_mobile(path, options={})
    caption_iphone = options.delete(:iphone)
    caption_html = options.delete(:html)
    if iphone_request?
      link_to caption_iphone, path
    else
      link_to caption_html, path, options
    end
  end

  
  def listagem_tr(options = {})
    if options[:permissoes].blank?
      @permissoes_links_new_edit_delete = true
    else
      @permissoes_links_new_edit_delete = current_usuario.possui_permissao_para(options[:permissoes])
    end
    concat "<tr class='dados'>"
    #    if options[:id]
    #      concat "<tr id=\"#{options[:id]}\" class=\"#{ cycle 'impar', 'par' }\">"
    #    else
    #      concat "<tr class=\"#{ cycle 'impar', 'par' }\">"
    #    end
    yield

    if (options[:edit] || options[:destroy] || options[:after]) && @ocultar_ultima_th.blank?
      concat '<td class="ultima_coluna">'
      concat link_to(image_tag('alterar.gif', :title=>'Alterar'), options[:edit]) if options[:edit] && @permissoes_links_new_edit_delete
      concat link_to(image_tag('excluir.png'), options[:destroy], :confirm => 'Confirma a exclusão?', :method => 'delete') if options[:destroy] && @permissoes_links_new_edit_delete
      concat options[:after] if options[:after]
      concat '</td></tr>'
    else
      concat '</tr>'
    end
  end
  
  def divs_para_explicar_auto_complete(id)
    "<div class=\"div_explicativa\"><div id=\"#{sanitize_to_id(id)}_explicacao_busca\" class=\"explicacao_busca_auto_complete\" style=\"display: none\">Este é um campo dinâmico de pesquisa de dados. Digite parcialmente o dado que você procura e aguarde um instante. O sistema irá retornar automaticamente os resultados da busca. <br />Para utilizar a função 'Começa com', digite um * à direita do texto (ex: 'Joao*'). <br />Para utilizar a função 'Termina com', digite um * à esquerda do texto (ex: '*Santos')." +
      image_tag('seta_tooltip.gif') + "</div>" +
      "</div>"
  end

  def hash_com_opcoes_do_auto_complete(id)
    { :onfocus => "$('#{sanitize_to_id(id)}_explicacao_busca').show()",
      :onblur => "$('#{sanitize_to_id(id)}_explicacao_busca').hide()" }
  end

  def loading_image(id)
    image_tag('loading.gif', :id=>"loading_#{id}",:style=>"display:none")
  end

  #    def limpa_campos_unidade_organizacional_centro(objeto, campo, elemento = nil)
  #    variavel = ["#{objeto.object_name}_nome_#{campo}"] << (elemento if elemento)
  #    variavel = variavel.join("_")
  #
  #    js = ([["#{objeto.object_name}_unidade_organizacional", "id"], ["#{objeto.object_name}_nome_centro", ""],
  #        ["#{objeto.object_name}_centro", "id"]].collect do |valores|
  #        (novo_array = [valores.first] << (elemento if elemento)) << (valores.last if valores.last == "id")
  #        "$('#{novo_array.join('_')}').value = null;"
  #      end).join(' ')
  #
  #      variavel = "#{objeto.object_name}_nome_#{campo}" + "_#{elemento}"
  #      "if ($('#{variavel}').empty())
  #       {
  #          $('#{objeto.object_name}_unidade_organizacional_id').value = null;
  #          $('#{objeto.object_name}_nome_centro').value = null;
  #          $('#{objeto.object_name}_centro_id').value = null;
  #       }"
  #    end

  def auto_complete_para_conta_contabil_parametrizada(f, objeto, campo, options = {})
    conta = objeto.send("#{campo}_id_parametrizada")
    if conta
      objeto.send("#{campo}_id=", conta) #Força utilizar a conta parametrizada
      f.hidden_field("#{campo}_id") + '<b>' + h(objeto.send("nome_#{campo}")) + '</b>'
    else
      auto_complete_para_qualquer_campo(f, campo, auto_complete_for_conta_contabil_plano_de_contas_path, {:analisar_conta => true}.merge(options))
    end
  end
  
  def insere_campos_para_busca_de_contas(opcoes_para_select,mensagem_para_busca)
    (text_field_tag 'busca[texto]', params[:busca][:texto], :onfocus => "exibir_explicacao_para_busca('exibir','#{mensagem_para_busca}')", :onblur => "exibir_explicacao_para_busca('ocultar','')") +
      (select_tag('busca[ordem]', options_for_select(opcoes_para_select,params[:busca][:ordem]))) +
      (submit_tag 'Pesquisar')
  end

  def auto_complete_para_qualquer_campo(objeto, campo, url, options = {})
    #    Como passar o options!
    #    options = {:analisar_conta => true, :complemento_dos_params => "", :complemento_do_after_update_element => "", :opcoes_para_text_field => {:tamanho => 30, :desabilitar => false}}  
    divs_para_explicar_auto_complete("#{objeto.object_name}_nome_#{campo}") +
      objeto.hidden_field("#{campo}_id") +
      objeto.text_field("nome_#{campo}", { :simple_tag => true }.merge(hash_com_opcoes_do_auto_complete("#{objeto.object_name}_nome_#{campo}").merge(options[:opcoes_para_text_field] ? options[:opcoes_para_text_field] : {}))) +
      "<div id='#{objeto.object_name}_nome_#{campo}_auto_complete' class='auto_complete_para_conta'></div>" +
      auto_complete_field("#{objeto.object_name}_nome_#{campo}", :url => url, :with => "'argumento=' + element.value#{options[:complemento_dos_params]}",
      :after_update_element =>  options[:analisar_conta] ? analisa_tipo_de_conta(campo, objeto) :  "function(element, value) { $('#{objeto.object_name}_#{campo}_id').value = value.id; #{options[:complemento_do_after_update_element]} }",
      :indicator => "loading_#{campo}") +
      loading_image(campo)
  end

  def auto_complete_tag_para_qualquer_campo(campo, url)
    divs_para_explicar_auto_complete(campo) +
      text_field_tag("busca[nome_#{campo}]", params[:busca]["nome_campo"], {:size => 50}.merge(hash_com_opcoes_do_auto_complete(campo))) +
      "<div id='busca_nome_#{campo}_auto_complete' class='auto_complete_para_conta'></div>" +
      hidden_field_tag("busca[#{campo}_id]", params[:busca]["#{campo}_id"]) +
      auto_complete_field("busca_nome_#{campo}", :url => url, :with => "'argumento=' + element.value", :after_update_element => "function(element, value){$('busca_#{sanitize_to_id(campo)}_id').value = value.id;}", :indicator => "loading_busca_#{campo}") +
      image_tag('loading.gif', :id => "loading_busca_#{campo}", :style=> "display:none")

  end

  def auto_complete_para_qualquer_campo_tag(campo, url, id = nil, nome = nil, options = {})
    #    Como passar o options!
    #    options = {:analisar_conta => true, :complemento_dos_params => "", :complemento_do_after_update_element => "", opcoes_para_text_field => {:tamanho => 30, :desabilitar => false}}
    divs_para_explicar_auto_complete(campo) +
      hidden_field_tag("#{campo}", id) +
      text_field_tag("#{campo.sub "_id","_nome"}", nome, hash_com_opcoes_do_auto_complete(campo).merge(options[:opcoes_para_text_field] ? options[:opcoes_para_text_field] : {})) +
      "<span id='#{sanitize_to_id(campo.sub "_id", "_nome")}_auto_complete' class='auto_complete_para_conta'></span>"+
      auto_complete_field("#{sanitize_to_id(campo.sub "_id", "_nome")}", :url => url, :with => "'argumento=' + element.value#{options[:complemento_dos_params]}",
      :after_update_element => (options[:analisar_conta] ? analisa_tipo_de_conta(campo,nil,options[:complemento_do_after_update_element]) : "function(element, value){$('#{sanitize_to_id(campo)}').value = value.id; #{options[:complemento_do_after_update_element]}}"),
      :indicator => "loading_#{sanitize_to_id(campo)}", :indicator => "loading_#{sanitize_to_id(campo)}") +
      image_tag('loading.gif', :id => "loading_#{sanitize_to_id(campo)}", :style=> "display:none")
  end

  def analisa_tipo_de_conta(campo, objeto = nil,complemento = nil)
    unless objeto
      array = [sanitize_to_id(campo), sanitize_to_id(campo.sub "_id", "_nome")]
    else
      array = ["#{objeto.object_name}_#{campo}_id", "#{objeto.object_name}_nome_#{campo}"]
    end
    "function(element, value)
      {
         var tipo_da_conta;
         tipo_da_conta = value.id;
        if (tipo_da_conta.charAt(0) == '1')
          $('#{array.first}').value = tipo_da_conta.substring(2, tipo_da_conta.length)
        else
        {
          alert('O usuário só pode selecionar contas analíticas');
          $('#{array.first}').value = null;
          $('#{array.last}').value = null;
        }
         #{complemento unless complemento.blank?}

      }"
  end
  
  #  def auto_complete_para_qualquer_campo(f,campo,url,javascript_para_conta,desabilitar = false, tamanho = 30, options = {})
  #    divs_para_explicar_auto_complete("#{f.object_name}_nome_#{campo}") +
  #      f.hidden_field("#{campo}_id") +
  #      f.text_field("nome_#{campo}", {:simple_tag=>true}.merge(hash_para_explicar_auto_complete("#{f.object_name}_nome_#{campo}",tamanho,desabilitar)))+
  #      "<div id='#{f.object_name}_nome_#{campo}_auto_complete' class='auto_complete_para_conta'></div>" +
  #      auto_complete_field("#{f.object_name}_nome_#{campo}", :url=> url, :with => "'argumento=' + element.value#{options[:complemento_dos_params]}" , :after_update_element =>  javascript_para_conta ? analisa_tipo_de_conta(campo, f) :  "function(element, value) { $('#{f.object_name}_#{campo}_id').value = value.id; #{options[:complemento_do_after_update_element]} }" ,:indicator => "loading_#{campo}")+loading_image(campo)
  #  end

  #  def auto_complete_para_qualquer_campo(f,campo,url,javascript_para_conta,desabilitar = false, tamanho = 30)
  #    divs_para_explicar_auto_complete("#{f.object_name}_nome_#{campo}") +
  #      f.hidden_field("#{campo}_id") +
  #      f.text_field("nome_#{campo}", {:simple_tag=>true}.merge(hash_para_explicar_auto_complete("#{f.object_name}_nome_#{campo}",tamanho,desabilitar)))+
  #      "<div id='#{f.object_name}_nome_#{campo}_auto_complete' class='auto_complete_para_conta'></div>" +
  #      auto_complete_field("#{f.object_name}_nome_#{campo}", :url=> url, :with => "'argumento=' + element.value" , :after_update_element =>  javascript_para_conta ? analisa_tipo_de_conta(campo, f) :  "function(element, value) { $('#{f.object_name}_#{campo}_id').value = value.id }" ,:indicator => "loading_#{campo}")+image_tag('loading.gif', :id=>"loading_#{campo}",:style=>"display:none")
  #  end
  
  #  def auto_complete_para_qualquer_campo_tag(campo, url, id = nil, nome = nil, javascript_para_conta = false,desabilitar = false)
  #    divs_para_explicar_auto_complete(campo) +
  #      hidden_field_tag("#{campo}",id)+
  #      text_field_tag("#{campo.sub "_id","_nome"}",nome,hash_para_explicar_auto_complete(campo,nil,desabilitar ))+
  #      "<span id='#{sanitize_to_id(campo.sub "_id", "_nome")}_auto_complete' class='auto_complete_para_conta'></span>"+
  #      auto_complete_field("#{sanitize_to_id(campo.sub "_id","_nome")}", :url=> url, :with => "'argumento=' + element.value",
  #      :after_update_element => (javascript_para_conta ? analisa_tipo_de_conta(campo) : "function(element, value){$('#{sanitize_to_id(campo)}').value = value.id;}") ,:indicator => "loading_#{sanitize_to_id(campo)}", :indicator => "loading_#{sanitize_to_id(campo)}") +
  #      image_tag('loading.gif', :id => "loading_#{sanitize_to_id(campo)}", :style=> "display:none")
  #  end

  def hl(texto)
    h(l(texto))
  end

end