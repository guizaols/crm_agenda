require File.dirname(__FILE__) + '/../spec_helper'

describe SitemapController do

  integrate_views
  
  it 'deve retornar sitemaps' do
    Usuario.send :exibir_no_sitemap
    get :index, :format => 'xml'
    response.should be_success
  end

end
