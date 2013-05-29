class CompromissosController < ApplicationController

  before_filter :carrega_cliente,:except=>[:carregar_div,:rotas,:graficos,:carrega_calendario_do_mes,:novo_cadastro,:altera_data,:pesquisa]


  def carregar_div
    render :update do |page|
      unless params[:data].blank?
      @compromissos = Compromisso.all(:conditions=>["usuario_id = ? AND data = ?",params[:usuario_id],params[:data].to_date])
      page.replace_html :compromisso_hora_explicacao_busca,:partial=>"compromissos_do_dia",:locals=>{:compromissos=>@compromissos}
      @compromissos.collect(&:nome).join(",")
      page << "$('compromisso_hora_explicacao_busca').show();"
      page << "$('compromisso_hora_explicacao_busca').highlight();"
      end

    end
  end


  def rotas
    params[:data] ||= Date.today.to_s_br
    if params[:data].blank?
      params[:data] = Date.today.to_s_br
    end
    @compromissos = Compromisso.all(:include=>[:tipo_compromisso],:conditions=>["tipo_compromissos.visita_externa = 1 and entidade_id = ? and usuario_id = ? and data = ? and status = ?",current_usuario.entidade_id,current_usuario.id,(params[:data].to_date),1]).sort_by(&:hora_do_compromisso_em_minutos)
    @destinos ||=[]
    @compromissos.each do |c|
      @destinos << " to: #{c.pessoa.endereco}, #{c.pessoa.cidade.blank? ? "Curitiba" : c.pessoa.cidade} "
    end
    @endereco_prestige = YAML::load File.read(RAILS_ROOT + '/config/google_maps_key.yml')
  end

  def novo_cadastro
    @compromisso = Compromisso.new params[:compromisso]
    @compromisso.agendado_por = current_usuario.id
    @compromisso.entidade_id = current_usuario.entidade_id
    render :update do |page|
      if @compromisso.save
        page.alert 'Compromisso salvo com sucesso!'
        page << "$('compromisso_data').value = '';"
        page << "$('compromisso_tipo_compromisso_id').value = '';"
        page << "$('compromisso_pessoa_nome').value = '';"
        page << "$('compromisso_pessoa_id').value = '';"
        page << "$('compromisso_hora').value = '';"
        page << "$('compromisso_descricao').value = '';"
        if params[:data_inicial].blank? && params[:data_final].blank?
          page << "window.location.reload()"
        else
          page << "close_modal();"
          page.replace_html :resultado,:partial=>"calendario",:locals=>{:data_inicial=>params[:data_inicial],:data_final=>params[:data_final]}
        end
      else
        page.alert @compromisso.errors.full_messages.collect{|item| "* #{item}"}.join("\n")
      end
    end
  end

  def altera_data
    render :update do |page|
      data = params[:data_nova].split("_")
      @compromisso = Compromisso.find data[1]
      data = "#{data[2]}/#{data[3]}/#{data[4]}"
      nova_data = params[:nova_data].split("_")
      @compromisso.data = "#{nova_data[1]}/#{nova_data[2]}/#{nova_data[3]}"
      @compromisso.save!
      page.reload
      page.alert "Compromisso alterado com sucesso!"
    end
  end

  def graficos
    @compromissos = Compromisso.grafico_dinamico(params[:status])
    render :update do |page|
      page.replace "compromissos",:partial=>"relatorios/grafico_barra",:locals=>{:f=>@compromissos,:id=>"compromissos"}
      if params[:status] == "anterior"
        page.replace "label_compromisso",:text=>"<h3 id='label_compromisso'>Compromissos por funcionário (#{Compromisso::MES[Date.today.month - 1]})</h3>"
      else
        page.replace "label_compromisso",:text=>"<h3 id='label_compromisso'>Compromissos por funcionário (#{Compromisso::MES[Date.today.month]})</h3>"
      end
    end
  end

  def index
    @compromissos = Compromisso.find(:all,:conditions=>["pessoa_id = ?",params[:pessoa_id]],:order=>"data DESC")
  end

  def carrega_calendario_do_mes
    render :update do |page|
      page.replace_html :calendario,:partial=>"calendario",:locals=>{:mes=>params[:mes],:compromissos=>@compromissos}
    end
  end

  def pesquisa
    render :update do |page|
      if params[:pesquisa][:data_inicial].blank? || params[:pesquisa][:data_final].blank?
        page.alert 'Favor preencher as datas'
      else
        page.replace_html :resultado,:partial=>"calendario",:locals=>{:data_inicial=>params[:pesquisa][:data_inicial],:data_final=>params[:pesquisa][:data_final]}

      end
    end
  end

  def finalizar
    render :update do |page|
      @compromisso = Compromisso.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
      @compromisso.status = Compromisso::FINALIZADO
      if @compromisso.save!
        page << "if(confirm('Deseja agendar um outro compromisso para este cliente?')){"
        page << "$('compromisso_pessoa_nome').value = '#{@compromisso.pessoa.nome}';"
        page << "$('compromisso_pessoa_id').value = '#{@compromisso.pessoa.id}';"
        page << "modal_compromisso();"
        page <<  "}"
        page << "else{"
        page.alert 'Compromisso finalizado com sucesso!'
        if params[:data_inicial].blank? && params[:data_final].blank?
          page << "window.location.reload()"
        else
          page.replace_html :resultado,:partial=>"calendario",:locals=>{:data_inicial=>params[:data_inicial],:data_final=>params[:data_final]}

        end
        page << "}"
      else
        page.alert 'Não foi possível finalizar o compromisso!'
      end
    end
  end

  def show
    @compromisso = Compromisso.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
  end

  def new
    @compromisso = Compromisso.new
  end

  def edit
    @compromisso = Compromisso.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
  end

  def create
    @compromisso = Compromisso.new(params[:compromisso])

    @compromisso.agendado_por = current_usuario.id


    @compromisso.pessoa_id = @pessoa.id
    @compromisso.entidade_id = current_usuario.entidade_id

    if @compromisso.save
      flash[:notice] = 'Compromisso criado com sucesso!'
      redirect_to pessoa_compromissos_path
    else
      render :action => "new"
    end
  end

  def update
    @compromisso = Compromisso.find_by_id_and_pessoa_id(params[:id],params[:pessoa_id])
    @compromisso.agendado_por = current_usuario.id
    @compromisso.pessoa_id = @pessoa.id
    @compromisso.entidade_id = current_usuario.entidade_id

    if @compromisso.update_attributes(params[:compromisso])
      flash[:notice] = 'Compromisso atualizado com sucesso!'
      redirect_to pessoa_compromissos_path
    else
      render :action => "edit"
    end
  end

  private

  def carrega_cliente
    @pessoa = Pessoa.find params[:pessoa_id]
  end

end
