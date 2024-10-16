<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
 <style>
     /* search input https://codepen.io/sdaitzman/pen/bGbgPm */
     .search-box {
         transition: width 0.6s, border-radius 0.6s, background 0.6s, box-shadow 0.6s;
         width: 40px;
         height: 40px;
         border-radius: 20px;
         border: none;
         cursor: pointer;
         background: black;
     }
     .search-box + label .search-icon {
         color: black;
     }
     .search-box:hover {
         color: white;
         background: #c8c8c8;
         box-shadow: 0 0 0 5px #3d4752;
     }
     .search-box:hover + label .search-icon {
         color: white;
     }
     .search-box:focus {
         transition: width 0.6s, border-radius 0.6s, background 0.6s;
         border: none;
         outline: none;
         box-shadow: none;
         padding-left: 15px;
         cursor: text;
         width: 300px;
         border-radius: auto;
         background: #ebebeb;
         color: black;
     }
     .search-box:focus + label .search-icon {
         color: black !important;
     }
     .search-box:not(:focus) {
         text-indent: -5000px;
     }

     #search-submit {
         position: relative;
         left: -5000px;
     }

     .search-icon {
         position: relative;
         left: -34px;
         top: 1px;
         color: white;
         cursor: pointer;
     }
     .search-container {
         margin-right: -64px;
     }
 </style>
<html>
<body>
<!--
// v0 by Vercel.
// https://v0.dev/t/dlq5R4mPoUj
-->
</body>
<div class="flex flex-col">
    <header class="bg-black text-white py-1 px-6 md:px-8 flex items-center justify-between">
        <%-- logo  --%>
        <a class="flex items-center gap-2" href="${root}/">
            <img src="${root}/image/logo.png" alt="PANDA">
        </a>
        <nav class="hidden md:flex items-center gap-6">
            <%-- search input --%>
            <form class="search-container" action="${root}/search">
                <input id="search-box" type="text" class="search-box" name="keyword" />
                <label for="search-box">
                    <span class="glyphicon glyphicon-search search-icon text-white">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                          <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                        </svg>
                    </span>
                </label>
                <input type="submit" id="search-submit" />
            </form>


<c:if test="${sessionScope.loginok==null}">
                <%-- login 버튼 - 로그인 안하면 보임 --%>
                <button
                        class="inline-flex items-center gap-2 justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 bg-[#4CAF50] hover:bg-[#43a047] text-white"
                        type="submit" onclick="location.href='${root}/login'">
                    <i class="bi bi-box-arrow-left inline-flex items-center justify-center"></i>
                    <span>Login</span>
                </button>
                <%-- login 버튼 - 로그인 안하면 보임 --%>
                <button
                        class="inline-flex items-center gap-2 justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 h-10 px-4 py-2 bg-[#4CAF50] hover:bg-[#43a047] text-white"
                        type="submit" onclick="location.href='${root}/signup'">
                    <i class="bi bi-person-plus-fill inline-flex items-center justify-center"></i>
                    <span>Signup</span>
                </button>
</c:if>
<c:if test="${sessionScope.loginok!=null}">
            <%-- sell 버튼 - 로그인시 보임 --%>
            <a class="cursor-pointer flex items-center gap-2 hover:text-gray-200" href="${root}/product/write">
                <svg
                        xmlns="http://www.w3.org/2000/svg"
                        width="24"
                        height="24"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        class="w-5 h-5"
                >
                    <path d="M5 12h14"></path>
                    <path d="M12 5v14"></path>
                </svg>
                <span>Sell</span>
            </a>
            <%-- logout 버튼 - 로그인시 보임 --%>
            <a class="cursor-pointer flex items-center gap-2 hover:text-gray-200" id="btnlogout">
                <i class="bi bi-box-arrow-right"></i>
                <span>Logout</span>
            </a>
            <%-- profile - 로그인시 보임--%>
            <a class="flex items-center gap-2 hover:text-gray-200" href="${root}/mypage?usernum=${sessionScope.usernum}">
                <img
                        src="https://minio.minseok.site/semi-panda/panda/${sessionScope.userprofileimage}"
                        width="32"
                        height="32"
                        class="rounded-full"
                        alt="Profile"
                        style="aspect-ratio: 32 / 32; object-fit: cover;"
                />
                <span>${sessionScope.usernickname}</span>
            </a>
</c:if>
        </nav>
    </header>
</div>
<script>
    $(function () {
        $("#btnlogout").click(function () {
            $.ajax({
                type: "get",
                dataType: "text",
                url: '/member/logout',
                success: function () {
                    //새로고침
                    location.reload();
                }
            })
        })
    })
</script>
</html>
