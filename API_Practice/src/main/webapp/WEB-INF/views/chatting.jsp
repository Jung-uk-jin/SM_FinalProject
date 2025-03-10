<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
    <title>Chat Application</title>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
    <style>
        #chat {
            width: 400px;
            height: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            overflow-y: auto;
            background-color: #f9f9f9;
        }

        #messageInput {
            width: 300px;
            margin-top: 10px;
        }

        button {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <h1>Chat Application</h1>
	<div>버튼을 클릭하시면 참여가 가능합니다.</div>
    <button onclick="joinRoom()">Join Room</button>

    <div id="chat">
        <!-- 채팅 메시지가 표시될 영역 -->
    </div>

    <input type="text" id="messageInput" placeholder="Enter message" disabled />
    <button onclick="sendMessage()" disabled>Send</button>

    <script>
        let stompClient = null;
        let currentRoomId = null;

        // 고정된 방 번호 1234로 자동 연결
        function joinRoom() {
            const socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, function (frame) {
                console.log('Connected');
                
                // 고정된 방 번호 1234로 자동 연결
                currentRoomId = "1234"; // 고정된 방 번호

                // 메시지 구독
                stompClient.subscribe('/topic/rooms/' + currentRoomId, function (message) {
                    const chatMessage = JSON.parse(message.body);
                    const chatDiv = document.getElementById('chat');
                    const newMessage = document.createElement('div');
                    newMessage.textContent = chatMessage.sender + ": " + chatMessage.content;
                    chatDiv.appendChild(newMessage);
                    
                    // 스크롤 가장 아래로 이동
                    chatDiv.scrollTop = chatDiv.scrollHeight;
                });

                // 채팅창 활성화
                document.getElementById('messageInput').disabled = false;
                document.querySelector('button[onclick="sendMessage()"]').disabled = false;
                document.getElementById('messageInput').addEventListener('keydown', function(event) {
                    if (event.key === 'Enter' && !event.shiftKey) {
                        event.preventDefault(); // 기본 엔터 동작 방지 (줄바꿈 방지)
                        sendMessage();
                    }
                });
            });
        }

        function sendMessage() {
            const messageInput = document.getElementById('messageInput');
            const messageContent = messageInput.value.trim();

            if (!messageContent || !currentRoomId) {
                return;
            }

            const message = {
                sender: '${session_id}', // 실제 사용자 이름을 여기 넣을 수 있음
                content: messageContent,
                type: 'CHAT'
            };

            stompClient.send('/app/chat/' + currentRoomId, {}, JSON.stringify(message));
            messageInput.value = ''; // 입력 필드 초기화
        }
        
        
    </script>
</body>
</html>



