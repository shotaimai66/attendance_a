
$(document).ready(function() {
$('#modal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) //モーダルを呼び出すときに使われたボタンを取得
  var date = button.data('date') //data-date の値を取得
  var day = button.data('day') //data-day の値を取得
  var date_1 = button.data('date_1') //data-date_1 の値を取得
  
  //Ajaxの処理はここに

  var modal = $(this)  //モーダルを取得
  modal.find('#modal-date').text(date) //モーダルの日付に値を表示
  modal.find('#modal-day').text(day) //モーダルの曜日に値を表示
  modal.find('#test').val(date_1)
  
  
})
});
