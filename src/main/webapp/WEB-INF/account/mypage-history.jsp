<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <title>나의 내역</title>

    <style>
        .round-button {
            border-radius: 20px;
        }

        .active {
            background-color: black;
            color: white !important;
        }

        .grayscale {
            filter: grayscale(50%);
            position: relative;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.6);
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.25rem;
            color: gray;
            text-align: center;
        }

        .relative {
            position: relative;
        }
    </style>
</head>
<body>

<div class="bg-white text-gray-950 min-h-screen">
    <div class="container mx-auto px-4 md:px-6 py-8 md:py-12">
        <div class="flex flex-col min-h-screen">
            <section class="py-8 px-6 md:px-8">
                <div class="search-result-message items-center justify-between mb-6">
                    <c:if test="${sessionScope.usernum == usernum}">
                        <h2 class="text-2xl font-bold"><a href="">나의 내역</a></h2>
                    </c:if>
                    <c:if test="${sessionScope.usernum != usernum}">
                        <h2 class="text-2xl font-bold"><a href="">${usernickname}의 내역</a></h2>
                    </c:if>
                </div>
                <div class="flex items-center justify-between">
                    <a class="text-sm underline" href="./mypage/history?usernum=${usernum}&listname=sell"> </a>
                    <div id="menubutton" class="flex w-full justify-start mb-4">
                        <button id="sell"
                                class="tab-button round-button inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-black h-9 px-3 mr-2 bg-gray-200">
                            판매내역
                        </button>
                        <c:if test="${sessionScope.usernum == usernum}">
                            <button id="buy"
                                    class="tab-button round-button inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-black h-9 px-3 mr-2 bg-gray-200">
                                구매내역
                            </button>
                            <button id="wish"
                                    class="tab-button round-button inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-black h-9 px-3 mr-2 bg-gray-200">
                                찜목록
                            </button>
                        </c:if>
                    </div>
                </div>
                <div class="page active-page grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6"
                     id="page1">
                    <!-- 검색 결과가 표시될 영역 -->
                </div>
                <div id="no-result-message" class="w-full text-base text-gray-500" style="display: none;">
                    아직 판매한 이력이 없어요.
                </div>
            </section>
        </div>
    </div>
</div>

<script>
    $(function () {
        $(`#${listname}`).addClass("active");
        if ("${listname}" === "sell") {
            getSell();
        } else if ("${listname}" === "buy") {
            getBuy();
        } else if ("${listname}" === "wish") {
            getWish();
        }

        $(".tab-button").click(function () {
            $(this).addClass("active");
            $(this).siblings().removeClass("active");
        })

        $("#sell").click(function () {
            getSell();
        })
        $("#buy").click(function () {
            getBuy();
        })
        $("#wish").click(function () {
            getWish();
        })
    })

    function getSell() {
        $.ajax({
            type: "get",
            url: "${root}/getsell?usernum=${usernum}",
            dataType: "json",
            success: function (data) {
                let s = "";
                if (data.length === 0) {
                    s = `<div class="w-full text-base text-gray-500">아직 판매한 이력이 없어요.</div>`;
                } else {
                    $.each(data, function (idx, ele) {
                        s += `
                        <div class="relative rounded-lg border bg-card text-card-foreground shadow-sm">
                        <div class="relative w-full h-48">
                            <img src="https://kr.object.ncloudstorage.com/semi/panda/\${ele.imagefilename}" width="300" height="200" alt="Product" class="rounded-t-lg object-cover w-full h-48 \${ele.productstatus === '거래 완료' ? 'grayscale' : ''}" style="aspect-ratio:300/200;object-fit:cover"/>
                            \${ele.productstatus === '거래 완료' ? '<div class="overlay">SOLD</div>' : ''}
                            </div>
                            <div class="p-4">
                                <h3 class="text-lg font-medium mb-2">\${ele.producttitle}</h3>
                                <div class="mb-2">
                                    <span class="text-gray-500 mr-1">\${ele.productprice}원</span>
                                    <span class="text-gray-500">\${ele.productstatus}</span>
                                </div>
                                <div class="flex">
                    `;
                        if (ele.productstatus === "예약 중" && "${sessionScope.usernum}" == ele.usernum) {
                            s += `
                           <button class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-black h-9 rounded-md px-3 border-1 border-black mr-2 hover:bg-gray-200"
                            onClick="alertReserveCancelBtn(\${ele.productnum}, \${ele.usernum}, \${ele.customernum})"
                        >
                            예약 취소
                        </button>
                        <button class="button-primary inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-white h-9 rounded-md px-3 mr-2 bg-black"
                            onClick="alertCompleteBtn(\${ele.productnum}, \${ele.usernum}, \${ele.customernum})"
                        >
                            거래 완료
                        </button>
                            `;
                        }
                        if (ele.productstatus === "거래 완료" && "${sessionScope.usernum}" == ele.usernum) {
                            s += `
                            <button class="button-primary inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-white h-9 rounded-md px-3 mr-2 bg-black"
                            onClick="location.href='/product/review?productnum=\${ele.productnum}'">
                            리뷰작성
                        </button>
                            `;
                        }

                        s += `

                                </div>
                            </div>
                        </div>
                        `

                    });
                }
                $("#page1").html(s);
            }
        });
    }

    function getBuy() {
        $.ajax({
            type: "get",
            url: "${root}/getbuy?customernum=${usernum}",
            dataType: "json",
            success: function (data) {
                let s = "";
                if (data.length === 0) {
                    s = `<div class="w-full text-base text-gray-500">아직 구매한 이력이 없어요.</div>`;
                } else {
                    $.each(data, function (idx, ele) {
                        s += `
                        <div class="relative rounded-lg border bg-card text-card-foreground shadow-sm">
                            <div class="relative w-full h-48">
                            <img src="https://kr.object.ncloudstorage.com/semi/panda/\${ele.imagefilename}" width="300" height="200" alt="Product" class="rounded-t-lg object-cover w-full h-48 \${ele.productstatus === '거래 완료' ? 'grayscale' : ''}" style="aspect-ratio:300/200;object-fit:cover"/>
                            \${ele.productstatus === '거래 완료' ? '<div class="overlay">SOLD</div>' : ''}
                            </div>
                            <div class="p-4">
                                <h3 class="text-lg font-medium mb-2">\${ele.producttitle}</h3>
                                <div class="mb-2">
                                    <span class="text-gray-500 mr-1">\${ele.productprice}원</span>
                                    <span class="text-gray-500">\${ele.productstatus}</span>
                                </div>
                                <div class="flex">
                                    <button class="inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-black h-9 rounded-md px-3 border-1 border-black mr-2 hover:bg-gray-200">
                                        예약 취소
                                    </button>
                                    <button class="button-primary inline-flex items-center justify-center whitespace-nowrap text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 text-white h-9 rounded-md px-3 mr-2 bg-black">
                                        거래 완료
                                    </button>
                                </div>
                            </div>
                        </div>
                    `;
                    });
                }
                $("#page1").html(s);
            }
        });
    }

    function getWish() {
        $.ajax({
            type: "get",
            url: "${root}/getwish?usernum=${usernum}",
            dataType: "json",
            success: function (data) {
                let s = "";
                if (data.length === 0) {
                    s = `<div class="w-full text-base text-gray-500">아직 찜한 이력이 없어요.</div>`;
                } else {
                    $.each(data, function (idx, ele) {
                        s += `
                            <div class="relative rounded-lg border bg-card text-card-foreground shadow-sm">
                                <div class="relative w-full h-48">
                                <img src="https://kr.object.ncloudstorage.com/semi/panda/\${ele.imagefilename}" width="300" height="200" alt="Product" class="rounded-t-lg object-cover w-full h-48 \${ele.productstatus === '거래 완료' ? 'grayscale' : ''}" style="aspect-ratio:300/200;object-fit:cover"/>
                                \${ele.productstatus === '거래 완료' ? '<div class="overlay">SOLD</div>' : ''}
                                </div>
                                <div class="p-4">
                                    <h3 class="text-lg font-medium mb-2">\${ele.producttitle}</h3>
                                    <div class="mb-2">
                                        <span class="text-gray-500 mr-1">\${ele.productprice}원</span>
                                        <span class="text-gray-500">\${ele.productstatus}</span>
                                    </div>
                                </div>
                            </div>
                    `;
                    });
                }
                $("#page1").html(s);
            }
        });
    }
</script>
</body>
</html>