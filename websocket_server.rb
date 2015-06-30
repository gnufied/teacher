require "em-websocket"

student = nil
teacher = nil

EM.run {
  EM::WebSocket.run(host: "0.0.0.0", port: 8080) do |ws|
    ws.onopen do |handshake|
      puts "WebSocket connection open"

      # Access properties on the EM::WebSocket::Handshake object, e.g.
      # path, query_string, origin, headers

      # Publish message to the client
      ws.send "identify"
    end

    ws.onclose { puts "Connection closed" }

    ws.onmessage do |msg|
      case msg
      when "student"
        puts "Student is connected now"
        student = ws
      when "teacher"
        puts "Teacher is connected now"
        teacher = ws
      when "1"
        puts "Received correct"
        if student
          student.send("1")
        end
      when "2"
        puts "received wrong"
        if student
          student.send("2")
        end
      when "3"
        puts "play response"
        if student
          student.send("3")
        end
      else
        puts "Unhandled message"
      end
    end
  end
}
