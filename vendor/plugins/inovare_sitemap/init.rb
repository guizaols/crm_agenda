require File.dirname( __FILE__ ) + '/lib/sitemap'

ActiveRecord::Base.send :extend, Inovare::ActiveRecordSitemap::ClassMethods
ActiveRecord::Base.send :include, Inovare::ActiveRecordSitemap
