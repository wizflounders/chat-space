$(function() {
  function buildHTML(message) {
    var user_name = $('<div class="chat-body__message-box__name">').append(message.name);
    var message_time = $('<div class="chat-body__message-box__date">').append(message.time);
    var message_body = $('<div class="chat-body__message-box__body">').append(message.body);
    var html = $('<div class="chat-body__message-box">').append(user_name, message_time, message_body);
    return html;
  }

  $('message-form').on('submit', function(e) {
    e.preventDefault();
    var textField = $('#message_body');
    var fileField = $('.icon fa fa-image');
    var form = new FormData($(this)[0]);
    var current_url = location.pathname;
    $.ajax({
      type: 'POST',
      url: '/index.json',
     data: form,
     processData: false,
     contentType: false,
     dataType: 'json'
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
