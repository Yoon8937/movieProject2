let initPage = () => {
    let tmp = new URLSearchParams(window.location.search).get("pageNo");
    let data;
    if (tmp == null) {
        data = {"pageNo": 1};
    } else {
        data = {"pageNo": tmp};
    }

    $.ajax({
        url: "/movie/movie_homeServlet",
        method: "GET",
        data: data,
        success: (message) => {
            let result = JSON.parse(message);
            let array = JSON.parse(result.data);

            let isAdmin = result.isAdmin;

            array.forEach(m => {
                insertRow(m, isAdmin);
            })
            let totalPage = (result.totalPage);
            insertPagination(totalPage, data.pageNo);

        }
    });

}

function insertRow(movie, isAdmin) {
    let tbody = $('tbody');
    let pagination = $(tbody).children().last();
    $(tbody).remove(pagination);
    let tr = document.createElement("tr");

    $(tr).append($(document.createElement("td")).text(movie.id));
    $(tr).append($(document.createElement("td")).text(movie.title));

    var tmp = document.createElement("td");
    // tmp.style.color = "blue";
    $(tr).append($(tmp).text(movie.story));
    $(tr).append($(document.createElement("td")).text(movie.rank));

    let btnSeeMore = $(document.createElement("div")).addClass("btn btn-outline-success").text("see more");
    btnSeeMore.click(() => {
        location.href = "/main/movie/printOneMovie.jsp?movieId=" + movie.id;
    });
    $(tr).append(btnSeeMore);

    if(isAdmin == true) {

            let btnDelete = $(document.createElement("div")).addClass("btn btn-outline-primary").text("Delete").click(() => {
                let result = confirm("Are you sure to delete movie no."+movie.id+"("+movie.title+")");
                if(result){
                    deleteMovie(movie.id);
                }

            });

        $(tr).append(btnDelete);
    }
    $(tbody).append(tr);
    $(tbody).append(pagination);
}

function deleteMovie(id){
    let sendData = {
        "id": id
    };
    $.ajax({
        url:"/movie/delete",
        method: "get",
        data: sendData,
        success: (message) => {
            let result = JSON.parse(message);
            if(result.status == 'fail'){
                Swal.fire({
                    "text": "There is an Error.", "title": "!!!ERROR!!!"
                })
            }
            location.reload();
        }
    });
}


function insertPagination(totalPage, pageNo) {
    var startNum, endNum;

    if(totalPage <= 5){
        startNum = 1;
        endNum = totalPage;
    } else if(pageNo < 3){
        startNum = 1;
        endNum = 5;
    } else if(pageNo < 3){
        startNum = 1;
        endNum = 5;
    } else if(parseInt(pageNo) > totalPage - 2){
        startNum = totalPage - 4;
        endNum = totalPage;
    } else {
        startNum = parseInt(pageNo) - 2;
        endNum = parseInt(pageNo) - 2;
    }
    console.log(startNum, endNum);

    let ul = $(document.createElement("ul"));
    let li = $(document.createElement("li"));
    let firstAnchor = $(document.createElement("a")).attr("href", "/main/movie/movie_home.jsp?pageNo=1");
    let firstButton = $(document.createElement("span")).text("<<");
    $(firstAnchor).append(firstButton);
    $(li).append(firstAnchor);
    $(ul).append(li);
    for (var i = startNum; i <= endNum; i++) {
        let page_li = $(document.createElement("li"));
        let anchor = $(document.createElement("a")).attr("href", "/main/movie/movie_home.jsp?pageNo=" + i);
        if (i == pageNo) {
            anchor.addClass("active");
        }
        let span = $(document.createElement("span")).text(i);
        $(anchor).append(span);
        $(page_li).append(anchor);
        $(ul).append(page_li);
    }
    let lastLi = $(document.createElement("li"));
    let lastAnchor = $(document.createElement("a")).addClass("page-link").attr("href", "/main/movie/movie_home.jsp?pageNo=" + totalPage);
    let lastButton = $(document.createElement("span")).text(">>");
    $(lastAnchor).append(lastButton);
    $(lastLi).append(lastAnchor);
    $(ul).append(lastLi);

    $('#td-pagination').append(ul);

}


