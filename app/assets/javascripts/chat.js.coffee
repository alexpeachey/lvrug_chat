class Chat
  constructor: ->
    @fayeURL = $('meta[name="faye-url"]').attr('content')
    @faye = new Faye.Client(@fayeURL)
    @faye.subscribe '/chat', @processMessage
    @wireChatInput()

  processMessage: (data) =>
    @insertMessage(@buildMessage(JSON.parse(data)))

  buildMessage: (data) =>
    now = new Date().toISOString()
    "<div class='row message'><div class='small-2 columns'><span class='label round'>#{data.name}</span><time class='timeago' datetime='#{now}'>#{now}</time></div><div class='small-10 columns'><div class='alert-box secondary'>#{data.message}</div></div></div>"

  insertMessage: (message) =>
    $('#chat-window').append(message)
    $('#chat-window .message:last-child time.timeago').timeago()

  wireChatInput: =>
    $('#message').on 'keypress', @captureEnter
    $('#message-button').on 'click', @sendMessage

  captureEnter: (e) =>
    @sendMessage(e) if e.keyCode is 13

  sendMessage: (e) =>
    e.preventDefault()
    $.post '/messages', { message: $('#message').val() }
    $('#message').val('').focus()


$ ->
  new Chat()