var isLogin=false;

$(function () {
    var v_navHtml = "<nav class=\"navbar navbar-inverse\">\n" +
        "    <div class=\"container-fluid\">\n" +
        "        <!-- Brand and toggle get grouped for better mobile display -->\n" +
        "        <div class=\"navbar-header\">\n" +
        "           <ul> <li><a class=\"navbar-brand\" href='/'>飞狐电商前台666</a></li></ul>\n" +
        "        </div>\n" +
        "\n" +
        "        <!-- Collect the nav links, forms, and other content for toggling -->\n" +
        "        <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">" +
        "            <ul class=\"nav navbar-nav navbar-right\" id='nav_ul'>" +
        "                <li id=\"loginInfo\"><a href=\"/login.html\">登录</a></li>" +
        "                <li><a href=\"/zhuce.html\">注册</a></li>" +
        "                <li><a href=\"/cart-student.html\">购物车</a></li>" +
        "                <li><a href=\"/index-student.html\">首页</a></li>" +
        "                <li><a href=\"/getOrderInfo-student.html\">结算页面</a></li>" +
        "            </ul>\n" +
        "        </div><!-- /.navbar-collapse -->\n" +
        "    </div><!-- /.container-fluid -->\n" +
        "</nav>";

    $("#navDiv").html(v_navHtml);

    $.ajaxSetup({
        beforeSend: function(xhr) {
            var token = window.localStorage.getItem("token");
            console.log("token:"+token);
            xhr.setRequestHeader("x-auth", token);
        }
    })

    //查看用户是否一登录
    $.ajax({
        url:"http://localhost:8081/mem/addMember.do",
        type:"post",
        dataType:"json",
        async:false,
        success:function (data){
            if(data.status==200){
                var memName =data.data;
                isLogin=true;
                $("#loginInfo").html('<a>欢迎'+memName+'大佬登录!!</a>');
                $("#nav_ul").append("<li><a href='#' onclick='outLogin()'>退出</a></li>");
            }
        }
    })
    /*$.post(
        "http://localhost:8081/mem/addMenber.do",
        function(data){
            if(data.status==200){
                alert(data.data);
                isLogin=true;
                $("#loginInfo").html('<a>欢迎'+data.data+'大佬登录!!</a>');
                $("#nav_ul").append('<a>退出</a>');
            }
        }
    )*/


    })
function outLogin(){
    $.post(
        "http://localhost:8081/mem/outLogin.do",
        function (data) {
            if(data.status==200){
                window.localStorage.setItem("token","");
                location.href="/index-student.html";
            }
        }
    )
}
//加入购物车
function buy(productId,count,flag){
    $.post(
        "http://localhost:8081/cartInfo/buy.do",
        {"productId":productId,"count":count,},
        function (data){
            if(data.status==200){
                if(flag==1){
                    location.href="/cart-student.html";
                }else{
                    initCart();
                }

            }else{
                alert(data.msg);
            }

        }
    )
}










