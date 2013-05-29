class ApplicationController < ActionController::Base

  helper :all
  before_filter :login_required
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  filter_parameter_logging :password


  def iphone_request?
    request.format == :iphone
  end

  
  def mobile_request?
    iphone_request?
  end

  def verificar_iphone
    if request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
      request.format = :iphone
    end
  end

  protected
  
  #Exibição de títulos diferentes para cada página (SEO):
  @@display_name = nil
  def display_name
    @@display_name || controller_name.capitalize
  end

  before_filter :seo_operations
  def seo_operations
    @title_suffix = case action_name
    when 'new', 'create'; 'Criar'
    when 'edit', 'update'; 'Alterar'
    when 'index': 'Lista'
    else action_name.untaint
    end
    @meta_description = 'Sistema desenvolvido pela Inovare (www.inovare.net)'
  end

  #Breadcrumbs
  def add_breadcrumb name, url = ''
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end

  def self.add_breadcrumb name, url, options = {}
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end
  add_breadcrumb 'Início', '/'

end