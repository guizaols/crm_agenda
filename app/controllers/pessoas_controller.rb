class PessoasController < ApplicationController

  before_filter :verificar_iphone,:only=>[:index,:show]
  before_filter :iphone_request?,:only=>[:index,:show]
  before_filter :mobile_request?,:only=>[:index,:show]



  def index
    params[:busca] ||= {}
    params[:filtro] ||= {}
    if params[:busca].blank?
      if current_usuario.perfil_id == Usuario::VENDEDOR
        @pessoas = Pessoa.all(:include=>["usuarios"],:conditions=>["usuarios.id = ?",current_usuario.id],:order=>["nome ASC"])
      elsif current_usuario.perfil_id == Usuario::ADMINISTRADOR_CONCESSIONARIA || current_usuario.perfil_id == Usuario::TELEMARKETING || current_usuario.perfil_id == Usuario::RECEPCIONISTA
        @pessoas = Pessoa.all(:conditions=>["entidade_id = ?",current_usuario.entidade_id],:order=>["nome ASC"])
      else
        @pessoas = Pessoa.all(:order=>["nome ASC"])
      end
    else
      unless params[:filtro].blank?
         if params[:filtro] == "Geral"
           params[:busca][:parametro] = (params[:busca][:parametro] rescue nil)
         else
           params[:busca][:parametro] = (params[:busca][:telefone] rescue nil)
         end
      end
      @pessoas = Pessoa.buscar_clientes(params[:busca],current_usuario)
    end
  end

  def listagem_prospects
    params[:busca] ||= {}
    if params[:busca].blank?
      if current_usuario.perfil_id == Usuario::VENDEDOR
        @pessoas = Pessoa.all(:include=>["usuarios"],:conditions=>["usuarios.id = ?",current_usuario.id],:order=>["nome ASC"])
      elsif current_usuario.perfil_id == Usuario::ADMINISTRADOR_CONCESSIONARIA || current_usuario.perfil_id == Usuario::TELEMARKETING || current_usuario.perfil_id == Usuario::RECEPCIONISTA
        @pessoas = Pessoa.all(:conditions=>["entidade_id = ?",current_usuario.entidade_id],:order=>["nome ASC"])
      else
        @pessoas = Pessoa.all(:order=>["nome ASC"])
      end
    else
      @pessoas = Pessoa.buscar_clientes(params[:busca],current_usuario)
    end
    
  end


   def filtro_pro_compromisso
    if current_usuario.perfil_id != 1
      @pessoas = Pessoa.all(:include=>["usuarios"],:conditions=>["usuarios.id = ?",current_usuario.id],:order=>["nome ASC"])
    else
      @pessoas = Pessoa.all(:order=>["nome ASC"])
    end
    unless params[:valor_1].blank?
      r = []
      @pessoas.each do |p|
        r << p  if p.ultimo_contato == params[:valor_1]
      end
      @pessoas = r
    end
  
    render :update do |page|
      page.replace_html :tabela_clientes,:partial=>"listagem_pessoa",:locals=>{:pessoas=>@pessoas,:valor_1=>params[:valor_1]}
    end
  end


  def monta_parametros
    if current_usuario.perfil_id != 1
      @pessoas = Pessoa.all(:include=>["usuarios"],:conditions=>["usuarios.id = ?",current_usuario.id],:order=>["nome ASC"])
    else
      @pessoas = Pessoa.all(:order=>["nome ASC"])
    end
    unless params[:valor].blank?
      r = []
      @pessoas.each do |p|
        eval "r << p if p.ultimo_contato_em_numeros #{params[:valor]}"
      end
      @pessoas = r
    end

    render :update do |page|
      page.replace_html :tabela_clientes,:partial=>"listagem_pessoa",:locals=>{:pessoas=>@pessoas,:valor=>params[:valor]}
    end
  end


  def num_proposta
        if current_usuario.perfil_id != 1
      @pessoas = Pessoa.all(:include=>["usuarios"],:conditions=>["usuarios.id = ?",current_usuario.id],:order=>["nome ASC"])
    else
      @pessoas = Pessoa.all(:order=>["nome ASC"])
    end
    unless params[:valor_novo].blank?
      r = []
      @pessoas.each do |p|
        eval "r << p if(p.numero_de_propostas#{ params[:valor_novo]}.to_i)"
      end
      @pessoas = r
    end

    render :update do |page|
      page.replace_html :tabela_clientes,:partial=>"listagem_pessoa",:locals=>{:pessoas=>@pessoas,:valor_novo=>params[:valor_novo]}
    end
  end


  def new
    @pessoa = Pessoa.new
  end


  def integracao_google_maps
    render :update do |page|
      page << " var map;
  var directionsPanel;
  var directions;
       if (GBrowserIsCompatible()) {

      map = new GMap2(document.getElementById('map_canvas'));
      map.setCenter(new GLatLng(42.351505,-71.094455), 15);
      directionsPanel = document.getElementById('route');
      directions = new GDirections(map, directionsPanel);
alert('oi');
      directions.load('from: Rua Iapó,1730,Curitiba   to: Rua Alcebíades Plaisant,946');
    }


      "
    end
    #directions.load('from: #{params[:de]}   to: #{params[:para]}');
  end

  def show
    @pessoa = Pessoa.find params[:id]
    @historico_clientes = @pessoa.historico_clientes
    @historico = Historico.new
    @endereco_prestige = YAML::load File.read(RAILS_ROOT + '/config/google_maps_key.yml')
  end

  def edit
    @pessoa = Pessoa.find params[:id]
    @origem_solicitacao = request.env["HTTP_REFERER"].match %r{^.*propostas.*$} rescue nil
    p @origem_solicitacao.blank?
    p "************************"
  end

  def create
    @pessoa = Pessoa.new(params[:pessoa])
    @pessoa.entidade_id = current_usuario.entidade_id
    if @pessoa.save
      Auditoria.create :entidade_id=>current_usuario.entidade_id,:data=>Date.today.to_s_br,:operacao=>"Cliente Criado",:usuario_id=>current_usuario.id,:pessoa_id=>@pessoa.id
      flash[:notice] = 'Pessoa cadastrada com sucesso!'
      redirect_to pessoa_path(@pessoa)
    else
      render :action => "new"
    end
  end

  def update
    @pessoa = Pessoa.find(params[:id])
    @pessoa.entidade_id = current_usuario.entidade_id
    if @pessoa.update_attributes(params[:pessoa])
      Auditoria.create :entidade_id=>current_usuario.entidade_id,:data=>Date.today.to_s_br,:operacao=>"Cliente Atualizado",:usuario_id=>current_usuario.id,:pessoa_id=>@pessoa.id
      flash[:notice] = 'Pessoa atualizada com sucesso!'
      redirect_to pessoa_path(@pessoa)
    else
      render :action=>"edit"
    end
  end

  def auto_complete_for_clientes
    @clientes = Pessoa.all :conditions => ['(nome like ?)',"%#{params[:argumento]}%"], :limit => 10, :select => 'id, nome'
    render :text =>'<ul>' + @clientes.collect{|c| "<li id=\"#{c.id}\">#{c.nome}</li>"}.join + '</ul>'
  end

  def filtro_por_inicial
    params[:inicial] ||= '%'
    @pessoas = Pessoa.all :conditions => ['nome like ?', "#{params[:inicial]}%"]
    render :update do |page|
      page << "$('#listagem_por_inicial').replaceWith('#{escape_javascript render(:partial => 'listagem_por_inicial')}')"
    end
  end
end
