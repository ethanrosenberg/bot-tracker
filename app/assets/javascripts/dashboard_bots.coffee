App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    $('#bots_count').text data['bots_count']

#tweets
    #messages
    #$('#search_' + data['id'] +  '> td.col.col-cable').text data['message']
    #$('#search_' + data['id'] +  '> td.col.col-cable').append data['message']
    #$('#page_title').append "Working"
#myBar#search_206 > td:nth-child(10)

#$('#search_206 myBar').text
#search_271 > td.col.col-results
