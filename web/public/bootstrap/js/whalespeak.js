$( document ).ready(function() {
  $( "#to-whalespeak" ).click(function(event) {
    var text_to_translate = $( "#text-to-translate" ).val();

    $.ajax({
      url: "http://zubkoland.org:1234/api/translate/to",
      data: '{ "text": "' + text_to_translate + '"}',
      type: "POST",
      dataType : "json",
      success: function( json ) {
          $( "#translated-text" ).text( json.translation );
      },
      error: function( xhr, status, errorThrown ) {
          alert( "Sorry, there was a problem!" );
          console.log( "Error: " + errorThrown );
          console.log( "Status: " + status );
          console.dir( xhr );
      },
    });
  });
  $( "#from-whalespeak" ).click(function(event) {
    var text_to_translate = $( "#text-to-translate" ).val();

    $.ajax({
      url: "http://zubkoland.org:1234/api/translate/from",
      data: '{ "text": "' + text_to_translate + '"}',
      type: "POST",
      dataType : "json",
      success: function( json ) {
          var response = json.translation;
          if (! response) { response = json.error };
          
          $( "#translated-text" ).text( response );
      },
      error: function( xhr, status, errorThrown ) {
          alert( "Sorry, there was a problem!" );
          console.log( "Error: " + errorThrown );
          console.log( "Status: " + status );
          console.dir( xhr );
      },
    });
  });
});
