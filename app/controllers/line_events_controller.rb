require 'line/bot'
def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = "1655673499"
    config.channel_token = "0b43f697bb5f8b570a8d3e09f859607f"
  }
end
def recieve
  body = request.body.read
  events = client.parse_events_from(body)
  events.each { |event|
    userId = event['source']['userId']  #userId取得
    p 'UserID: ' + userId # UserIdを確認
  debugger
  end
end