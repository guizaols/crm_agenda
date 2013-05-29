class SitemapController < ApplicationController

  caches_page :index
  skip_before_filter :login_required
  
  def index
    respond_to do |format|
      format.xml do
        @results = [root_url]
        Inovare::Sitemap.models_do_sitemap.each do |item|
          model = item[0]
          proc = item[1]
          model.all(:order => 'updated_at DESC', :limit => 1000).each do |m|
            commands = proc.call m
            commands.each do |command|
              updated_at = command.pop
              @last_modified ||= updated_at
              @last_modified = updated_at if updated_at > @last_modified
              @results << [send(*command), m.updated_at]
            end
          end
        end
        headers["Last-Modified"] = @last_modified.httpdate if @last_modified
      end
    end
  end

end
