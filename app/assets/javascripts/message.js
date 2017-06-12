$(function() {
//新規メッセージを表示させるhtmlを構築
  function buildHtml(data) {
    if ( data.message.image === null) { data.message.image = ''; }
    var $html = $( `
                <div class="chat-body__message-box" data-message-id="${data.message.id}">
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
//自動更新用のhtml構築
  function autoUpdateHtml(message) {
    if ( message.image === null) { message.image = ''; }
    var $html = $( `
                <div class="chat-body__message-box" data-message-id="${message.id}">
                    <div class="chat-body__message-box__name">${message.name}</div>
                    <div class="chat-body__message-box__date">${message.time}</div>
                <div class="chat-body__message-box__body">${message.body}
                    <div class="chat-body__message-box__image"></br>
                        <img src="${message.image}">
                    </div>
                </div>
            </li>
        ` );
    return $html;
  }
  //チャット画面最下部へスクロールし移動
  function scrollBottom() {
      $('.chat-body').animate({scrollTop: $('.chat-body')[0].scrollHeight}, 'fast');
  }
  //チャット画面にて５秒毎にメッセージを自動更新する処理
  var path = location.pathname;
  var interval = setInterval(function() {
      if (path.match(/\/groups\/\d+\/messages/)) {
        var last_msg_id = $('.chat-body__message-box').filter(":last").data('messageId')
    $.ajax({
      type:'GET',
      url: path + '.json',
      data: {
          last_msg_id: last_msg_id
      }
    })
    .done(function(data) {
      var insertHTML = '';
      data.forEach(function(message) {
        if (message.id > last_msg_id ) {
         var html = autoUpdateHtml(message);
         $('.chat-body').append(html);
         scrollBottom();
        }
      });
    })

    .fail(function(data) {
      alert('自動更新失敗...')
    });
  } else {
    clearInterval(interval);
   }} , 5000 );

//subimitをするとajaxと通信し、新規メッセージを部分更新
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
    scrollBottom()
  })

  .fail(function() {
    alert('error');
  });
  return false;
});
});
