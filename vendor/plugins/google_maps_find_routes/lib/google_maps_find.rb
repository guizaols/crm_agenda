module ActionView::Helpers::AssetTagHelper
  
  def google_maps_javascript_include_tag
    $GOOGLE_MAPS_KEYS ||= YAML::load File.read(RAILS_ROOT + '/config/google_maps_key.yml')
    content_tag 'script', '', :src => "http://maps.google.com/maps?file=api&amp;v=2&amp;key=#{$GOOGLE_MAPS_KEYS[Rails::env]}", :type => 'text/javascript'
  end
  
  def enable_map_for(id, options = {})
    lines = []
    lines << "  var map_#{id}"
    lines << '  if (GBrowserIsCompatible()) {'
    lines << "    map_#{id} = new GMap2(document.getElementById(\"#{id}\"));"
    lines << "    " + google_maps_set_center(id, options[:center].first, options[:center].last, 16) if options[:center]
    lines << "    map_#{id}.enableScrollWheelZoom();" if options[:zoom_with_scroll]
    lines << '  }'
    javascript_tag lines.join("\n")
  end
  
  def link_to_google_maps_find_nearest(id, caption, places, options = {})
    script_to_find_nearest(id, places, options) + link_to_function(caption, "find_nearest_to_#{id}()")
  end
  
  def button_to_google_maps_find_nearest(id, caption, places, options = {})
    script_to_find_nearest(id, places, options) + link_to_function("Localizar", "find_nearest_to_#{id}()")
  end
  
  def button_to_google_maps_find_route(id, caption, options = {})
    lines = []
    lines << "function find_path_in_#{id}() {"
    lines << "  #{id}_source = document.getElementById(\"#{id}_source\").value;"
    lines << "  #{id}_direction = new GDirections();"
    lines << "  GEvent.addListener(#{id}_direction, \"load\", function()"
    lines << "  {"
    lines << "    #{id}_distance = #{id}_direction.getDistance().meters;"
    lines << "    #{id}_formatted_distance = #{id}_direction.getDistance().html"
    lines << "    map_#{id}.clearOverlays();"
    lines << "    new GDirections(map_#{id}).load(\"from: \" + #{id}_source + \" to: #{options[:search]}\");"
    lines << "    #{options[:if_found]};"
    lines << "  } );"
    lines << "  GEvent.addListener(#{id}_direction, \"error\", function() "
    lines << "  {"
    lines << "        #{options[:if_error]};"
    lines << "  } );"
    lines << "  #{id}_direction.load(\"from: \" + #{id}_source + \" to: #{options[:search]}\");"
    lines << "}"

    javascript_tag(lines.join("\n")) + "\n" + button_to_function(caption, "find_path_in_#{id}()")
  end
  
  def google_maps_add_marker(id, latitude, longitude, options = {})
    out = "var marker = new GMarker(new GLatLng(#{latitude}, #{longitude})); map_#{id}.addOverlay(marker);"
    if options[:description]
      command = options[:show_description] ? 'openInfoWindowHtml' : 'bindInfoWindowHtml'
      out << " marker.#{command}('#{options[:description]}');"
    end
    out << google_maps_set_center(id, latitude, longitude, options[:center_and_zoom]) if options[:center_and_zoom]
    out
  end
  
  def google_maps_set_center(id, latitude, longitude, zoom_factor)
    "map_#{id}.setCenter(new GLatLng(#{latitude}, #{longitude}), #{zoom_factor});"
  end
  
  def google_maps_clear_overlays(id)
    "map_#{id}.clearOverlays();"
  end
  private
  
  def script_to_find_nearest(id, places, options = {})
    lines = []
    lines << "var #{id}_source, #{id}_directions, #{id}_distances, #{id}_nearest_distance, #{id}_nearest_formatted_distance;"
    lines << "function find_nearest_to_#{id}() {"
    lines << "  #{id}_source = document.getElementById(\"#{id}_source\").value;"
    lines << "  #{id}_directions = new Array(#{places.length});"
    lines << "  #{id}_distances = new Array(#{places.length});"
    lines << "  #{id}_nearest_distance = null;"
    places.each_with_index { |place, index|
      lines << "  #{id}_directions[#{index}] = new GDirections();"
      lines << "  GEvent.addListener(#{id}_directions[#{index}], \"load\", function()"
      lines << "  {"
      lines << "    #{id}_distances[#{index}] = #{id}_directions[#{index}].getDistance().meters;"
      lines << "    if ((#{id}_nearest_distance == null) || (#{id}_distances[#{index}] < #{id}_nearest_distance)) {"
      lines << "      #{id}_nearest_distance = #{id}_distances[#{index}]"
      lines << "      #{id}_nearest_formatted_distance = #{id}_directions[#{index}].getDistance().html"
      lines << "    }"
      lines << "    conferirResultado();"
      lines << "  } );"
      if options[:if_error] && (index == 0)
        lines << "  GEvent.addListener(#{id}_directions[#{index}], \"error\", function() "
        lines << "  {"
        if options[:if_error].is_a? String
          lines << "    #{options[:if_error]};"
        else
          lines << update_page(&options[:if_error])
        end
        lines << "  } );"
      end
      lines << "  #{id}_directions[#{index}].load(\"from: \" + #{id}_source + \" to: #{place[:search]}\");"
    }
    lines << "}"
    lines << "function conferirResultado() {"
    lines << "  if (#{id}_distances[0] && #{id}_distances[1]) {"
    lines << "    " + google_maps_clear_overlays(id)
    lines << "    if (#{id}_distances[0] < #{id}_distances[1]) {"
    lines << "      new GDirections(map_#{id}).load(\"from: \" + #{id}_source + \" to: #{places.first[:search]}\");"
    if places.first[:if_nearest].is_a? String
      lines << "      #{places.first[:if_nearest]};"
    else
      lines << update_page(&places.first[:if_nearest])
    end
    lines << "    }"
    lines << "    else "
    lines << "    {"
    lines << "      new GDirections(map_#{id}).load(\"from: \" + #{id}_source + \" to: #{places.last[:search]}\");"
    if places.last[:if_nearest].is_a? String
      lines << "      #{places.last[:if_nearest]};"
    else
      lines << update_page(&places.last[:if_nearest])
    end
    lines << "    }"
    lines << "  }"
    lines << "}"
    javascript_tag(lines.join("\n")) + "\n"
  end
end
