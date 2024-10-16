<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
   <script src="https://cdn.tailwindcss.com"></script>
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
   <!-- Link Swiper's CSS -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
   <style>
      /* 카테고리 스크롤 */
      #scroll {
         display: flex;
         overflow-x: auto;
         -webkit-overflow-scrolling: touch;
         scrollbar-width: none; /* Firefox */
         scroll-behavior: smooth;
      }
      #scroll::-webkit-scrollbar {
         display: none;
      }
      #scroll > a {
         flex: 0 0 auto;
         width: 100px;
         margin-right: 70px;
         text-align: center;
      }

      .slider-button {
         position: absolute;
         top: 50%;
         margin-left: -30px;
         margin-right: -30px;
         transform: translateY(-50%);
         background-color: #45a049;
         color: white;
         border: none;
         border-radius: 50%;
         width: 40px;
         height: 40px;
         cursor: pointer;
         z-index: 1;
      }

      .slider-button:hover {
         color: #45a049;
         background-color: white;
      }

      .prev {
         left: 5px;
      }

      .next {
         right: 5px;
      }

      div.sel{
         margin-left: 88%;
      }

      html,
      body {
         position: relative;
         height: 100%;
      }

      body {
         background: #eee;
         font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
         font-size: 14px;
         color: #000;
         margin: 0;
         padding: 0;
      }

      .swiper {
         width: 100%;
         height: 100%;
      }

      .swiper-slide {
         text-align: center;
         font-size: 18px;
         background: #fff;
         display: flex;
         justify-content: center;
         align-items: center;
      }

      .swiper-slide img {
         display: block;
         width: 100%;
         height: 100%;
         object-fit: cover;
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

<!-- Swiper -->
<c:if test="${sessionScope.loginok==null}">
<div class="swiper mySwiper">
   <div class="swiper-wrapper">

      <div class="swiper-slide">
         <a href="${root}/login">
            <img src="${root}/image/banner1.png"/>
         </a>
      </div>
      <div class="swiper-slide">
         <a href="${root}/login">
            <img src="${root}/image/banner2.png"/>
         </a>
      </div>
      <div class="swiper-slide">
         <a href="${root}/login">
            <img src="${root}/image/banner3.png"/>
         </a>
      </div>
   </div>
   <div class="swiper-button-next"></div>
   <div class="swiper-button-prev"></div>
</div>
</c:if>
<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->
<script>
   var swiper = new Swiper(".mySwiper", {
      navigation: {
         nextEl: ".swiper-button-next",
         prevEl: ".swiper-button-prev",
      },
   });
</script>

<div class="bg-white  text-gray-900  min-h-screen">
   <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-8 sm:py-12 lg:py-16">
<div class="flex flex-col min-h-screen relative">

   <section class="py-8 px-6 md:px-8 bg-gray-100 relative">
      <button class="slider-button prev" onclick="slide(-1)">&#10094;</button>
      <button class="slider-button next" onclick="slide(1)">&#10095;</button>
      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-6" id="scroll">
         <a class="flex flex-col items-center gap-2 hover:text-[#4CAF50] whitespace-nowrap"
            onclick="changeCategory(0);">
            <i class="bi bi-justify" style="font-size: 2em;"></i>
            <span>ALL</span>
         </a>
         <c:forEach var="ele" items="${categories}">
            <a class="flex flex-col items-center gap-2 hover:text-[#4CAF50] whitespace-nowrap"
               onclick="changeCategory(${ele.categorynum});">
               <i class="${ele.categoryicon}" style="font-size: 2em;"></i>
               <span>${ele.categoryname}</span>
            </a>
         </c:forEach>
      </div>
   </section>
   <br>
   <section class="py-8 px-6 md:px-8">
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6" id="item-seciton">
<%--         <c:forEach var="ele" items="${products}">--%>
<%--            <div class="rounded-lg border bg-card text-card-foreground shadow-sm">--%>
<%--               <div class="relative w-full h-48">--%>
<%--               <img src="${MINIO_ENDPOINT}/semi-panda/panda/${ele.imagefilename}"--%>
<%--                    width="300" height="200" alt="Product" class="cursor-pointer rounded-t-lg object-cover w-full h-48--%>
<%--                    ${ele.productstatus == '거래 완료' ? 'grayscale' : ''}" style="aspect-ratio:300/200;object-fit:cover"--%>
<%--                    onclick="location.href='${root}/product/detail?productnum=${ele.productnum}'"/>--%>
<%--                     ${ele.productstatus == '거래 완료' ? '<div class="overlay">SOLD</div>' : ''}--%>
<%--               </div>--%>
<%--               <div class="p-4">--%>

<%--                  <h3 class="cursor-pointer text-lg font-medium mb-2"--%>
<%--                      onclick="location.href='${root}/product/detail?productnum=${ele.productnum}'">--%>
<%--                        ${ele.producttitle}</h3>--%>
<%--                  <div class="mb-2">--%>
<%--                     <span class="text-gray-500 mr-1">${ele.productprice}원</span>--%>
<%--                     <span class="text-gray-500">${ele.productstatus}</span>--%>
<%--                  </div>--%>
<%--               </div>--%>
<%--            </div>--%>
<%--         </c:forEach>--%>
      </div>
   </section>
</div>


   </div>
</div>
<script>
   let currentPage = 1;
   let loading = false;
   let currentCategory = 0;
   // 슬라이드 버튼 기능
   function slide(direction) {
      const scrollContainer = document.getElementById('scroll');
      const scrollAmount = 300; // 원하는 스크롤 양 설정
      scrollContainer.scrollBy({
         top: 0,
         left: direction * scrollAmount,
         behavior: 'smooth'
      });
   }

   function getList(categorynum, page){
      if (loading) return;
      loading = true;

      $.ajax({
         type: "get",
         url: `${root}/scroll`,
         data: { categorynum: categorynum, page: page },
         dataType: "json",
         success: function(data){
            let s = "";
            if(data.length === 0){
               if(page === 1) {
                  s = `<div class="w-full text-base text-gray-500">해당 카테고리에 아직 상품이 없어요.</div>`;
                  $("#item-seciton").html(s);
               }
            } else {
               $.each(data, function(idx, ele) {
                  let a = '';
                  let b = '';
                  if (ele.productstatus == '거래 완료' || ele.productstatus == '리뷰 완료'
                          || ele.productstatus == '구매자 리뷰 완료' || ele.productstatus == '판매자 리뷰 완료'){
                     a = 'grayscale';
                     b = '<div class="overlay">SOLD</div>';
                  }

                  s += `
                  <div class="rounded-lg border bg-card text-card-foreground shadow-sm">
                     <div class="relative w-full h-48">
                     <img src="${MINIO_ENDPOINT}/semi-panda/panda/\${ele.imagefilename}"
                          width="300" height="200" alt="Product" class="cursor-pointer rounded-t-lg object-cover w-full h-48
                          \${a}" style="aspect-ratio:300/200;object-fit:cover"
                          onclick="location.href='${root}/product/detail?productnum=\${ele.productnum}'"/>
                           \${b}
                     </div>
                     <div class="p-4">
                        <h3 class="cursor-pointer text-lg font-medium mb-2"
                            onclick="location.href='${root}/product/detail?productnum=\${ele.productnum}'">
                              \${ele.producttitle}</h3>
                        <div class="mb-2">
                           <span class="text-gray-500 mr-1">\${ele.productprice}원</span>
                           <span class="text-gray-500">\${ele.productstatus}</span>
                        </div>
                     </div>
                  </div>
                    `;
               });
               if(page === 1) {

                  // console.log(s)
                  $("#item-seciton").html(s);
               } else {
                  $("#item-seciton").append(s);
               }
            }
            loading = false;
         },
         error: function() {
            loading = false;
         }
      });
   }

   $(window).scroll(function() {
      if($(window).scrollTop() + $(window).height() >= $(document).height() - 200) {
         currentPage++;
         getList(currentCategory, currentPage);
      }
   });

   function changeCategory(categorynum) {
      currentCategory = categorynum;
      currentPage = 1;
      getList(categorynum, currentPage);
   }

   getList(0,1);


</script>

</body>
</html>

