App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    $('#search_' + data['id'] + '> td.col.col-progress #myBar').attr("style", "--width: #{data['message']}%");
    #$('#search_' + data['id'] +  '> td.col.col-cable').text data['message']
    #$('#search_' + data['id'] +  '> td.col.col-cable').text data['message']
    #$('#search_' + data['id'] +  '> td.col.col-cable').append data['message']
    #$('#page_title').append "Working"
#myBar#search_206 > td:nth-child(10)

#$('#search_206 myBar').text
