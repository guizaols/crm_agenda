class ActiveRecord::Base

  @@humanized_attributes = {}
  
  def self.human_attribute_name(attr)
    @@humanized_attributes[attr.to_sym] || attr.to_s.humanize
  end

end
