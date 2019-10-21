<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="FullCalendarWebApp.index" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Takvim</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css">
        <link rel="stylesheet" media="print" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.print.css">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="http://momentjs.com/downloads/moment.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/locale-all.js"></script>
        <script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
  crossorigin="anonymous"></script>

    <script>
      $(function() {

          $('#events .fc-event').each(function() { 
              $(this).data('event', {
                  title: $(this).text()
              });

              $(this).draggable({ //olayları sürüklemek ve geri döndürmek
                  revert: true,
                  revertDuration: 0
              });
          });


          $('#calendar').fullCalendar({ //takvimi oluşturmak
              locale: 'tr', // takvim dilini türkçe olarak değiştirmek
              weekends: true, //sadece haftaiçi günleri görmek
              defaultView: 'month',
              selectable: true, //tıklanılan günü vurgulamak
              editable: true,
              //eventStartEditable: false,      //olayın başka bir yere sürüklenmesine izin vermez
              eventDurationEditable: false,   //olayın zaman aralığını sürükleyerek değiştirmeye izin vermez
              scrollTime: '00:00', //günün ilk saatini ayarlamak
              minTime: '00:00', //başlangıç saati belirlemek
              maxTime: '24:00', //bitiş saati belirlemek
              droppable: true, //takvime dışarıdan olay sürüklemek
              slotDuration: '00:30', //saatler arasındaki aralığı belirlemek
              slotLabelFormat: 'HH:mm:ss', //Agenda görünümlerde saat formatını değiştirmek
              slotLabelInterval: '00:15', //saat text tekrarlarını ayarlamak
              //allDaySlot: false, //tüm gün alanını gizler
              allDayText: 'TÜM GÜN', //tüm gün alanında texti değiştirmek
              header: { //başlık içeriğini değiştirmek
                  left: 'prev, next today',
                  center: 'title',
                  right: 'month, basicWeek, basicDay agendaWeek, agendaDay'
              },
              footer: { //footer ekleme ve içeriği değiştirmek
                  left: 'title',
                  center: '',
                  right: 'prevYear, nextYear' // 1 yıl ileri - geri butonları
              },

              firstDay: 1, //0: Pazar günüdür 1,2,3,4,5,6
              columnFormat: 'dddd',
              timeFormat: 'HH mm ss', //saat formatı ayarlama, HH olarak tanımlarsak 24 saatlik formatta ayarlanır
              titleFormat: 'D MMMM YYYY',
              titleRangeSeparator: '/',
              buttonText: { //buton text özelliklerini değiştirmek
                  agendaWeek: 'Saatli Hafta',
                  agendaDay: 'Saatli Gün'
              },
              customButtons: { //özel buton eklemek
                  denemeBtn: {
                      text: 'Deneme Butonu',
                      click: function () {
                          alert('Deneme Butonuna Basıldı!');
                      }
                  }
              },
              isRTL: false, //sağdan sola sıralama
              eventClick: function (event) {
                  //alert(event.id + ''); olaya tıklandığında id ekrana gelir
                  alert(event.msg); //eklenen mesaj ekrana gelir
              },
              drop: function (date) {
                  alert(date.format()); //dışarıdan olay eklendiğinde ekrana sürüklene tarih gelir
              },
              eventDrop: function (event) {
                  alert('Olay yeri değişti: ' + event.title + ' ' + event.start.format());
              },
              dayClick: function (date) {
                  alert(date.format() + ' tarihine tıkladınız');
              },
              events: function (start, end, timezone, callback) {

                  let bgun = start.date();
                  let bay = start.month() + 1;
                  let byil = start.year();

                  let egun = end.date();
                  let eay = end.month() + 1;
                  let eyil = end.year();

                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "index.aspx/Get",
                      //data: '{ count: 10 }',
                      data: `{ bgun: ${bgun}, bay: ${bay}, byil: ${byil}, egun: ${egun}, eay: ${eay}, eyil: ${eyil}}`, 
                      success: function (data) {
              

                          callback(data.d);
                      },
                      error: function (err) {
                          alert(err + '');
                      }
                  });

              },
          aspectRatio: 2, //en - boy oranı ayarlamak
          //height: 500, yüksekliği ayarlamak
          //contentHeight: 500,
          views: { //farklı view görünümlerini özelleştirmek
              month: {
                  titleFormat: 'MMMM'
              },
              basicWeek: {
                  titleFormat: 'MMMM YYYY',
                  weekends: false,
              }
          }
          });
      });
    
    </script>
</head>
<body>
    <div id="events">
        <div class="fc-event">Olay 1</div>
        <div class="fc-event">Olay 2</div>
        <div class="fc-event">Olay 3</div>
    </div>
    <div id="calendar"></div>
</body>
</html>
