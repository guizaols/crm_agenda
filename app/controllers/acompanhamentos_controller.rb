class AcompanhamentosController < ApplicationController
  # GET /acompanhamentos
  # GET /acompanhamentos.xml
  def index
    @acompanhamentos = Acompanhamento.all(:order=>"nome ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acompanhamentos }
    end
  end

  # GET /acompanhamentos/1
  # GET /acompanhamentos/1.xml
  def show
    @acompanhamento = Acompanhamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acompanhamento }
    end
  end

  # GET /acompanhamentos/new
  # GET /acompanhamentos/new.xml
  def new
    @acompanhamento = Acompanhamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acompanhamento }
    end
  end

  # GET /acompanhamentos/1/edit
  def edit
    @acompanhamento = Acompanhamento.find(params[:id])
  end

  # POST /acompanhamentos
  # POST /acompanhamentos.xml
  def create
    @acompanhamento = Acompanhamento.new(params[:acompanhamento])

    respond_to do |format|
      if @acompanhamento.save
        flash[:notice] = 'Acompanhamento criado com sucesso!'
        format.html { redirect_to(@acompanhamento) }
        format.xml  { render :xml => @acompanhamento, :status => :created, :location => @acompanhamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acompanhamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @acompanhamento = Acompanhamento.find(params[:id])

    respond_to do |format|
      if @acompanhamento.update_attributes(params[:acompanhamento])
        flash[:notice] = 'Acompanhamento atualizado com sucesso!'
        format.html { redirect_to(@acompanhamento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acompanhamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @acompanhamento = Acompanhamento.find(params[:id])
    @acompanhamento.destroy

    respond_to do |format|
      format.html { redirect_to(acompanhamentos_url) }
      format.xml  { head :ok }
    end
  end
end
