<%--
  Created by IntelliJ IDEA.
  User: minseok
  Date: 24. 6. 13.
  Time: 오전 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <title>Post Item</title>

    <style>
        #preview {
            width: 87%;
            display: flex;
            overflow-x: auto; /* 가로 스크롤 활성화 */
            white-space: nowrap; /* 요소들이 한 줄로 표시되도록 설정 */
            gap: 1rem; /* 이미지 간격 설정 */
            scrollbar-width: none;
        }
        #preview img {
            flex-shrink: 0; /* 이미지가 줄어들지 않도록 설정 */
        }
    </style>

</head>
<body>
<!-- 이미지 0장 경고모달 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="staticBackdropLabel" style="font-size: 20px; font-weight: bold;">내 상품에 대한 사진이 없어요.</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>내 상품을 보여줄 수 있는
                    한 장 이상의 사진을 올려주세요.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- 이미지 10장 초과 경고모달 -->
<div class="modal fade" id="toomanyimages" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="toomanyimagesLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="toomanyimagesLabel">사진이 너무 많습니다.</h2>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>사진은 최대 10장까지 업로드 가능합니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<div class="bg-white  text-gray-950  min-h-screen">
    <div class="container mx-auto px-4 md:px-6 py-8 md:py-12">

        <div class="bg-white  p-4 md:p-6 grid gap-6">

            <!-- Post Your Item -->
            <div class="grid gap-2">
                <h1 class="text-2xl font-bold">내 중고상품 등록하기</h1>
                <p class="text-gray-500 ">판다에서 나에게 필요 없는 중고상품을 팔아보세요!</p>
            </div>

            <!-- 폼태그 시작 -->
            <form class="grid gap-6" method="post" action="../../product/write" enctype="multipart/form-data" id="productForm">

                <!-- 게시글 제목 입력란 -->
                <div class="grid gap-2">
                    <label
                            class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                            for="title">
                        Title
                    </label>
                    <input
                            class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                            id="title"
                            name="producttitle"
                            required="required"
                            placeholder="제목을 입력하세요."/>
                </div>

                <!-- 사진 여러장 업로드 + 미리보기 -->
                <div>
                    <label class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
                        Photos
                    </label>
                    <!-- 사진 업로드와 미리보기 -->
                    <div class="mt-0 flex items-start gap-2">
                        <!-- 업로드 버튼 -->
                        <button type="button"
                                id="upload-button"
                                class="w-48 h-48 bg-[#e8e8e8] rounded flex items-center justify-center">
                            <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    width="24"
                                    height="24"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="#585858"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    class="h-6 w-6">
                                <line x1="12" y1="5" x2="12" y2="19"></line>
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                            </svg>
                        </button>

                        <!-- 사진 업로드 전달 -->
                        <input type="file" id="file-input" name="productImages" accept="image/*" multiple required class="hidden">

                        <!-- 사진 미리보기 -->
                        <div id="preview" class="mt-0 flex items-start gap-2">
                            <!-- 여기에 사진 미리보기 출력 -->
                        </div>
                    </div>
                </div>

                <!-- 중고제품 설명 입력 -->
                <div class="grid gap-2">
                    <label
                            class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                            for="description">
                        Description
                    </label>
                    <textarea
                            class="flex min-h-[80px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                            id="description"
                            name="productcontent"
                            required="required"
                            placeholder="판매할 중고물품의 설명을 적어주세요."
                            rows="4"></textarea>
                </div>

                <!-- 가격, 거래희망지역 -->
                <div class="grid md:grid-cols-2 gap-6">
                    <!-- 가격 입력 --><!-- 가격제한 1억까지 제한 -->
                    <div class="grid gap-2">
                        <label
                                class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                                for="price">
                            Price
                        </label>
                        <div class="flex items-center gap-2">
                            <input
                                    class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                                    type="number"
                                    id="price"
                                    name="productprice"
                                    required="required"
                                    max="100000000"
                                    placeholder="가격을 입력해주세요."/>
                        </div>
                    </div>

                    <!-- 거래 희망 지역 입력 -->
                    <div class="grid gap-2">
                        <label
                                class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                                for="location">
                            Location
                        </label>
                        <!-- 클릭하면 도로명 주소 입력 API 팝업 출력 -->
                        <input
                                class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                                id="location"
                                name="productaddress"
                                required="required"
                                placeholder="판매장소를 등록해주세요."
                                onfocus="openDaumPostcode()"
                               <%-- onclick="openDaumPostcode()"--%>/>
                    </div>
                    <input type="hidden" id="latitude" name="productlocationx"/>
                    <input type="hidden" id="longitude" name="productlocationy"/>
                </div>

                <!-- 카테고리 입력 -->
                <div class="grid gap-2">
                    <label class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70" for="category">
                        Category
                    </label>
                    <div class="flex items-center gap-2">
                        <select class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50"
                                id="category"
                                name="categorynum"
                                required>
                            <option value="" selected disabled hidden>Select category</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categorynum}">${category.categoryname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- 오픈채팅 빈값 전달 -->
                <input type="hidden" name="productopenchat" value=""/>

                <!-- 해시태그 입력 -->
                <div class="grid gap-2">
                    <label class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
                        Hashtags
                        <span style="font-size: x-small"> 최대 5개, 19자까지 입력 가능합니다.</span>
                    </label>

                    <!-- 입력받은 해시태그들 나열 -->
                    <div class="flex flex-wrap gap-2" id="hashtag-container">
                        <!-- 해시태그가 여기에 나열됩니다 -->
                    </div>

                    <!-- 해시태그 입력란 -->
                    <div>
                        <input
                                id="hashtag-input"
                                class="flex h-10 w-full border border-input text-sm ring-offset-background
        file:border-0 file:bg-transparent file:text-sm file:font-medium
        placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2
        focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed
        disabled:opacity-50 bg-green-50 text-green-500
        px-3 py-1 rounded-full"
                                name="hashtags"
                                placeholder="#해시태그"
                                onkeydown="handleHashtagInput(event)"
                        />
                    </div>

                    <!-- 입력된 해시태그들 전달 -->
                    <input type="hidden" id="hashtaglist" name="hashtaglist"/>

                </div>

                <!-- 게시글 등록 버튼 -->
                <!-- 클릭시 디테일페이지로 이동 -->
                <div class="flex justify-end">
                    <button type="submit" id="post-item-button" class="inline-flex items-center justify-center whitespace-nowrap
                   text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none
                   focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2
                   disabled:pointer-events-none disabled:opacity-50 bg-black text-white
                   hover:bg-primary/90 h-11 rounded-md px-8">
                        Post Item
                    </button>
                </div>
            </form><!-- 폼태그 끝 -->
        </div>
    </div>
</div>

<!-- 이미지 업로드 이벤트 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const fileInput = document.getElementById('file-input');
        const uploadButton = document.getElementById('upload-button');
        const postItemButton = document.getElementById('post-item-button');
        const preview = document.getElementById('preview');
        const modal = new bootstrap.Modal(document.getElementById('staticBackdrop'));
        const modalTooManyImages = new bootstrap.Modal(document.getElementById('toomanyimages'));
        //const productForm = document.getElementById('productForm');
        let uploadedFiles = [];

        // 이미지 업로드 버튼 클릭
        uploadButton.addEventListener('click', function() {
            fileInput.click();
        });

        // 파일 선택 시 미리보기 표시 및 클릭 시 제거
        fileInput.addEventListener('change', function(event) {
            const files = Array.from(event.target.files);
            //preview.innerHTML = ''; // 이전 미리보기 내용 지우기

            // 이미지가 10장을 초과하는지 확인
            if (uploadedFiles.length + files.length > 10) {
                modalTooManyImages.show(); // 모달 표시
                return;
            }

            files.forEach(file => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.classList.add('w-48', 'h-48', 'object-cover', 'rounded', 'border', 'cursor-pointer'); // TailwindCSS 클래스 사용
                    img.dataset.filename = file.name; // 파일 이름을 데이터 속성으로 저장

                    // 클릭 시 미리보기에서 이미지 제거
                    img.addEventListener('click', function() {
                        preview.removeChild(img);

                        // 업로드된 파일 목록에서 해당 파일 제거
                        uploadedFiles = uploadedFiles.filter(uploadedFile => uploadedFile.name !== file.name);

                        // 파일 입력 요소 값 재설정
                        const dataTransfer = new DataTransfer();
                        uploadedFiles.forEach(file => dataTransfer.items.add(file));
                        fileInput.files = dataTransfer.files;
                    });

                    preview.appendChild(img);
                };
                reader.readAsDataURL(file);

                // 업로드된 파일 목록에 추가
                uploadedFiles.push(file);
            });

            // 파일 입력 요소 값 재설정
            const dataTransfer = new DataTransfer();
            uploadedFiles.forEach(file => dataTransfer.items.add(file));
            fileInput.files = dataTransfer.files;

            //fileInput.removeAttribute('required'); // 파일이 선택되면 required 속성 제거
            //required 지워?
        });

        // 폼 제출 시 이미지 개수 확인
        postItemButton.addEventListener('click', function(event) {
            if (fileInput.files.length === 0) {
                event.preventDefault(); // 폼 제출 방지
                modal.show(); // 모달 표시
                //fileInput.setAttribute('required', 'required'); // required 속성 추가
                //required 지워?
            }
        });

        // 미리보기 이미지 가로 스크롤링
        preview.addEventListener('wheel', function(event) {
            if (event.deltaY !== 0) {
                event.preventDefault();
                this.scrollLeft += event.deltaY;
            }
        });
    });
</script>

<!-- 해시태그 이벤트 -->
<script>
    const maxHashtags = 5;
    const maxHashtagLength = 19;
    const hashtagContainer = document.getElementById('hashtag-container');
    const hashtagInput = document.getElementById('hashtag-input');
    const hashtagListInput = document.getElementById('hashtaglist');
    let hashtags = [];

    //해시태그 입력중 enter가 입력되면 내용 잘라서 addHashtag함수 수행
    function handleHashtagInput(event) {
        if (event.key === 'Enter') {
            event.preventDefault(); // 기본 동작 중지
            const inputValue = event.target.value.trim();
            if (inputValue && hashtags.length < maxHashtags) {
                addHashtag(inputValue);
                event.target.value = '';
            }
        }
    }

    //전달 받는 내용 추가
    function addHashtag(tag) {
        // # 안붙어 있으면 추가
        if (!tag.startsWith('#')) {
            tag = '#' + tag;
        }

        // 해시태그 길이 확인
        if (tag.length > maxHashtagLength) {
            //alert('해시태그는 최대 19자까지 가능합니다.');
            return;
        }

        // hashtags 리스트에 중복되는 내용이 없을 경우만 renderHashtags()함수로 전달
        if (!hashtags.includes(tag)) {
            hashtags.push(tag);
            renderHashtags();
            updateHiddenInput();
        }
    }

    // 해시태그 삭제 함수
    function removeHashtag(tag) {
        hashtags = hashtags.filter(item => item !== tag); // 선택된 해시태그 제외하고 필터링
        renderHashtags(); // 해시태그 UI 업데이트
        updateHiddenInput(); // 숨겨진 input 업데이트
    }

    // 해시태그 UI 업데이트 함수
    function renderHashtags() {
        hashtagContainer.innerHTML = '';
        hashtags.forEach(tag => {
            const tagElement = document.createElement('div');
            tagElement.className = 'bg-green-50 text-green-500 px-3 py-1 rounded-full flex items-center gap-1';

            // 해시태그 텍스트
            const tagText = document.createElement('span');
            tagText.textContent = tag;

            // 삭제 버튼
            const deleteButton = document.createElement('button');
            deleteButton.type = 'button';
            deleteButton.innerHTML = '&times;'; // X 표시
            deleteButton.className = 'text-green-500';
            deleteButton.addEventListener('click', () => removeHashtag(tag)); // 삭제 버튼 클릭 시 해당 해시태그 삭제

            tagElement.appendChild(tagText);
            tagElement.appendChild(deleteButton);

            hashtagContainer.appendChild(tagElement);
        });
    }

    function updateHiddenInput() {
        hashtagListInput.value = hashtags.join(',');
    }
</script>

<!-- 주소입력 팝업 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- kakao 주소찾기 -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0988ea389a80dcfa4f93816fc3b6129&libraries=services"></script><!-- kakao JS appkey 콩비꺼 넣음 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        function openDaumPostcode() {
            document.getElementById('location').blur();  // input의 포커스 잠시 제거

            new daum.Postcode({
                oncomplete: function (data) {
                    var geocoder = new kakao.maps.services.Geocoder();
                    var roadAddr = data.roadAddress;
                    var callback = function(result, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            console.log(result);
                            var lat = result[0].y;
                            var lng = result[0].x;
                            document.getElementById('latitude').value = lat;
                            document.getElementById('longitude').value = lng;
                            console.log('위도:', lat, '경도:', lng);
                        }
                    };
                    document.getElementById('location').value = roadAddr;
                    console.log(roadAddr);
                    geocoder.addressSearch(roadAddr, callback);
                }
            }).open();
        }
        window.openDaumPostcode = openDaumPostcode;
    });
</script>

</body>
</html>