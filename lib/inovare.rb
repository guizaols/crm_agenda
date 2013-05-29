class Inovare

  def self.excluir_arquivos_de_cache
    files = ['index.html', 'javascripts/all.js', 'stylesheets/all.css'].collect do |files|
      Dir.glob(RAILS_ROOT + '/public/' + files)
    end.flatten
    File.delete(*files)
  end

end