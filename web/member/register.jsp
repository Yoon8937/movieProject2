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
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
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


    <script>
        let result = false;

        function validateUsername(username) {
            var data = {
                "username": username
            };
            console.log(username);
            console.log(data);
            if (username.length >= 3) {
                return true;
            }
            $.ajax({
                url: "/user/validate",
                type: "get",
                data: data,
                success: function(message) {
                    let jsonResult = JSON.parse(message);
``

                    if (!jsonResult.result) {
                        Swal.fire({title: '실패', text: jsonResult.message});
                    }
                },
                fail: function() {
                    console.log("error");
                }
            });

            return false;
        }

        function validatePassword(password) {
            // if (password.includes('@')) {
            //     return true;
            // }
            // return false;
            return true;
        }

        function validateInput() {
            let username = document.getElementById('username');
            let password = document.getElementById('password');
            result = validateUsername(username.value) && validatePassword(password.value);

            if (result) {
                document.forms[0].submit();
            } else {
                Swal.fire({title: '!!! 오류 !!!', text: '잘못 입력하셨습니다.', icon: 'error'});
            }
        }

    </script>
</head>

<body>


<form action="/member/register_logic.jsp" method="post" name="regForm">
<%--<form action="/member/register_logic.jsp" method="post" name="regForm">--%>
    <div class="title">회원등록</div>

    <label for="username">아이디</label>
    <input class="input-field" type="text" id="username" name="username" placeholder="아이디(username)">
    <label for="password">비밀번호</label>
    <input class="input-field" type="password" id="password" name="password" placeholder="비밀번호">
    <label for="nickname">닉네임</label>
    <input class="input-field" type="text" id="nickname" name="nickname" placeholder="닉네임">
    <div class="btn btn-outline-primary" onclick="validateInput()">회원 가입</div>
</form>

</body>
</html>
