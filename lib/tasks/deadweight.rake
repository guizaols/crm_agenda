begin
  require 'deadweight'
rescue LoadError
end

namespace :deadweight do
  
  DEADWEIGHT_ROOT = 'http://localhost:3000'
  IGNORE_SELECTORS = %r{flash_notice|flash_error|errorExplanation|fieldWithErrors}

  desc "rodar verificação de CSS para áreas públicas"
  task :public do
    dw = Deadweight.new
    dw.stylesheets = ["/stylesheets/inovare.css", "/stylesheets/inovare_ie.css"]
    dw.pages = ['/', '/login']
    dw.ignore_selectors = IGNORE_SELECTORS
    dw.run.each do |k, v|
      puts "#{k} => #{v}"
    end
  end

  desc "rodar verificação de CSS para áreas administrativas"
  task :admin do
    dw = Deadweight.new
    dw.stylesheets = ["/stylesheets/inovare.css", "/stylesheets/inovare_admin.css"]
    dw.pages = []
    dw.mechanize = true
    dw.root = DEADWEIGHT_ROOT

    ['/usuarios'].each do |page|
      dw.pages << Proc.new do
        fetch '/login'
        form = agent.page.forms.first
        form.login = 'quentin'
        form.password = 'monkey'
        agent.submit form
        fetch page
      end
    end
    dw.ignore_selectors = IGNORE_SELECTORS
    dw.run.each do |k, v|
      puts "#{k} => #{v}"
    end
  end

end
