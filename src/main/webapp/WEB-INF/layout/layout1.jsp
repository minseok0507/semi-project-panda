<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
    <title>PANDA</title>
    <meta charset="UTF-8">
    <link href="/image/icon.png" rel="shortcut icon" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Dancing+Script:wght@400..700&family=East+Sea+Dokdo&family=Jua&family=Gaegu&family=Gamja+Flower&family=Pacifico&family=Single+Day&display=swap"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <style>
        html, body, .mainlayout {
        }

        .mainlayout {
            background-color: white;
        }

        #bot {
            position: fixed;
            bottom: 120px;
            left: 30px;
            width: 70px;
            height: 50px;
            background-color: rgba(0, 0, 0);
            border-radius: 20px;
            z-index: 800;
            justify-content: center;
        }

        /* 위로 가는 버튼 */
        .scroll-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            display: none;
            width: 50px;
            height: 50px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 50%;
            text-align: center;
            font-size: 24px;
            line-height: 50px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1;
            transition: all 0.3s ease;
        }

        .scroll-to-top:hover {
            background-color: #45a049;
        }
    </style>
</head>
<c:set var="root" value="<%=request.getContextPath() %>" scope="application"/>
<body>
<div class="mainlayout">
    <div id="header-tile" class="header-tile">
        <tiles:insertAttribute name="header"/>
    </div>
    <div id="main-tile" class="main-tile">
        <tiles:insertAttribute name="main"/>
    </div>
    <!-- 챗봇버튼 -->
    <button onclick="chatbotShow()" id="bot">
        <img src="${root}/image/logo.png">
    </button>

    <!-- 위로 가는 버튼 -->
    <button onclick="scrollToTop()" class="scroll-to-top" id="scrollToTopBtn">
        <i class="bi bi-caret-up-fill"></i>
    </button>
    <div id="footer-tile" class="footer-tile">
        <tiles:insertAttribute name="footer"/>
    </div>
</div>

<script>
    let headerTile = document.getElementById("header-tile");
    let footerTile = document.getElementById("footer-tile");
    let mainTile = document.getElementById("main-tile");

    let height = headerTile.offsetHeight + footerTile.offsetHeight;
    mainTile.style.minHeight = `calc(100vh - \${height}px)`;
    // 위로 가는 버튼 보임 여부
    window.onscroll = function () {
        var scrollToTopBtn = document.getElementById("scrollToTopBtn");
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            scrollToTopBtn.style.display = "block";
        } else {
            scrollToTopBtn.style.display = "none";
        }
    };

    // 위로 가는 버튼 동작
    function scrollToTop() {
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0;
    }
</script>


<%--채팅방 띄우기--%>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"/>


<style>
    .chat-area {
        z-index: 900;
        position: fixed;
        left: 30px;
        bottom: 30px;
    <c:if test="${sessionScope.usernum == null}"> display: none;
    </c:if>
    }

    .chat-symbol {
        position: absolute;
        top: 0;
        left: 0;
        width: 70px;
        height: 70px;
        color: white;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #45a049;
        border-radius: 20%;
        cursor: pointer;

        transform: translateY(-100%);
        transition: 0.3s ease-in-out;
    }

    .chat-content {
        position: absolute;
        top: 0;
        left: 0;
        width: 300px;
        height: 400px;
        background-color: #ececec;
        border-radius: 5%;
        transform: scale(0) translateY(-100%);
        transition: 0.3s ease-in-out;
        transform-origin: 0 100%;
        box-shadow: 10px 10px 20px rgb(0, 0, 0, 0.5);

        overflow: hidden;
    }


    .chat-close {
        cursor: pointer;
    }

    .chat-list {
        overflow: auto;
        height: 320px;
    }

    .chat-content::-webkit-scrollbar {
        display: none;
    }


</style>
<div class="chat-area">
    <div class="chat-symbol">
        <span class="material-symbols-outlined" style="font-size: 45px">
        chat_bubble
        </span>
    </div>
    <div class="chat-content">
        <div class="absolute right-3 top-3 chat-close" id="chat-close">
            <span class="material-symbols-outlined">
            close
            </span>
        </div>
        <h1 class="text-xl font-bold text-[black] p-3">채팅방</h1>
        <div class="chat-list">

            <div class="flex flex-col w-full max-w-md mx-auto rounded-lg">
                <div class="flex-1" id="chatroom-list">
                </div>
            </div>

        </div>
    </div>

</div>

<style>
    #chattingArea {
        position: fixed;
        left: -600px;
        bottom: 30px;
        z-index: 999;
        width: 500px;
        height: 80%;
        transition: 0.3s ease-in-out;
        border-radius: 20px;
    }

    #chat-send-form {
        position: absolute;
        bottom: 0;
        width: 100%;
    }

    #chat-scroll {
        overflow: auto;
        height: calc(100% - 89px - 50px);
    }

    #chat-head {
        top: 0;
        height: 50px;
        width: 100%;

        border-bottom: 1px solid lightgray;
    }

    #chat-head-title {
        height: 100%;
        font-size: 20px;
        line-height: 50px;
        margin-left: 15px;
        width: 90%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    #chat-head-member {
        font-weight: bold;
        color: #333;
    }
</style>

<div class="flex flex-col bg-white rounded-2xl shadow-2xl" id="chattingArea">
    <input type="hidden" id="sessionId" value="">
    <input type="hidden" id="roomId" value="">
    <div id="chat-head">
        <div id="chat-head-title" class="text-xl font-bold text-[black]">글 제목이 뜰거임</div>
        <div id="chat-head-member"></div>

        <div class="absolute right-3 top-3 chat-close" id="chatting-close">
            <span class="material-symbols-outlined">
            close
            </span>
        </div>
    </div>
    <div id="chat-scroll">
        <div class="flex-1  p-4">
            <div class="space-y-4 w-full chating" id="chating">


            </div>
        </div>
    </div>
    <div class="rounded-b-2xl bg-white border-t border-gray-200 p-4 flex items-center" id="chat-send-form">
        <input
                class="flex h-10 w-full rounded-md border border-input px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 flex-1 bg-gray-100 border-none focus:ring-0 focus:outline-none"
                id="chatting"
                placeholder="Type your message..."
        />
        <button class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 bg-[#4CAF50] hover:bg-green-600 text-white ml-2"
                onclick="send()" id="sendBtn"
        >
            Send
        </button>
    </div>
</div>


<script>
    let ws;

    document.getElementsByClassName("chat-symbol")[0].addEventListener("click", function () {
        document.getElementsByClassName("chat-content")[0].style.transform = "scale(1) translateY(-100%)";
        fetch('/chat/room', {
            method: 'GET',
            credentials: 'include'
        })
            .then(response => response.json())
            .then(data => {
                let listArea = document.getElementById("chatroom-list");
                let s = "";
                // 서버에서 반환된 ChatroomPrintDto 목록 처리
                // href="/chatting/\${chatroom.chatroomnum}"
                data.forEach(chatroom => {
                    if (chatroom.applyusernickname === "${sessionScope.usernickname}") {
                        s += `
                    <a class="hover:bg-gray-100 p-2 flex items-center gap-2 transition-colors hover:bg-muted" onclick="chatStart(\${chatroom.chatroomnum})">
                      <span class="relative flex shrink-0 overflow-hidden rounded-full border w-12 h-12">
                        <img class="aspect-square h-full w-full" alt="Chatroom Image"
                             src="https://minio.minseok.site/semi-panda/panda/\${chatroom.productuserprofile}"/>
                      </span>
                        <div class="flex-1 grid gap-1">
                            <div class="flex items-center justify-between">
                                <h3 class="text-base font-medium truncate w-1/3 text-left">\${chatroom.productusernickname}</h3>
                                <span class="text-xs text-muted-foreground truncate w-2/3 text-right">
                                    \${chatroom.productaddress}
                                </span>
                            </div>
                            <p class="text-sm text-muted-foreground truncate">
                                \${chatroom.chatroomname}
                            </p>
                        </div>
                    </a>
                    `;
                    } else {
                        s += `
                    <a class="hover:bg-gray-100 p-2 flex items-center gap-2 transition-colors hover:bg-muted" onclick="chatStart(\${chatroom.chatroomnum})">
                      <span class="relative flex shrink-0 overflow-hidden rounded-full border w-12 h-12">
                        <img class="aspect-square h-full w-full" alt="Chatroom Image"
                             src="https://minio.minseok.site/semi-panda/panda/\${chatroom.applyprofile}"/>
                      </span>
                        <div class="flex-1 grid gap-1">
                            <div class="flex items-center justify-between">
                                <h3 class="text-base font-medium truncate w-1/3 text-left">\${chatroom.applyusernickname}</h3>
                                <span class="text-xs text-muted-foreground truncate w-2/3 text-right">
                                    \${chatroom.productaddress}
                                </span>
                            </div>
                            <p class="text-sm text-muted-foreground truncate">
                                \${chatroom.chatroomname}
                            </p>
                        </div>
                    </a>
                    `;
                    }
                });
                listArea.innerHTML = s;
                document.getElementsByClassName("chat-symbol")[0].style.transform = "scale(0) translateY(-100%)";
            })
            .catch(error => {
                console.error('Error:', error);
            });


    })

    document.getElementsByClassName("chat-close")[0].addEventListener("click", function () {
        document.getElementsByClassName("chat-content")[0].style.transform = "scale(0) translateY(-100%)";
        document.getElementsByClassName("chat-symbol")[0].style.transform = "scale(1) translateY(-100%)";
    })

    function chatStart(chatRoom) {
        fetch(`/chat/name?chatroomnum=` + chatRoom)
            .then(response => response.json())
            .then(data => {
                document.getElementById("chattingArea").style.left = "30px";
                ws = new WebSocket("wss://" + location.host + "/chatroom/" + chatRoom);
                document.getElementById("chating").innerHTML = "";
                document.getElementById("roomId").value = chatRoom;
                wsEvt(chatRoom);
                document.getElementById("chat-head-title").innerHTML =
                    `<a href="/product/detail?productnum=\${data.productnum}">\${data.chatroomname}</a>`;
                if (data.applyusernickname === "${sessionScope.usernickname}") {
                    document.getElementById("chat-head-member").innerText = `\${data.productusernickname}님과 채팅`;
                } else {
                    document.getElementById("chat-head-member").innerText = `\${data.applyusernickname}님과 채팅`;
                }
            })
            .catch(error => {
                console.error('Error fetching chat log:', error);
                alert("chatStart 접속 실패")
                window.location.reload()
            });

    }

    document.getElementById("chatting-close").addEventListener("click", function () {
        document.getElementById("chattingArea").style.left = "-600px";
        document.getElementById("sessionId").value = "";
        document.getElementById("roomId").value = "";
        ws.close();
    })
</script>


<%--채팅 모달 js--%>
<script type="text/javascript">
    //
    // function wsOpen(chatRoom) {
    //     //웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
    //     ws = new WebSocket("ws://" + location.host + "/chatroom/" + chatRoom);
    //     wsEvt(chatRoom);
    // }

    function wsEvt(chatRoom) {
        ws.onerror = function (error) {
            console.error("WebSocket error:", error);
        };

        ws.onopen = function (data) {
            //소켓이 열리면 동작
            fetch(`/chat/repository?chatroomnum=` + chatRoom)
                .then(response => response.json())
                .then(data => {
                    // 가져온 채팅 내역 데이터를 화면에 표시하는 로직 구현
                    displayChatting(data)
                    var chatDiv = $("#chat-scroll");
                    chatDiv.scrollTop(chatDiv.prop("scrollHeight"));
                })
                .catch(error => {
                    console.error('Error fetching chat log:', error);
                    alert("onopen 접속 실패")
                    window.location.reload()
                });
        }

        ws.onmessage = function (data) {
            //메시지를 받으면 동작
            var msg = data.data;
            if (msg != null && msg.trim() != '') {
                var d = JSON.parse(msg);
                if (d.type == "getId") {
                    var si = d.sessionId != null ? d.sessionId : "";
                    if (si != '') {
                        $("#sessionId").val(si);
                    }
                } else if (d.type == "message") {
                    if (d.usernum == ${sessionScope.usernum}) {
                        $("#chating").append(
                            `
                            <%--                   내 채팅 --%>
                                    <div class="flex items-start gap-3 justify-end">
                                        <div class="bg-gray-200 text-gray-900 px-3 py-2 rounded-lg max-w-[75%]">
                                            <!--<p class="font-medium">\${d.userNickName}</p>-->
                                            <p>\${d.msg}</p>
                                        </div>
                                        <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#4CAF50] text-white flex items-center justify-center border-2 border-[#4CAF50]">
                                            <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                                                <img class="aspect-square h-full w-full" alt="Seller"
                                                   src="https://minio.minseok.site/semi-panda/panda/\${d.userProfile}"/>
                                            </span>
                                        </span>
                                    </div>
                            `
                        );
                        var chatDiv = $("#chat-scroll");
                        chatDiv.scrollTop(chatDiv.prop("scrollHeight"));
                    } else {
                        $("#chating").append(`
                        <%--                상대 채팅--%>
                                    <div class="flex items-start gap-3">
                                        <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#4CAF50] text-white flex items-center justify-center border-2 border-[#4CAF50]">
                                          <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                                              <img class="aspect-square h-full w-full" alt="Seller"
                                                   src="https://minio.minseok.site/semi-panda/panda/\${d.userProfile}"
                                                   onclick="location.href='/mypage?usernum=\${d.usernum}'"/>
                                          </span>
                                        </span>
                                        <div class="bg-[#4CAF50] text-white px-3 py-2 rounded-lg max-w-[75%] relative">
                                            <!--<p class="font-medium">\${d.userNickName}</p>-->
                                            <p>\${d.msg}</p>
                                        </div>
                                    </div>
                        `);
                        var chatDiv = $("#chat-scroll");
                        chatDiv.scrollTop(chatDiv.prop("scrollHeight"));
                    }

                } else {
                    console.warn("unknown type!")
                }
            }
        }

        document.addEventListener("keypress", function (e) {
            if (e.keyCode == 13) { //enter press
                if ($("#chatting").val().length === 0 || $("#roomId").val().length === 0) {
                    return;
                }
                send();
            }
        });

        function displayChatting(chattingData) {
            const chatLogContainer = document.getElementById('chating');
            chattingData.forEach(chat => {
                if (chat.sendusernum == "${sessionScope.usernum}") {
                    chatLogContainer.innerHTML +=
                        `
                <%--                    내 채팅--%>
                    <div class="flex items-start gap-3 justify-end">
                        <div class="bg-gray-200 text-gray-900 px-3 py-2 rounded-lg max-w-[75%]">

                            <p>\${chat.chattingmessage}</p>
                        </div>
                        <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#4CAF50] text-white flex items-center justify-center border-2 border-[#4CAF50]">
                            <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                                <img class="aspect-square h-full w-full" alt="Seller"
                                   src="https://minio.minseok.site/semi-panda/panda/\${chat.userprofileimage}"/>
                            </span>
                        </span>
                    </div>
                `;
                } else {

                    chatLogContainer.innerHTML +=
                        `
                <%--                    구매자 채팅 시작--%>
                    <div class="flex items-start gap-3">
                        <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#4CAF50] text-white flex items-center justify-center border-2 border-[#4CAF50]">
                          <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                              <img class="aspect-square h-full w-full" alt="Seller"
                                   src="https://minio.minseok.site/semi-panda/panda/\${chat.userprofileimage}"
                                   onclick="location.href='/mypage?usernum=\${chat.sendusernum}'"/>
                          </span>
                        </span>
                        <div class="bg-[#4CAF50] text-white px-3 py-2 rounded-lg max-w-[75%] relative">

                            <p>\${chat.chattingmessage}</p>

                        </div>
                    </div>
            `;
                }


            });

        }
    }


    function send() {
        let roomid = $("#roomId").val()
        var option = {
            type: "message",
            roomNumber: roomid,
            usernum: ${sessionScope.usernum},
            userProfile: "${sessionScope.userprofileimage}",
            userNickName: "${sessionScope.usernickname}",
            msg: $("#chatting").val()
        }
        ws.send(JSON.stringify(option))
        $('#chatting').val("");
    }
</script>


<style>
    .chatbot-area {
        z-index: 901;
        position: fixed;
        width: 500px;
        height: 500px;
        bottom: 30px;
        left: -600px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 10px 10px 50px rgb(0, 0, 0, 0.6);
        overflow: hidden;
        transition: 0.3s ease-in-out;
    }

    #chatbot-send-form {
        position: absolute;
        bottom: 0;
        width: 100%;
    }

    .chatbot-scroll {
        overflow: auto;
        margin-top: 10px;
        height: calc(100% - 67px);
    }
</style>

<%--챗봇--%>
<div class="chatbot-area" style="">
    <div class="absolute right-3 top-3 chat-close" id="chatbot-close" onclick="chatbotClose()">
            <span class="material-symbols-outlined">
            close
            </span>
    </div>

    <div class="chatbot-scroll">
        <div class="flex-1  p-4" id="conversation">
            <div class="space-y-4 w-full" id="communicate">


            </div>
        </div>
    </div>
    <form class="rounded-b-2xl bg-white border-t border-gray-200 p-2 flex items-center" id="chatbot-send-form">
        <input
                class="flex h-10 w-full rounded-md border border-input px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 flex-1 bg-gray-100 border-none focus:ring-0 focus:outline-none"
                id="msg"
                placeholder="Type your message..."
        />
        <button class="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 bg-[#4CAF50] hover:bg-green-600 text-white ml-2"
                onclick="send()" id="send" disabled type="submit">
            Send
        </button>
    </form>
</div>


<script>
    function chatbotClose(){
        document.getElementsByClassName("chatbot-area")[0].style.left = "-600px";
    }

    function chatbotShow(){
        document.getElementsByClassName("chatbot-area")[0].style.left = "30px";
    }

    var stompClient = null;

    function setConnected(connected) {
        $("#connect").prop("disabled", connected);
        $("#disconnect").prop("disabled", !connected);
        $("#send").prop("disabled", !connected);
        if (connected) {
            $("#conversation").show();
        } else {
            $("#conversation").hide();
        }
        $("#msg").val("");
    }

    function connect() {
        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            setConnected(true);
            // console.log('Connected: ' + frame);
            // 기본 안내멘트 추가
            showMessage("판다챗봇에 오신 것을 환영합니다!<br>" +
                "무엇을 도와드릴까요?<br><br>" +
                "<button class='btn btn-info quick-btn' style='background-color: #fff; border: 0; font-size: 15px; margin-right: 10px;' data-question='거래'>거래방법</button>" +
                "<button class='btn btn-info quick-btn' style='background-color: #fff; border: 0; font-size: 15px; margin-right: 10px;' data-question='배송'>배송관련</button>" +
                "<button class='btn btn-info quick-btn' style='background-color: #fff; border: 0; font-size: 15px; margin-right: 10px;' data-question='사기'>사기문의</button>", "message-received");

            stompClient.subscribe('/topic/public', function (message) {
                showMessage(message.body, "message-received"); // 서버에 메시지 전달 후 리턴받는 메시지
                // 채팅 내용이 갱신될 때 스크롤을 가장 아래로 이동
                scrollToBottom();
            });
        });
    }

    function disconnect() {
        if (stompClient !== null) {
            stompClient.disconnect();
        }
        setConnected(false);
        console.log("Disconnected");
    }

    function sendMessage() {
        let message = $("#msg").val()
        if (message.length === 0) {
            return;
        }
        showMessage(message, "message-sent");
        $("#msg").val(""); // 메시지를 보낸 후 입력 필드를 비우기

        stompClient.send("/app/sendMessage", {}, JSON.stringify(message)); // 서버에 보낼 메시지

        //스크롤을 가장 아래로 이동
        scrollToBottom();
    }

    function sendQuickMessage(question) {
        showMessage(question, "message-sent");
        stompClient.send("/app/sendMessage", {}, JSON.stringify(question));
        //스크롤을 가장 아래로 이동
        scrollToBottom();
    }

    function showMessage(message, messageClass) {
        if (messageClass === "message-received") {
            $("#communicate").append(
                // "<img src='../image/panda.png' style='width: 40px; height: auto'>" +
                `
                <div class="flex items-start gap-3">
                    <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#fff] text-white flex items-center justify-center border-0 border-[#4CAF50]">
                      <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                          <img class="aspect-square h-full w-full" alt="Seller"
                               src='/image/panda.png'/>
                      </span>
                    </span>
                    <div class="bg-[#4CAF50] text-white px-3 py-2 rounded-lg max-w-[75%] relative">
                        <p>\${message}</p>
                    </div>
                </div>
                `
                // +
                // "<tr class='received'><td class='message " + messageClass + "'>" +
                // "<div class='received-message-content'>" +
                // "<div class='message-text'>" + message + "</div>" +
                // "</div></td></tr>"
            );
        } else {
            $("#communicate").append(
                `
                <div class="flex items-start gap-3 justify-end">
                    <div class="bg-gray-200 text-gray-900 px-3 py-2 rounded-lg max-w-[75%]">
                        <p>\${message}</p>
                    </div>
                </div>
                `
                // "<tr class='sent'><td class='message " + messageClass + "'>" + message + "</td></tr>"
            );
        }
        //스크롤을 가장 아래로 이동
        scrollToBottom();
    }

    function scrollToBottom() {
        var chatbotDiv = $(".chatbot-scroll");
        chatbotDiv.scrollTop(chatbotDiv.prop("scrollHeight"));
    }

    $(function () {
        connect();
        $("#chatbot-send-form").on('submit', function (e) {
            e.preventDefault();
        });
        $("#connect").click(function () {
            connect();
        });
        $("#disconnect").click(function () {
            disconnect();
        });
        $("#send").click(function () {
            sendMessage();
        });

        $(document).on('click', '.quick-btn', function () {
            let question = $(this).data('question');
            sendQuickMessage(question);
        });
    });

</script>


</body>
</html>















