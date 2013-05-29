class OrigensController < ApplicationController

  def index
    @origens = Origem.all(:order=>"nome ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @origens }
    end
  end

  def show
    @origem = Origem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @origem }
    end
  end

  def new
    @origem = Origem.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @origem }
    end
  end

  def edit
    @origem = Origem.find(params[:id])
  end

  def create
    @origem = Origem.new(params[:origem])

    respond_to do |format|
      if @origem.save
        flash[:notice] = 'Origem criada com sucesso!'
        format.html { redirect_to(@origem) }
        format.xml  { render :xml => @origem, :status => :created, :location => @origem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @origem.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @origem = Origem.find(params[:id])

    respond_to do |format|
      if @origem.update_attributes(params[:origem])
        flash[:notice] = 'Origem atualizada com sucesso!'
        format.html { redirect_to(@origem) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @origem.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @origem = Origem.find(params[:id])
    @origem.destroy

    respond_to do |format|
      format.html { redirect_to(origens_url) }
      format.xml  { head :ok }
    end
  end
end
