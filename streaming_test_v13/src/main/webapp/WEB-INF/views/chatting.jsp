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

        #userCount {
            font-size: 16px;
            font-weight: bold;
            margin-top: 10px;
        }

        #chatHeader {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>Chat Application</h1>						
    <div>채팅방에 자동으로 참여합니다.</div>

    <!-- 사용자 수 표시 -->
    <div id="userCount">Current User Count: <span>${userCount}</span></div>

    <!-- 채팅창 -->
    <div id="chatHeader">Chat Room</div>
    <div id="chat">
        <!-- 채팅 메시지가 표시될 영역 -->
    </div>

    <input type="text" id="messageInput" placeholder="Enter message" disabled />
    <button onclick="sendMessage()" disabled>Send</button>

    <script>
        let stompClient = null;
        let currentRoomId = "1234";  // 방 번호를 여기 고정 또는 동적으로 설정할 수 있습니다.

        // WebSocket 연결을 위한 설정 (페이지 로드 시 바로 연결)
        function connectSocket() {
            const socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);

            stompClient.connect({}, function (frame) {
                console.log('Connected');
                
                // userCount 업데이트를 위해 구독
                stompClient.subscribe('/topic/userCount', function (message) {
                    let userCount = message.body;  // 서버에서 전달한 사용자 수
                    // 사용자 수 업데이트 (HTML에 표시)
                    document.getElementById("userCount").innerText = "Current User Count: " + userCount;
                });

                // 채팅 메시지 구독
                stompClient.subscribe('/topic/rooms/' + currentRoomId, function (message) {
                    const chatMessage = JSON.parse(message.body);
                    const chatDiv = document.getElementById('chat');
                    const newMessage = document.createElement('div');
                    newMessage.textContent = chatMessage.sender + ": " + chatMessage.content;
                    chatDiv.appendChild(newMessage);

                    // 채팅 기록을 sessionStorage에 저장 (새로고침 후에도 유지)
                    saveChatHistory(chatMessage.sender + ": " + chatMessage.content);
                    
                    // 스크롤 가장 아래로 이동
                    chatDiv.scrollTop = chatDiv.scrollHeight;
                });

                // 채팅창 활성화
                document.getElementById('messageInput').disabled = false;
                document.querySelector('button[onclick="sendMessage()"]').disabled = false;
            });
        }

        // 채팅 기록을 sessionStorage에 저장하는 함수
        function saveChatHistory(message) {
            let chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];
            chatHistory.push(message);
            sessionStorage.setItem("chatHistory", JSON.stringify(chatHistory));
        }

        // 페이지 로드 시 기존 채팅 기록 불러오기
        function loadChatHistory() {
            let chatHistory = JSON.parse(sessionStorage.getItem("chatHistory")) || [];
            const chatDiv = document.getElementById('chat');
            chatHistory.forEach(msg => {
                const newMessage = document.createElement('div');
                newMessage.textContent = msg;
                chatDiv.appendChild(newMessage);
            });
            // 스크롤 가장 아래로 이동
            chatDiv.scrollTop = chatDiv.scrollHeight;
        }

        // 메시지 보내기
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

        // 페이지가 로드되면 자동으로 WebSocket 연결 및 기존 채팅 기록 로드
        window.onload = function() {
            const isNewSession = !sessionStorage.getItem('hasVisited');
            if (isNewSession) {
                // 새로 들어온 사용자라면 1초 후 새로 고침
                sessionStorage.setItem('hasVisited', 'true');
                setTimeout(function() {
                    location.reload();  // 새로 고침
                }, 2000); // 1초 후 새로 고침
            } else {
                // 이미 방문한 사용자라면 새로 고침하지 않음
                connectSocket();  // WebSocket 연결 시작
                loadChatHistory(); // 기존 채팅 기록 로드
            }
        };
    </script>
</body>
</html>
