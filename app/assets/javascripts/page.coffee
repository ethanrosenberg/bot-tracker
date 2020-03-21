App.room = App.cable.subscriptions.create "WebNotificationsChannel",
  received: (data) ->
    $('#search_' + data['id'] +  '> td.col.col-cable').append data['message']
    #$('#page_title').append "Working"
