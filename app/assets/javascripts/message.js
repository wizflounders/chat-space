$(function() {
  function buildHtml(data) {
console.log(data)
    if ( data.message.image === null ) { data.message.image = ''; }
    var $html = $( `
                <div class="chat-body__message-box">
                    <div class="chat-body__message-box__name">${data.message.name}</div>
                    <div class="chat-body__message-box__date">${data.message.time}</div>
                <div class="chat-body__message-box__body">${data.message.body}
                    <div class="chat-body__message-box__image"></br>
                        <img src="${data.message.image}">
                    </div>
                </div>
            </li>
        ` );
    return $html;
  }

  $('#new_message').on('submit', function(e) {
  e.preventDefault();

  var textField = $('#message_body');
  var fileField = $('#message_image');
  var formData = new FormData($(this)[0]);
  var current_url = location.pathname;

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
