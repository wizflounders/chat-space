$(function() {
  var preWord = ""
  var $textField = $('#user-search-field')
//ユーザ検索候補表示html構築
  function appendList( user_name, user_id ) {
        var html = $( `
            <li class="result-list">
                <span class="result-list--left">${user_name}</span>
                <input class="add-button", type="button", value="追加">
                <input value="${user_id}" type="hidden", class="user_id">
            </li>
        ` );
        $( '#add-users' ).append( html );
  }
//すでにチャットメンバー追加ボタンを押し、表示されているユーザは候補に’追加済み’と表示
  function AlreadyAdded( user_name, user_id ) {
        var html = $( `
            <li class="result-list">
                <span class="result-list--left added">${user_name}</span>
                <span class="already_added">追加済み</span>
                <input value="${user_id}" type="hidden", class="user_id">
            </li>
        ` );
        $( '#add-users' ).append( html );
  }
// 追加ボタン押下後のチャットメンバー一覧表示先
  function addedMembersHtml( name, id ) {
         var $html = $( `
             <li class="chat-group-user">
                 <div class="chat-group-user__name">${name}</div>
                 <div class="chat-group-user__btn chat-group-user__btn--remove">削除</div>
                 <input name="group[user_ids][]" value="${id}" type="hidden", class="user_id">
             </li>
         ` );
         return $html;
     }
//追加されたユーザを判定するための配列を作成
     var userIds = []
// 追加ボタンを押すとチャットメンバー一覧に表示される
  $('#add-users').on('click', '.add-button', function(){
     var name = $(this).parent().text();
     var user_id = $(this).next().val();
      html = addedMembersHtml(name, user_id);
      $(this).parent().remove();
      $( '#added-users' ).append( html );
      userIds.push(user_id)
  });
// 削除ボタンを押すとリストから消える
  $('#added-users').on('click','.chat-group-user__btn--remove', function() {
      $(this).parent().remove();
      var remove_id = $(this).next().val();
// 削除ボタンを押すと、userIdsからそのユーザのidを削除
      userIds.some(function(v, i){
    if (v==remove_id) userIds.splice(i,1);
  });
});
//一致人物がいなかった際の表示
  function noOne( result ) {
        var html = $( `
            <li class="result-list">
                <span class="result-list--left">${result}</span>
            </li>
        ` );
        $( '#add-users' ).append( html );
  }
  function editElement(element) {
    var result = "^" + element;
    return result;
  }
// keyupでajaxと通信しUser.allのデータを得る
  $textField.on("keyup", function() {
    $.ajax({
      type:'GET',
      url: '/users',
      dataType: 'json'
    })
// User.allのユーザー名と入力を比較してインクリメンタルサーチを実行
  .done(function(data) {
      names = $textField.val();
      var inputs = names.split(" ").filter(function(e) { return e; });
      var newInputs = inputs.map(editElement);
      var word = newInputs.join("|");
      var reg = RegExp(word);
      if (word != preWord) {
        $(".result-list").remove();
        if(names.length !== 0) {
            $.each(data, function(i, ele) {
              var user_name = ele.name
              user_id = String(ele.id)
              if (user_name.match(reg)) {
                 var result = userIds.indexOf(user_id) ;
                if(result == -1){
                  appendList(user_name, user_id);
                } else {
                  AlreadyAdded(user_name, user_id);
                }
            }
            });
            if ($(".result-list").length === 0) {
              noOne('一致する人物はいませんでした。');
            }
          }
        }
      preWord = word;
      })
      .fail(function() {
      });
    });
  });
