<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Dancing+Script:wght@400..700&family=East+Sea+Dokdo&family=Jua&family=Gaegu&family=Gamja+Flower&family=Pacifico&family=Single+Day&display=swap"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <style>
        body * {
            font-family: 'Jua';
        }
    </style>

</head>
<body>
<form id="frm1">
    <div class="g-recaptcha" data-sitekey="6LcyDmMqAAAAAC5mZrgIBhfmWqfKQ7s6QgMfpYTI"></div>
    <button type="button" id="qnaRegBtn">등록</button>
</form>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 구글 리캡차 -->
<script src='https://www.google.com/recaptcha/api.js'></script>
<script type="text/javascript">

    $(function() {
        $('#qnaRegBtn').click(function() {


            $.ajax({
                url: '/VerifyRecaptcha',
                type: 'post',
                data: {recaptcha: $("#g-recaptcha-response").val()},
                success: function(res) {
                    const data=JSON.parse(res);
                    if(data.success){
                        //alert("자동 가입 방지 봇 통과");
                        $("#frm1").submit();
                    }else{
                        alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
                    }
                }
            });
        });
    });
</script>
</body>
</html>
