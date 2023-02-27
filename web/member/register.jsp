<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <title>회원등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
<style>
    * { box-sizing:border-box; }

    form {
        width:400px;
        height:600px;
        display : flex;
        flex-direction: column;
        align-items:center;
        position : absolute;
        top:50%;
        left:50%;
        transform: translate(-50%, -50%) ;
        border: 1px solid rgb(89,117,196);
        border-radius: 10px;
    }

    .input-field {
        width: 300px;
        height: 40px;
        border : 1px solid rgb(89,117,196);
        border-radius:5px;
        padding: 0 10px;
        margin-bottom: 10px;
    }
    label {
        width:300px;
        height:30px;
        margin-top :4px;
    }
    button {
        background-color: rgb(89,117,196);
        color : white;
        width:300px;
        height:50px;
        font-size: 17px;
        border : none;
        border-radius: 5px;
        margin : 40px 0 30px 0;
    }
    .title {
        font-size : 50px;
        margin: 40px 0 30px 0;
    }
    .msg {
        height: 30px;
        text-align:center;
        font-size:16px;
        color:red;
        margin-bottom: 20px;
    }
</style>



</head>

<body>


<form action="/member/register_logic.jsp" method="post" name="regForm" onsubmit="return formCheck(this)">
<%--<form action="/member/register_logic.jsp" method="post" name="regForm">--%>
    <div class="title">회원등록</div>

    <div id="msg" class="msg">
        <c:if test="${not empty param.msg}">
            <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
        </c:if>
    </div>

    <label for="">아이디</label>
    <input class="input-field" type="text" id="username" name="username" placeholder="아이디(username)">
    <label for="">비밀번호</label>
    <input class="input-field" type="text" id="password" name="password" placeholder="비밀번호">
    <label for="">닉네임</label>
    <input class="input-field" type="text" id="nickname" name="nickname" placeholder="닉네임">
    <button>회원 가입</button>
</form>


<script>
    function formCheck(frm){
        let msg = '';

        // if(frm.password.value === "" ){
        if(frm.password.value.length < 1 ){
            setMessage("비밀번호를 입력해야 됩니다.",frm.password);
            return false;
        }

        if(frm.nickname.value.length < 1 ){
            setMessage("닉네임을 입력해야 됩니다.",frm.nickname);
            return false;
        }

        return true;
    }

    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;

        if(element){
            element.select();
        }
    }
</script>

</body>
</html>
