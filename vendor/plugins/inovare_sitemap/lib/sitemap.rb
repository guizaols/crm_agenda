module Inovare

  class Sitemap
    @@models = []
    def self.adicionar_model(model, proc)
      @@models << [model, proc]
    end
    def self.models_do_sitemap
      Dir.glob(RAILS_ROOT + '/app/models/*.rb').each do |model_file|
        require model_file
      end
      @@models
    end
  end

  module ActiveRecordSitemap

    def expirar_sitemap
      sitemap_file = RAILS_ROOT + '/public/sitemap.xml'
      File.delete sitemap_file if File.exists?(sitemap_file)
    end

    module ClassMethods
      DEFAULT_PROC = Proc.new do |obj|
        route = (obj.class.to_s.downcase + '_url').to_sym
        [[route, obj.to_param, obj.updated_at]]
      end
      
      def exibir_no_sitemap(&block)
        block ||= DEFAULT_PROC
        Inovare::Sitemap.adicionar_model self, block
        after_save :expirar_sitemap
        after_destroy :expirar_sitemap
      end
    end

  end
  
end