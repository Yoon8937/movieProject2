let auth = () => {
    let username = $('#username').val();
    let password = $('#password').val();
    let data = {
        "username": username,
        "password": password
    };
    $.ajax({
        url: "/user/auth",
        method: "post",
        data: data,
        success: function (message) {
            let result = JSON.parse(message);
            console.log(result.result);

            if(result.result == 'success') {
                location.href = "/main/home.jsp";
            } else {
                Swal.fire({title:"로그인 실패", text: "계정 정보를 다시 확인해주세용."});
            }
        }
    });
}