$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(version).each {|req| require File.dirname(__FILE__) + "/brI18n/#{req}"}
