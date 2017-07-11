$(document).on("turbolinks:load", function() {
  if($("body").hasClass("contact")){

    $(".g-input__field_select").select2();

    mapboxgl.accessToken = 'pk.eyJ1Ijoic2NobmliYmEiLCJhIjoiMWEwYWI4YTA3YTAwYjVhYTY1YWZiZGFiZDk1Zjk5NGUifQ.ueMMb8kMdWxrP5N4iqx67Q';
    var long = $('#long_id').val(); 
    var lat = $('#lat_id').val();
    var name = $('#name_id').val();
    var map = new mapboxgl.Map({
        container: 'g-map',
        style: 'mapbox://styles/schnibba/ciw9f6qp500542qmkzdjjqd8o',
        center: [long, lat],
        zoom: 12,
        hash: false,
        interactive: false
    });

    // var nav = new mapboxgl.NavigationControl();
    
    map.on('load', function () {
      // map.addControl(nav, 'top-left');
      map.dragPan.enable();
      map.addSource("points", {
          "type": "geojson",
          "data": {
              "type": "FeatureCollection",
              "features": [{
                  "type": "Feature",
                  "geometry": {
                      "type": "Point",
                      "coordinates": [long, lat]
                  },
                  properties: {
                      "title": name,
                      "icon": "star",
                      "marker-color": "#3ca0d3",
                      "size": "large"

                  }
              }
              ]
          }
      });

      map.addLayer({
          "id": "points",
          "type": "symbol",
          "source": "points",
          "layout": {
              "icon-image": "{icon}-15",
              "text-field": "{title}",
              "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
              "text-offset": [0, 0.6],
              "text-anchor": "top"
          }
      });
    });
  } 
});