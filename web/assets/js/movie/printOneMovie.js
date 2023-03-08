// window.onload = function printOneMethod() {
let printOneMethod = () => {
    // url 에서 쿼리 파라미터를 가져오거나 수정할떄 사용됨
    let movieId = new URLSearchParams(window.location.search).get("movieId");
    review_method(movieId);

    let data;
    data = {"movieId": movieId};
     $.ajax({
         url: "/movie/printOne",
         method: "GET",
         data: data,
         success: (message) => {
             let result = JSON.parse(message);
             console.log(result);

             if(result.status == 'success') {
                 let data = JSON.parse(result.data);
                 printData(data);
             } else {
                 Swal.fire({
                     title : "!!!ERROR!!!",
                     text: result.message,
                     icon: "error"
                 }).then(() =>{
                     location.href = result.nextPath;
                 })
             }
         }
     });
}

function printData(data){
    $('#input-id').val(data.movieId);
    $('#input-title').val(data.title);
    $('#input-rank').val(data.rank);
    $('#editor').val(data.story);

    ClassicEditor.create(document.querySelector('#editor')).catch(error => {
       console.log(error);
    });
}


let updateMovie = () => {
    let movieId = $('#input-id').val().replace("번","");
    let formData = {
        movieId: movieId,
        title: $('#input-title').val(),
        rank: $('#input-rank').val(),
        story: $('.ck-editor__editable').html()
    };

    $.ajax({
        url: "/movie/update",
        method: "post",
        data: formData,
        success: (response) => {
            let result = JSON.parse(response);
            Swal.fire({
                icon: result.status,
                text: result.message
            }).then(() => {
                location.reload();
            });
        }
    })
}



function review_method(movieId){
    let data;
    data = {"movieId": movieId};

    $.ajax({
        url: "/movie/review",
        method: "GET",
        data: data,
        success: (message) => {
            let result = JSON.parse(message);
            let array = JSON.parse(result.data);
            console.log("arrrrr : "+array);

            array.forEach(r => {
                printReviewRow(r);
            })

        }
    });
}

function printReviewRow(r){
    let tmp = $('#review-table');

    let tbody = $('#test');
    let tr = document.createElement("tr");

    $(tr).append($(document.createElement("td")).text(r.id));
    $(tr).append($(document.createElement("td")).text(r.writeId));
    $(tr).append($(document.createElement("td")).text(r.score));
    $(tr).append($(document.createElement("td")).text(r.review));

    if(r.isOwned == true) {
        let btnDelete = $(document.createElement("div")).addClass("btn btn-danger").text("Delete").click(() => {
            let result = confirm("Are you sure to delete movie no."+ r.id);
            if(result){
                deleteReview(r.id);
            }

        });

        $(tr).append(btnDelete);
    }

    $(tbody).append(tr);


}

function deleteReview(id){
    let sendData = {
        "id": id
    };
    $.ajax({
        url:"/review/delete",
        method: "get",
        data: sendData,
        success: (message) => {
            let result = JSON.parse(message);
            console.log("resultttt ; "+result.status)
            if(result.status == 'fail'){
                Swal.fire({
                    "text": "There is an Error.", "title": "!!!ERROR!!!"
                })
            }
            location.reload();
        }
    });
}


let writeReview = () => {
    console.log("hello world");
    let formData = {
        "score": $('#score').val(),
        "review": $('#review').val(),
        "movieId": new URLSearchParams(window.location.search).get("movieId")
    };


    $.ajax({
        url: "/review/write",
        method: "post",
        data: formData,
        success: (message) =>{
            let result = JSON.parse(message);
            console.log(result + "fuckkkkkkkkkkkk");
            if(result.status == "fail") {
                Swal.fire({
                    title: "!!!ERROR!!!",
                    text: "there is en Error somewhere.",
                    icon: "error"
                })
            }
            location.reload();
        }
    })
}









