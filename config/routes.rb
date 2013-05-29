ActionController::Routing::Routes.draw do |map|
  map.resources :origens

  map.resources :historico_clientes

  map.resources :categorias


  map.resources :entidades,:collection=>{:cria_usuario=>:any}


  map.resources :acompanhamentos


  map.resources :grupos

  map.resources :retiradas

  map.resources :recursos

  map.resources :tipo_compromissos

  map.resources :moedas

  map.resources :mails, :collection => { :mail_group => :post }

  map.resources :produtos
  map.resources :relatorios,:collection=>{:vendas_por_grupo=>:any,:vendas_por_categoria_de_produto=>:any,:prospect=>:any,:auditoria=>:any,:espelho=>:any,:compromissos_funcionarios=>:any,:funil_financeiro=>:any,:funil_iterativo=>:any,:produtividade_funcionarios=>:any,:funil=>:any,:menu=>:any,:vendas_por_situacao=>:any}
  map.resource :main,:controller => "main"
  map.resource :minha_empresa,:controller=>"minha_empresa"
  map.resources :suportes, :member=>{:proposta_enviada => :any,:finalizar_solicitacao_orcamento=>:post,:aprovacao_tecnica=>:post,:aprovacao_administrativa=>:post}
  map.logout '/logout', :controller => 'sessoes', :action => 'destroy'
  map.login '/login', :controller => 'sessoes', :action => 'new'
  map.register '/register', :controller => 'usuarios', :action => 'create'
  map.signup '/signup', :controller => 'usuarios', :action => 'new'
  map.sitemap '/sitemap.:format', :controller => 'sitemap', :action => 'index'
  map.resources :usuarios
  map.resources :pessoas,:collection=>{:listagem_prospects=>:any,:integracao_google_maps=>:any,:pesquisa_cliente_pessoas=>:any,:filtro_por_inicial=>:get,:monta_parametros=>:any,:num_proposta=>:any,:filtro_pro_compromisso=>:any,:auto_complete_for_clientes=>:any} do |pessoa|
    pessoa.resources :compromissos,:member=>{:altera_data=>:any,:finalizar=>:any},:collection=>{:carregar_div=>:any,:rotas=>:any,:pesquisa=>:any,:graficos=>:any,:novo_cadastro=>:any,:carrega_calendario_do_mes=>:post}
    pessoa.resources :propostas, :collection=>{:carrega_preco=>:any,:grafico_status=>:any,:grafico_vendas_por_funcionario=>:any},:member=>{:calcula_valor_financiamento=>:any,:calcula_preco=>:any,:finalizar_venda=>:post,:altera_status_proposta=>:post,:altera_valor_proposta=>:post,:solicitar_orcamento=>:post} do |proposta|
      proposta.resources :historicos
    end
    pessoa.resources :historico_clientes
  end
 
  map.resource :sessao

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "sessoes", :action => 'new'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
