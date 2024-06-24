<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Dancing+Script:wght@400..700&family=East+Sea+Dokdo&family=Jua&family=Gaegu&family=Gamja+Flower&family=Pacifico&family=Single+Day&display=swap"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <style>
        html, body, .mainlayout {
            height: 100%;
            background-color: black;
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
            background-color: rgba(0, 0, 0, 0.84);
            border-radius: 20px;
        }

        #pay {
            position: fixed;
            bottom: 180px;
            left: 30px;
            width: 70px;
            height: 50px;
            background-color: #4CAF50;
            color: white;
            border-radius: 20px;
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
<c:set var="filepath" value="https://kr.object.ncloudstorage.com/semi/panda/"/>
<body>
<div class="mainlayout">
    <div class="header-tile">
        <tiles:insertAttribute name="header"/>
    </div>
    <div class="main-tile">
        <tiles:insertAttribute name="main"/>
    </div>
    <!-- 챗봇버튼 -->
    <button onclick="location.href='./chatbot'" id="bot">
        <img src="https://kr.object.ncloudstorage.com/semi/panda/logo.png">
    </button>

    <!-- 결제버튼 -->
    <button onclick="location.href='./pay'" id="pay">
        <p>결제</p>
    </button>
    <!-- 위로 가는 버튼 -->
    <button onclick="scrollToTop()" class="scroll-to-top" id="scrollToTopBtn">
        <i class="bi bi-caret-up-fill"></i>
    </button>
    <div class="footer-tile">
        <tiles:insertAttribute name="footer"/>
    </div>
</div>

<script>
    let headerTile = document.getElementsByClassName("header-tile")[0];
    let footerTile = document.getElementsByClassName("footer-tile")[0];
    let mainTile = document.getElementsByClassName("main-tile")[0];

    let height = headerTile.offsetHeight + footerTile.offsetHeight;
    mainTile.style.minHeight = `calc(100% - \${height}px)`;

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
    <div class="chat-content shadow-2xl">
        <div class="absolute right-3 top-3 chat-close" id="chat-close">
            <span class="material-symbols-outlined">
            close
            </span>
        </div>
        <h1 class="text-xl font-bold text-[black] p-3">채팅방</h1>
        <div class="chat-list">

            <!--
// v0 by Vercel.
// https://v0.dev/t/MWsK0IcOVFw
-->

            <div class="flex flex-col w-full max-w-md mx-auto rounded-lg">
                <div class="flex-1" id="chatroom-list">

                    <%--                    <a class="my-2 flex items-center gap-2 transition-colors hover:bg-muted" href="#">--%>
                    <%--                      <span class="relative flex shrink-0 overflow-hidden rounded-full border w-12 h-12">--%>
                    <%--                        <img class="aspect-square h-full w-full" alt="Chatroom Image"--%>
                    <%--                             src="https://generated.vusercontent.net/placeholder-user.jpg"/>--%>
                    <%--                      </span>--%>
                    <%--                        <div class="flex-1 grid gap-1">--%>
                    <%--                            <div class="flex items-center justify-between">--%>
                    <%--                                <h3 class="text-base font-medium">민석잉</h3>--%>
                    <%--                                <span class="text-xs text-muted-foreground">--%>
                    <%--                                    서울 강남구 가로수길 5--%>
                    <%--                                </span>--%>
                    <%--                            </div>--%>
                    <%--                            <p class="text-sm text-muted-foreground truncate">--%>
                    <%--                                글 제목 임시글 어쩌고 글 제목 임시글 어쩌고 글 제목 임시글 어쩌고--%>
                    <%--                            </p>--%>
                    <%--                        </div>--%>
                    <%--                    </a>--%>


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
</style>

<div class="flex flex-col bg-white rounded-2xl shadow-2xl" id="chattingArea">
    <input type="hidden" id="sessionId" value="">
    <input type="hidden" id="roomId" value="">
    <div id="chat-head">
        <div id="chat-head-title">글 제목이 뜰거임</div>

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
                    s += `
                    <a class="hover:bg-gray-100 p-2 flex items-center gap-2 transition-colors hover:bg-muted" onclick="chatStart(\${chatroom.chatroomnum})">
                      <span class="relative flex shrink-0 overflow-hidden rounded-full border w-12 h-12">
                        <img class="aspect-square h-full w-full" alt="Chatroom Image"
                             src="https://kr.object.ncloudstorage.com/semi/panda/\${chatroom.applyprofile}"/>
                      </span>
                        <div class="flex-1 grid gap-1">
                            <div class="flex items-center justify-between">
                                <h3 class="text-base font-medium">\${chatroom.applyusernickname}</h3>
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
                    console.log(`채팅방 번호: \${chatroom.chatroomnum}`);
                    console.log(`채팅방 이름: \${chatroom.chatroomname}`);
                    console.log(`상품 주소: \${chatroom.productaddress}`);
                    console.log(`신청자 닉네임: \${chatroom.applyusernickname}`);
                    console.log(`신청자 프로필: \${chatroom.applyprofile}`);
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
        document.getElementById("chattingArea").style.left = "30px";
        ws = new WebSocket("ws://" + location.host + "/chatroom/" + chatRoom);
        document.getElementById("chating").innerHTML = "";
        document.getElementById("roomId").value = chatRoom;
        wsEvt(chatRoom);
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
                    alert("접속 실패")
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
                                        <div class="bg-gray-200 text-gray-900 px-4 py-2 rounded-lg max-w-[75%]">
                                            <p class="font-medium">\${d.userNickName}</p>
                                            <p>\${d.msg}</p>
                                        </div>
                                        <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#4CAF50] text-white flex items-center justify-center border-2 border-[#4CAF50]">
                                            <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                                                <img class="aspect-square h-full w-full" alt="Seller"
                                                   src="https://kr.object.ncloudstorage.com/semi/panda/\${d.userProfile}"/>
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
                                                   src="https://kr.object.ncloudstorage.com/semi/panda/\${d.userProfile}"
                                                   onclick="location.href='/mypage?usernum=\${d.usernum}'"/>
                                          </span>
                                        </span>
                                        <div class="bg-[#4CAF50] text-white px-4 py-2 rounded-lg max-w-[75%] relative">
                                            <p class="font-medium">\${d.userNickName}</p>
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
                if ($("#chatting").val().length > 0 || $("#roomId").val().length > 0) {
                    send();
                }
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
                        <div class="bg-gray-200 text-gray-900 px-4 py-2 rounded-lg max-w-[75%]">
                            <p class="font-medium">\${chat.usernickname}</p>
                            <p>\${chat.chattingmessage}</p>
                        </div>
                        <span class="relative shrink-0 overflow-hidden w-10 h-10 rounded-full bg-[#4CAF50] text-white flex items-center justify-center border-2 border-[#4CAF50]">
                            <span class="flex h-full w-full items-center justify-center rounded-full bg-muted">
                                <img class="aspect-square h-full w-full" alt="Seller"
                                   src="https://kr.object.ncloudstorage.com/semi/panda/\${chat.userprofileimage}"/>
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
                                   src="https://kr.object.ncloudstorage.com/semi/panda/\${chat.userprofileimage}"
                                   onclick="location.href='/mypage?usernum=\${chat.sendusernum}'"/>
                          </span>
                        </span>
                        <div class="bg-[#4CAF50] text-white px-4 py-2 rounded-lg max-w-[75%] relative">
                            <p class="font-medium">\${chat.usernickname}</p>
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


</body>
</html>















