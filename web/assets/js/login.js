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
                Swal.fire({title:"�α��� ����", text: "���� ������ �ٽ� Ȯ�����ּ���."});
            }
        }
    });
}