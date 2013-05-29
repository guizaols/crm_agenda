require File.join(File.dirname(__FILE__), '../../../../config/environment')
require File.join(File.dirname(__FILE__), '../lib/google_maps_find')
require 'mocha'
require 'test/unit'

class GoogleMapsFindTest < Test::Unit::TestCase
  
  def setup
    @view = ActionView::Base.new
  end
  
  def test_javascript_tag_with_key
    File.expects(:read).with(RAILS_ROOT + '/config/google_maps_key.yml').returns("development: ABCD\ntest: DEFG\nproduction: HIJK").once
    #Rodando duas vezes a mesma coisa, pra ver se ele vai carregar só uma vez o arquivo de chaves
    assert_equal '<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=HIJK" type="text/javascript"></script>', @view.google_maps_javascript_include_tag
    assert_equal '<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=HIJK" type="text/javascript"></script>', @view.google_maps_javascript_include_tag
  end
  
  def test_enable_map_for_default
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
  var map_id
  if (GBrowserIsCompatible()) {
    map_id = new GMap2(document.getElementById("id"));
  }
//]]>
</script>
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.enable_map_for('id')
  end
  
  def test_enable_map_with_scroll_zoom
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
  var map_id
  if (GBrowserIsCompatible()) {
    map_id = new GMap2(document.getElementById("id"));
    map_id.enableScrollWheelZoom();
  }
//]]>
</script>
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.enable_map_for('id', :zoom_with_scroll => true)
  end
  
  def test_enable_map_for_default_with_center
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
  var map_box
  if (GBrowserIsCompatible()) {
    map_box = new GMap2(document.getElementById("box"));
    map_box.setCenter(new GLatLng(-23, -55), 7);
  }
//]]>
</script>
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.enable_map_for('box', :center => [-23, -55])
  end
  
  def test_enable_map_for_default_with_other_center
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
  var map_box
  if (GBrowserIsCompatible()) {
    map_box = new GMap2(document.getElementById("box"));
    map_box.setCenter(new GLatLng(50, 51), 7);
  }
//]]>
</script>
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.enable_map_for('box', :center => [50, 51])
  end
  
  def test_button_to_google_maps_find_nearest
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
var box_source, box_directions, box_distances, box_nearest_distance, box_nearest_formatted_distance;
function find_nearest_to_box() {
  box_source = document.getElementById("box_source").value;
  box_directions = new Array(2);
  box_distances = new Array(2);
  box_nearest_distance = null;
  box_directions[0] = new GDirections();
  GEvent.addListener(box_directions[0], "load", function()
  {
    box_distances[0] = box_directions[0].getDistance().meters;
    if ((box_nearest_distance == null) || (box_distances[0] < box_nearest_distance)) {
      box_nearest_distance = box_distances[0]
      box_nearest_formatted_distance = box_directions[0].getDistance().html
    }
    conferirResultado();
  } );
  GEvent.addListener(box_directions[0], "error", function() 
  {
    document.getElementById("status").value="impossível localizar";
  } );
  box_directions[0].load("from: " + box_source + " to: Londrina PR Brasil");
  box_directions[1] = new GDirections();
  GEvent.addListener(box_directions[1], "load", function()
  {
    box_distances[1] = box_directions[1].getDistance().meters;
    if ((box_nearest_distance == null) || (box_distances[1] < box_nearest_distance)) {
      box_nearest_distance = box_distances[1]
      box_nearest_formatted_distance = box_directions[1].getDistance().html
    }
    conferirResultado();
  } );
  box_directions[1].load("from: " + box_source + " to: São José dos Pinhais PR Brasil");
}
function conferirResultado() {
  if (box_distances[0] && box_distances[1]) {
    map_box.clearOverlays();
    if (box_distances[0] < box_distances[1]) {
      new GDirections(map_box).load("from: " + box_source + " to: Londrina PR Brasil");
      document.getElementById("status").value="O mais perto é Londrina";
    }
    else 
    {
      new GDirections(map_box).load("from: " + box_source + " to: São José dos Pinhais PR Brasil");
      document.getElementById("status").value="O mais perto é São José dos Pinhais";
    }
  }
}
//]]>
</script>
<input onclick="find_nearest_to_box();" type="button" value="Mostrar Caminho!" />
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.button_to_google_maps_find_nearest('box', 'Mostrar Caminho!', [
        {   :search => 'Londrina PR Brasil',
            :if_nearest => 'document.getElementById("status").value="O mais perto é Londrina"' },
        {   :search => 'São José dos Pinhais PR Brasil',
            :if_nearest => 'document.getElementById("status").value="O mais perto é São José dos Pinhais"'
        }], :if_error => 'document.getElementById("status").value="impossível localizar"')
  end
  
  def test_button_to_google_maps_find_route_to_opera
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
function find_path_in_opera() {
  opera_source = document.getElementById("opera_source").value;
  opera_direction = new GDirections();
  GEvent.addListener(opera_direction, "load", function()
  {
    opera_distance = opera_direction.getDistance().meters;
    opera_formatted_distance = opera_direction.getDistance().html
    map_opera.clearOverlays();
    new GDirections(map_opera).load("from: " + opera_source + " to: -23.299605, -51.186311");
    $('resultado').innerHTML = 'Você está a ' + opera_formatted_distance + ' da Opera de Londrina!';  new Effect.Highlight("resultado",{});
  } );
  GEvent.addListener(opera_direction, "error", function() 
  {
        $("resultado").update("Seu endereço não pôde ser rastreado! Verifique-o, por favor."); new Effect.Highlight("resultado",{});
  } );
  opera_direction.load("from: " + opera_source + " to: -23.299605, -51.186311");
}
//]]>
</script>
<input onclick="find_path_in_opera();" type="button" value="OK" />
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.button_to_google_maps_find_route(:opera, 'OK', 
                        :search => '-23.299605, -51.186311', 
                        :if_found => "$('resultado').innerHTML = 'Você está a ' + opera_formatted_distance + ' da Opera de Londrina!';  new Effect.Highlight(\"resultado\",{})",
                        :if_error => '$("resultado").update("Seu endereço não pôde ser rastreado! Verifique-o, por favor."); new Effect.Highlight("resultado",{})' )
  end
  
  def test_button_to_google_maps_find_route_to_mapa
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
function find_path_in_mapa() {
  mapa_source = document.getElementById("mapa_source").value;
  mapa_direction = new GDirections();
  GEvent.addListener(mapa_direction, "load", function()
  {
    mapa_distance = mapa_direction.getDistance().meters;
    mapa_formatted_distance = mapa_direction.getDistance().html
    map_mapa.clearOverlays();
    new GDirections(map_mapa).load("from: " + mapa_source + " to: -20, -30");
    $('resultado').innerHTML = 'Você está perto do seu destino!';  new Effect.Highlight("resultado",{});
  } );
  GEvent.addListener(mapa_direction, "error", function() 
  {
        alert("Oie!!");
  } );
  mapa_direction.load("from: " + mapa_source + " to: -20, -30");
}
//]]>
</script>
<input onclick="find_path_in_mapa();" type="button" value="Procurar" />
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.button_to_google_maps_find_route(:mapa, 'Procurar', 
                        :search => '-20, -30',
                        :if_found => "$('resultado').innerHTML = 'Você está perto do seu destino!';  new Effect.Highlight(\"resultado\",{})",
                        :if_error => 'alert("Oie!!")' )
  end
  
  def test_link_to_google_maps_find_nearest
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
var box_source, box_directions, box_distances, box_nearest_distance, box_nearest_formatted_distance;
function find_nearest_to_box() {
  box_source = document.getElementById("box_source").value;
  box_directions = new Array(2);
  box_distances = new Array(2);
  box_nearest_distance = null;
  box_directions[0] = new GDirections();
  GEvent.addListener(box_directions[0], "load", function()
  {
    box_distances[0] = box_directions[0].getDistance().meters;
    if ((box_nearest_distance == null) || (box_distances[0] < box_nearest_distance)) {
      box_nearest_distance = box_distances[0]
      box_nearest_formatted_distance = box_directions[0].getDistance().html
    }
    conferirResultado();
  } );
  GEvent.addListener(box_directions[0], "error", function() 
  {
    document.getElementById("status").value="impossível localizar";
  } );
  box_directions[0].load("from: " + box_source + " to: Londrina PR Brasil");
  box_directions[1] = new GDirections();
  GEvent.addListener(box_directions[1], "load", function()
  {
    box_distances[1] = box_directions[1].getDistance().meters;
    if ((box_nearest_distance == null) || (box_distances[1] < box_nearest_distance)) {
      box_nearest_distance = box_distances[1]
      box_nearest_formatted_distance = box_directions[1].getDistance().html
    }
    conferirResultado();
  } );
  box_directions[1].load("from: " + box_source + " to: São José dos Pinhais PR Brasil");
}
function conferirResultado() {
  if (box_distances[0] && box_distances[1]) {
    map_box.clearOverlays();
    if (box_distances[0] < box_distances[1]) {
      new GDirections(map_box).load("from: " + box_source + " to: Londrina PR Brasil");
      document.getElementById("status").value="O mais perto é Londrina";
    }
    else 
    {
      new GDirections(map_box).load("from: " + box_source + " to: São José dos Pinhais PR Brasil");
      document.getElementById("status").value="O mais perto é São José dos Pinhais";
    }
  }
}
//]]>
</script>
<a href="#" onclick="find_nearest_to_box(); return false;">Mostrar Caminho!</a>
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.link_to_google_maps_find_nearest('box', 'Mostrar Caminho!', [
        {   :search => 'Londrina PR Brasil',
            :if_nearest => 'document.getElementById("status").value="O mais perto é Londrina"' },
        {   :search => 'São José dos Pinhais PR Brasil',
            :if_nearest => 'document.getElementById("status").value="O mais perto é São José dos Pinhais"'
        }], :if_error => 'document.getElementById("status").value="impossível localizar"')
  end

  def test_button_to_google_maps_find_nearest_2
    output = <<-GOOGLE_SCRIPT
<script type="text/javascript">
//<![CDATA[
var id_source, id_directions, id_distances, id_nearest_distance, id_nearest_formatted_distance;
function find_nearest_to_id() {
  id_source = document.getElementById("id_source").value;
  id_directions = new Array(2);
  id_distances = new Array(2);
  id_nearest_distance = null;
  id_directions[0] = new GDirections();
  GEvent.addListener(id_directions[0], "load", function()
  {
    id_distances[0] = id_directions[0].getDistance().meters;
    if ((id_nearest_distance == null) || (id_distances[0] < id_nearest_distance)) {
      id_nearest_distance = id_distances[0]
      id_nearest_formatted_distance = id_directions[0].getDistance().html
    }
    conferirResultado();
  } );
  id_directions[0].load("from: " + id_source + " to: Concordia SC Brasil");
  id_directions[1] = new GDirections();
  GEvent.addListener(id_directions[1], "load", function()
  {
    id_distances[1] = id_directions[1].getDistance().meters;
    if ((id_nearest_distance == null) || (id_distances[1] < id_nearest_distance)) {
      id_nearest_distance = id_distances[1]
      id_nearest_formatted_distance = id_directions[1].getDistance().html
    }
    conferirResultado();
  } );
  id_directions[1].load("from: " + id_source + " to: Florianopolis SC Brasil");
}
function conferirResultado() {
  if (id_distances[0] && id_distances[1]) {
    map_id.clearOverlays();
    if (id_distances[0] < id_distances[1]) {
      new GDirections(map_id).load("from: " + id_source + " to: Concordia SC Brasil");
      window.alert("Londrina");
    }
    else 
    {
      new GDirections(map_id).load("from: " + id_source + " to: Florianopolis SC Brasil");
      window.alert("São José");
    }
  }
}
//]]>
</script>
<input onclick="find_nearest_to_id();" type="button" value="Traçar Rota" />
GOOGLE_SCRIPT
    assert_script_equal output.chomp, @view.button_to_google_maps_find_nearest('id', 'Traçar Rota', [
        { :search => 'Concordia SC Brasil',
          :if_nearest => 'window.alert("Londrina")' },
        { :search => 'Florianopolis SC Brasil',
          :if_nearest => 'window.alert("São José")'
        }
        ] )
  end

  def test_update_page_if_error
    actual = @view.button_to_google_maps_find_nearest('id', 'Rota', [
                                              { :search => 'Concordia SC Brasil',
                                                :if_nearest => 'window.alert("Londrina")' },
                                              { :search => 'Florianopolis SC Brasil',
                                                :if_nearest => 'window.alert("São José")'
                                              }
                                              ], :if_error => lambda {|page| page.alert('Erro!')} )
    
    piece = actual.match(%r{GEvent.addListener\(id_directions\[0\], "error", function\(\).*?\{\n(.*?)  \}}m)[1]
    expected = <<-GOOGLE_SCRIPT
alert("Erro!");
GOOGLE_SCRIPT
    
    assert_script_equal expected, piece
  end
  
  def test_update_page_if_nearest
    actual = @view.button_to_google_maps_find_nearest('id', 'Rota', [
                                              { :search => 'Concordia SC Brasil',
                                                :if_nearest => lambda {|page| page.alert('Londrina')} },
                                              { :search => 'Florianopolis SC Brasil',
                                                :if_nearest => lambda {|page| page.alert('Floripa')}
                                              }
                                              ] )
    
    analysis = actual.match(%r{if \(id_distances\[0\] < id_distances\[1\]\) \{\n(.*?)    \}.*?else.*?\{\n(.+?)    \}}m)
    
    if_concordia_nearest = analysis[1]
    expected_concordia_block = <<-GOOGLE_SCRIPT
      new GDirections(map_id).load("from: " + id_source + " to: Concordia SC Brasil");
alert("Londrina");
GOOGLE_SCRIPT
    assert_script_equal expected_concordia_block, if_concordia_nearest
    
    if_florianopolis_nearest = analysis[2]
    expected_florianopolis_block = <<-GOOGLE_SCRIPT
      new GDirections(map_id).load("from: " + id_source + " to: Florianopolis SC Brasil");
alert("Floripa");
GOOGLE_SCRIPT
    assert_script_equal expected_florianopolis_block, if_florianopolis_nearest
#    puts if_florianopolis_nearest
#    puts expected_florianopolis_block
  end
  
  def test_add_marker
    assert_equal "var marker = new GMarker(new GLatLng(10, 20)); map_city.addOverlay(marker);", 
                 @view.google_maps_add_marker(:city, 10, 20)
    assert_equal "var marker = new GMarker(new GLatLng(-15, -5)); map_town.addOverlay(marker);", 
                 @view.google_maps_add_marker(:town, -15, -5)
    assert_equal "var marker = new GMarker(new GLatLng(-15, -5)); map_town.addOverlay(marker); marker.bindInfoWindowHtml('<b>First Marker</b>');", 
                 @view.google_maps_add_marker(:town, -15, -5, :description => '<b>First Marker</b>')
    assert_equal "var marker = new GMarker(new GLatLng(-15, -5)); map_town.addOverlay(marker); marker.openInfoWindowHtml('<b>First Marker</b>');", 
                 @view.google_maps_add_marker(:town, -15, -5, :description => '<b>First Marker</b>', :show_description => true)
    assert_equal "var marker = new GMarker(new GLatLng(-15, -5)); map_town.addOverlay(marker); marker.bindInfoWindowHtml('<b>First Marker</b>');map_town.setCenter(new GLatLng(-15, -5), 6);", 
                 @view.google_maps_add_marker(:town, -15, -5, :description => '<b>First Marker</b>', :center_and_zoom => 6)
  end
  
  def test_set_center
    assert_equal "map_box.setCenter(new GLatLng(-23, -55), 6);",
                 @view.google_maps_set_center(:box, -23, -55, 6)
    assert_equal "map_city.setCenter(new GLatLng(10, 20), 3);",
                 @view.google_maps_set_center(:city, 10, 20, 3)
  end
  
  def test_clear_overlays
    assert_equal "map_box.clearOverlays();", @view.google_maps_clear_overlays(:box)
    assert_equal "map_id.clearOverlays();", @view.google_maps_clear_overlays(:id)
  end
  private
  
  def assert_script_equal(expected, actual)
    File.open('expected', 'w') do |file|
      file.print expected
    end
    File.open('actual', 'w') do |file|
      file.print actual
    end
    diff = `diff -C 3 expected actual`
    flunk(diff) unless diff == ''
  ensure
    File.delete('expected') rescue nil
    File.delete('actual') rescue nil
  end
end
