require "websocket-client-simple"

ws = WebSocket::Client::Simple.connect 'ws://192.168.1.2:8080'

ws.on :message do |msg|
  if msg.data == "identify"
    ws.send "teacher"
  end
end

ws.on :open do
  puts "Socket is open now"
end

ws.on :close do |e|
  p e
  exit 1
end

ws.on :error do |e|
  p e
end

loop do
  ws.send STDIN.gets.strip
end
