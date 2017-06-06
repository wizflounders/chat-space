$(function() {
  function buildHtml(data) {
    var user_name = $('<div class="chat-body__message-box__name">').append(data.name);
    var message_time = $('<div class="chat-body__message-box__date">').append(data.created_at);
    var message_body = $('<div class="chat-body__message-box__body">').append(data.body);
    var imageClass = $('<div class="chat-body__message-box__image">');
    if (data.image) {
     var imageSrc = image.append("<img src=" + image + ">");
     var insertImage = imageClass.append(imageSrc);
   }
    var html = $('<div class="chat-body__message-box">').append(user_name, message_time, message_body, insertImage);
    return html;
  }

  function buildFormData( f ) {
      var fd = new FormData( f.get( 0 ));
      var message = $( '#message_body' ).val();
      var file = $( '#message_image' )[0].files[0];
      fd.append( 'body', message );
      fd.append( 'image', file );
      return fd;
  }


  $('#new_message').on('submit', function(e) {
  e.preventDefault();
   var formData = buildFormData( $( this ));
  var textField = $('#message_body');
  var fileField = $('#message_image');
  var current_url = location.pathname;
  for(item of formData) console.log(item);
  $.ajax({
    type: 'POST',
    dataType:'json',
    url: current_url,
    data: formData,
    processData: false,
    contentType: false,
  })

  .done(function(data) {
    var html = buildHtml(data);
    $('.chat-body').append(html);
    textField.val('');
    fileField.val('');

  })
  .fail(function() {
    alert('error');
  });
  return false;
});
});
