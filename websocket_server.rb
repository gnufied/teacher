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
        student = ws
      when "teacher"
        teacher = ws
      when "correct"
        if student
          student.send("correct")
        end
      when "wrong"
        if student
          student.send("wrong")
        end
      else
        puts "Unhandled message"
      end
    end
  end
}
