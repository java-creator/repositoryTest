<%--
  Created by IntelliJ IDEA.
  User: 暖轻
  Date: 2019/11/12
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!--引入jsp-->
    <jsp:include page="../common/static.jsp" />
<script>

    //用于存放新增药品DIV的HTML代码的全局变量
    var addDrugDivHTML;
    //用于存放修改药品DIV的HTML代码的全局变量
    var updateDrugDivHTML;

    //jquery加载函数
    $(function() {
       //添加div
        addDrugDivHTML = $("#addDrugDiv").html();
        //修改div
        updateDrugDivHTML = $("#updateDrugDiv").html();

        //初始化查询条件面板中的过期日期
        initDateTimePicker("#minExpiredDate", "YYYY-MM-DD");
        initDateTimePicker("#maxExpiredDate", "YYYY-MM-DD");

        //初始化查询条件面板中的生产日期
        initDateTimePicker("#minProducedDate");
        initDateTimePicker("#maxProducedDate");


        //初始化查询条件面板中产地下拉框
        initAreaSelect();

        //初始化查询条件面板中品牌下拉框
        initBrandSelect();

        //初始化药品表格
        initDrugTable();
    })
    //时间
    function initDateTimePicker(selector,abc){
        abc = abc == undefined ? "YYYY-MM-DD HH:mm:ss" : abc;
        $(selector).datetimepicker({
            format:abc,
            locale:"zh-CN",
            showClear:true
        });
    }

    //刷新
    function search(){
        drugTable.ajax.reload();
    }

    //用于存放所有产地的数组
    var areaArr;
    function initAreaSelect() {
        $.ajax({
            url: "<%=request.getContextPath()%>/drug/queryAreaList.do",
            dataType: "json",
            success: function (result) {
                if (result.code == 200) {
                    //地区数组
                    areaArr = result.data;
                    var optionsHTML = "";
                    for (var i = 0; i < result.data.length; i++) {     //封装类里面的
                        optionsHTML += "<option value='" + result.data[i].areaId + "'>" + result.data[i].areaName + "</option>";
                    }
                    $("#areaId").append(optionsHTML);
                } else {
                    alert("查询所有产地失败!");
                }
            },
            error: function () {
                alert("查询所有产地失败!");
            }
        });
    }
    //用于存放所有品牌的数组
    var brandArr;
    function initBrandSelect() {
        $.ajax({
            url: "<%=request.getContextPath()%>/drug/queryBrandList.do",
            dataType: "json",
            success: function (result) {
                if (result.code == 200) {
                    //添加 品牌数组
                    brandArr = result.data;
                    var optionsHTML = "";
                    for (var i = 0; i < result.data.length; i++) {     //封装类
                        optionsHTML += "<option value='" + result.data[i].brandId + "'>" + result.data[i].brandName + "</option>";
                    }
                    $("#brandId").append(optionsHTML);
                } else {
                    alert("查询所有品牌失败!");
                }
            },
            error: function () {
                alert("查询所有品牌失败!");
            }
        });
    }
    //查询
    var drugTable;
    function initDrugTable() {
      //初始化药品表格
      drugTable = $("#drugTable").DataTable({
          searching: false,
          ordering: false,
          serverSide: true, //开启服务端模式
          lengthMenu: [3, 5, 10, 15],
          processing: true,//是否显示正在处理中
          language: chinese,//引入
          ajax: {
              url: "<%=request.getContextPath()%>/drug/queryDrugList.do",
              data: function (param) {
                  //DataTables在发送ajax请求的时候会发送一些自己的参数，比如说每页显示条数，起始条数等等。。。
                  //通过param这个参数咱们可以设置自己需要传递的参数，比如说条件查询的值
                  //条件查询传值
                  //param后是封装类里面的
                  //括号中的是条件查询jsp页面里面id里的
                  param.name = $("#name").val();
                  param.minPrice = $("#minPrice").val();
                  param.maxPrice = $("#maxPrice").val();
                  param.minSales = $("#minSales").val();
                  param.maxSales = $("#maxSales").val();
                  param.areaId = $("#areaId").val();
                  param.minStock = $("#minStock").val();
                  param.maxStock = $("#maxStock").val();
                  param.minExpiredDate = $("#minExpiredDate").val();
                  param.maxExpiredDate = $("#maxExpiredDate").val();
                  param.brandId = $("#brandId").val();
                  param.minProducedDate = $("#minProducedDate").val();
                  param.maxProducedDate = $("#maxProducedDate").val();

                  //获取适合人群  复选框
                  var personCheckboxes = $("[name=person]:checked");
                  if (personCheckboxes.length > 0) {
                      var person = "";
                      personCheckboxes.each(function (abc, def) {
                          //abc 代表当前循环的下标
                          //def 代表当前遍历的元素(DOM对象)
                          //this代表当前遍历的复选框，是一个DOM对象，JQuery对象
                          person += def.value + ",";
                      });
                      person = person.substring(0, person.length - 1);
                      param.person = person;
                  }
                  //单选
                  param.isOTC = $("[name=isOTC]:checked").val();

              }
          },
          //data都是封装类里面的
          columns: [
              {
                  data: "id",
                  render: function (data) {
                      return "<input type='checkbox' name='id' value='" + data + "'/>";
                  }
              },
              {data: "drugName"},
              {data: "drugPrice"},
              {data: "areaName"},
              {data: "brandName"},
              {data: "drugSales"},
              {data: "drugStock"},
              {
                  data: "isOTC",
                  render: function (data) {
                      return data == 1 ? "是" : "否";
                  }
              },
              {
                  data: "person",
                  render: function (data) {
                      return data.replace("1", "幼年").replace("2", "少年").replace("3", "青年").replace("4", "中年").replace("5", "老年").replace("6", "孕妇");
                  }
              },
              {
                  data: "filePath",
                  render: function (data) {
                      return "<img width='50' height='50' src='<%=request.getContextPath()%>" + data + "' />";
                  }
              },
              {
                  data: "producedDate",
                  render: function (data) {
                      return datetimeFormat_2(data);
                  }
              },
              {
                  data: "expiredDate",
                  render: function (data) {
                      return datetimeFormat_3(data);
                  }
              },
              {
                  data: "createDate",
                  render: function (data) {
                      return datetimeFormat_2(data);
                  }
              },
              {
                  data: "updateDate",
                  render: function (data) {
                      return datetimeFormat_2(data);
                  }
              },
              {
                  data: "id",
                  render: function (data) {
                      return '<div class="btn-group btn-group-xs">' +
                          '<button type="button" onclick="showUpdateDrugDialog(' + data + ')" class="btn btn-primary">' +
                          '<span class="glyphicon glyphicon-pencil"></span>&nbsp;修改' +
                          '</button>' +
                          '<button type="button" onclick="deleteDrug(' + data + ')" class="btn btn-success">' +
                          '<span class="glyphicon glyphicon-trash"></span>&nbsp;删除' +
                          '</button>' +
                          '</div>';
                  }
              }
          ]
      });
//最后
  }

    //添加
    function showAddDrugDialog(){

        //初始化新增药品表单中产地下拉框
        var areaOptionsHTML = "";
        for(var i = 0 ; i < areaArr.length ; i ++ ){
            areaOptionsHTML += "<option value='" + areaArr[i].areaId + "'>" + areaArr[i].areaName + "</option>";
        }
        $("#addArea").append(areaOptionsHTML);

        //初始化新增药品表单中品牌下拉框
        var brandOptionsHTML = "";
        for(var i = 0 ; i < brandArr.length ; i ++ ){
            brandOptionsHTML += "<option value='" + brandArr[i].brandId + "'>" + brandArr[i].brandName + "</option>";
        }
        $("#addBrand").append(brandOptionsHTML);

        //初始化新增药品表单中的药品图片文件域
        $("#addFile").fileinput({
            language:"zh",//设置语言选项
            maxFileCount:1,//设置最大上传文件个数
            //设置文件上传的地址
            uploadUrl:"<%=request.getContextPath()%>/drug/uploadFile.do"
        });
        //设置文件上传之后的回调函数
        $("#addFile").on("fileuploaded",function(a,b,c,d){
            //其中b就代表服务器返回的数据
            var result = b.response;
            if(result.code == 200){
                //将图片上传后的相对路径放入新增药品表单中的用于存放图片相对路径的隐藏域中
                $("#addFilePath").val(result.filePath);
            }
        });

        //初始化新增药品表单中的过期时间
        initDateTimePicker("#addExpiredDate","YYYY-MM-DD");

        //初始化新增药品表单中的生产时间
        initDateTimePicker("#addProducedDate");


        //使用bootbox弹框插件弹出新增药品的对话框
        bootbox.confirm({
            title:"新增药品",
            message:$("#addDrugDiv").children(),
            buttons:{
                confirm:{
                    label:"确认"
                },
                cancel:{
                    label:"取消",
                    className:"btn btn-success"
                }
            },
            callback:function(result){
                //如果点击了确认按钮
                if(result){
                    var param = {};
                    //获取新增药品表单中的数据
                    param.drugName = $("#addName").val();
                    param.drugPrice = $("#addPrice").val();
                    param.areaId = $("#addArea").val();
                    param.brandId = $("#addBrand").val();
                    param.drugSales = $("#addSales").val();
                    param.drugStock = $("#addStock").val();
                    param.isOTC = $("[name=addOTC]:checked").val();
                    //获取适合适合
                    var person = "";
                    $("[name=addPerson]:checked").each(function(){
                        person += this.value + ",";
                    });
                    if(person != ""){
                        person = person.substring(0,person.length-1);
                    }
                    param.person = person;
                    param.filePath = $("#addFilePath").val();
                    param.producedDate = $("#addProducedDate").val();
                    param.expiredDate = $("#addExpiredDate").val();

                    //发起一个新增药品的ajax请求
                    $.ajax({
                        url:"<%=request.getContextPath()%>/drug/addDrug.do",
                        type:"post",
                        data:param,
                        dataType:"json",
                        success:function(result){
                            if(result.code == 200){
                                //重新加载表格中的数据
                                search();
                            }else{
                                alert("新增药品失败!");
                            }
                        },
                        error:function(){
                            alert("新增药品失败!");
                        }
                    });
                }
                $("#addDrugDiv").html(addDrugDivHTML);
            }
        });
    }
    //删除
    function deleteDrug(id){
        alert(id);
        //弹出一个确认框
        bootbox.confirm({
            title:"删除提示",
            message:"您确定要删除吗?",
            buttons:{
                //設置確定按鈕的文字和樣式
                confirm:{
                    label:"确认",
                    className:"btn btn-success"
                },
                //設置取消按鈕的文字和樣式
                cancel:{
                    label:"取消",
                    className:"btn btn-success"
                }
            },
            callback:function(result){
                //如果用户点击了确认按钮
                if(result){
                    //发起一个删除服装的ajax请求
                    $.ajax({
                        url:"<%=request.getContextPath()%>/drug/deleteDrug.do",
                        type:"post",
                        data:{id:id},
                        dataType:"json",
                        success:function(result){
                            if(result.code == 200){
                                //重新加载表格中的数据
                                search();
                            }else{
                                alert("删除药品失败!");
                            }
                        },
                        error:function(){
                            alert("删除药品失败!");
                        }
                    });
                }
            }
        });
    }
    //修改
    function showUpdateDrugDialog(id){
        alert(id);
        //发起一个通过id查询单个药品信息的ajax请求
        $.ajax({
            url:"<%=request.getContextPath()%>/drug/getDrugById.do",
            data:{id:id},
            dataType:"json",
            success:function(result){
                if(result.code == 200){

                    //初始化修改药品表单中产地下拉框
                    var areaOptionsHTML = "";
                    for(var i = 0 ; i < areaArr.length ; i ++ ){
                        areaOptionsHTML += "<option value='" + areaArr[i].areaId + "'>" + areaArr[i].areaName + "</option>";
                    }
                    $("#updateArea").append(areaOptionsHTML);

                    //初始化修改药品表单中品牌下拉框
                    var brandOptionsHTML = "";
                    for(var i = 0 ; i < brandArr.length ; i ++ ){
                        brandOptionsHTML += "<option value='" + brandArr[i].brandId + "'>" + brandArr[i].brandName + "</option>";
                    }
                    $("#updateBrand").append(brandOptionsHTML);

                    //初始化修改药品表单中的药品图片文件域
                    $("#updateFile").fileinput({
                        language:"zh",//设置语言选项
                        maxFileCount:1,//设置最大上传文件个数
                        //设置文件上传的地址
                        uploadUrl:"<%=request.getContextPath()%>/drug/uploadFile.do"
                    });
                    //设置文件上传之后的回调函数
                    $("#updateFile").on("fileuploaded",function(a,b,c,d){
                        //其中b就代表服务器返回的数据
                        var result = b.response;
                        if(result.code == 200){
                            //将图片上传后的相对路径放入修改药品表单中的用于存放图片相对路径的隐藏域中
                            $("#updateFilePath").val(result.filePath);
                        }
                    });

                    //初始化修改药品表单中的过期时间
                    initDateTimePicker("#updateExpiredDate","YYYY-MM-DD");

                    //初始化修改药品表单中的生产时间
                    initDateTimePicker("#updateProducedDate");



                    var drug = result.data;

                    //回显修改药品表单中的数据了
                    $("#updateName").val(drug.drugName);
                    $("#updatePrice").val(drug.drugPrice);
                    $("#updateArea").val(drug.areaId);
                    $("#updateBrand").val(drug.brandId);
                    $("#updateStock").val(drug.drugStock);
                    $("#updateSales").val(drug.drugSales);
                    $("[name=updateOTC][value=" + drug.isOTC + "]").prop("checked",true);
                    var person = drug.person.split(",");
                    $("[name=updatePerson]").each(function(){
                        if(person.indexOf(this.value) != -1){
                            this.checked = true;
                        }
                    });
                    $("#updateFilePath").val(drug.filePath);
                    $("#updateFileImg").attr("src","<%=request.getContextPath()%>" + drug.filePath);
                    $("#updateProducedDate").val(datetimeFormat_2(drug.producedDate));
                    $("#updateExpiredDate").val(datetimeFormat_3(drug.expiredDate));


                    //弹出修改药品对话框
                    bootbox.confirm({
                        title:"修改药品",
                        message:$("#updateDrugDiv").children(),
                        buttons:{
                            //設置確定按鈕的文字和樣式
                            confirm:{
                                label:"确认",
                                className:"btn btn-success"
                            },
                            //設置取消按鈕的文字和樣式
                            cancel:{
                                label:"取消",
                                className:"btn btn-primary"
                            }
                        },
                        callback:function(result){
                            if(result){


                                var param = {};
                                //获取修改药品表单中的数据
                                param.id = drug.id;
                                param.drugName = $("#updateName").val();
                                param.drugPrice = $("#updatePrice").val();
                                param.areaId = $("#updateArea").val();
                                param.brandId = $("#updateBrand").val();
                                param.drugSales = $("#updateSales").val();
                                param.drugStock = $("#updateStock").val();
                                param.isOTC = $("[name=updateOTC]:checked").val();
                                //获取适合人群
                                var person = "";
                                $("[name=updatePerson]:checked").each(function(){
                                    person += this.value + ",";
                                });
                                if(person != ""){
                                    person = person.substring(0,person.length-1);
                                }
                                param.person = person;
                                param.filePath = $("#updateFilePath").val();
                                param.producedDate = $("#updateProducedDate").val();
                                param.expiredDate = $("#updateExpiredDate").val();

                                //发起一个修改药品的ajax请求
                                $.ajax({
                                    url:"<%=request.getContextPath()%>/drug/updateDrug.do",
                                    type:"post",
                                    data:param,
                                    dataType:"json",
                                    success:function(result){
                                        if(result.code == 200){
                                            //重新加载表格中的数据
                                            search();
                                        }else{
                                            alert("修改药品失败!");
                                        }
                                    },
                                    error:function(){
                                        alert("修改药品失败!");
                                    }
                                });


                            }
                            $("#updateDrugDiv").html(updateDrugDivHTML);
                        }
                    });

                }else{
                    alert("查询药品失败!");
                }
            },
            error:function(){

            }
        });
    }
    //批量删
    function batchDeleteDrug(){
        var idCheckboxes = $("[name=id]:checked");
        if(idCheckboxes.length > 0){
            //弹出一个确认框
            bootbox.confirm({
                title:"删除提示",
                message:"您确定要删除吗?",
                buttons:{
                    //設置確定按鈕的文字和樣式
                    confirm:{
                        label:"确认",
                        className:"btn btn-success"
                    },
                    //設置取消按鈕的文字和樣式
                    cancel:{
                        label:"取消",
                        className:"btn btn-primary"
                    }
                },
                callback:function(result){
                    if(result){
                        var idArr = [];
                        idCheckboxes.each(function(){
                            idArr.push(this.value);
                        });

                        //发起一个批量删除药品的ajax请求
                        $.ajax({
                            url:"<%=request.getContextPath()%>/drug/batchDeleteDrug.do",
                            type:"post",
                            data:{ids:idArr},
                            dataType:"json",
                            success:function(result){
                                if(result.code == 200){
                                    //重新加载表格中的数据
                                    search();
                                }else{
                                    alert("批量删除药品失败!");
                                }
                            },
                            error:function(){
                                alert("批量删除药品失败!");
                            }
                        });
                    }
                }
            });

        }else{
            alert("请先选择要删除的药品!");
        }
    }



</script>



</head>
<body>
<!-- 引入导航栏 -->
<jsp:include page="../common/nav.jsp" />

<!--修改药品的DIV-->
<div id="updateDrugDiv" style="display: none">
    <!--修改药品的form表单-->
    <form id="updateDrugForm" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">药品名称</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="updateName" placeholder="请输⼊药品名称">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">药品价格</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="updatePrice" placeholder="请输⼊药品价格">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">产地</label>
            <div class="col-sm-10">
                <select id="updateArea" class="form-control">
                    <option value="-1">请选择</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10">
                <select id="updateBrand" class="form-control">
                    <option value="-1">请选择</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">销量</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="updateSales">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">库存</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="updateStock">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">处方药:</label>
            <div class="col-sm-10">
                <label class="radio-inline">
                    <input type="radio" name="updateOTC" value="1"> 是
                </label>
                <label class="radio-inline">
                    <input type="radio" name="updateOTC" value="2"> 否
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">适合人群:</label>
            <div class="col-sm-10">
                <label class="checkbox-inline">
                    <input type="checkbox" name="updatePerson" value="1"> 幼儿
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="updatePerson" value="2"> 少年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="updatePerson" value="3"> 青年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="updatePerson" value="4"> 中年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="updatePerson" value="5"> 老年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="updatePerson" value="6"> 孕妇
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">药品图片</label>
            <div class="col-sm-10">
                <!-- 用于存放上传的图片相对路径的隐藏域 -->
                <input type="text" id="updateFilePath" />
                <img src="" id="updateFileImg" width="50" height="50">
                <input type="file" class="form-control" name="file" id="updateFile">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="updateProducedDate">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">过期时间</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="updateExpiredDate">
            </div>
        </div>
    </form>
</div>

<!--新增药品的DIV-->
<div id="addDrugDiv" style="display: none">
    <!--新增药品的form表单-->
    <form id="addDrugForm" class="form-horizontal">
        <div class="form-group">
            <label class="col-sm-2 control-label">药品名称</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addName" placeholder="请输⼊药品名称">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">药品价格</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addPrice" placeholder="请输⼊药品价格">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">产地</label>
            <div class="col-sm-10">
                <select id="addArea" class="form-control">
                    <option value="-1">请选择</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">品牌</label>
            <div class="col-sm-10">
                <select id="addBrand" class="form-control">
                    <option value="-1">请选择</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">销量</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addSales">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">库存</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addStock">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">处方药:</label>
            <div class="col-sm-10">
                <label class="radio-inline">
                    <input type="radio" name="addOTC" value="1"> 是
                </label>
                <label class="radio-inline">
                    <input type="radio" name="addOTC" value="2"> 否
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">适合人群:</label>
            <div class="col-sm-10">
                <label class="checkbox-inline">
                    <input type="checkbox" name="addPerson" value="1"> 幼儿
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="addPerson" value="2"> 少年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="addPerson" value="3"> 青年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="addPerson" value="4"> 中年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="addPerson" value="5"> 老年
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="addPerson" value="6"> 孕妇
                </label>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">药品图片</label>
            <div class="col-sm-10">
                <!-- 用于存放上传的图片相对路径的隐藏域 -->
                <input type="text" id="addFilePath" />
                <input type="file" class="form-control" name="file" id="addFile">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">生产日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addProducedDate">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">过期时间</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="addExpiredDate">
            </div>
        </div>
    </form>
</div>

<!-- 查询条件面板 -->
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">
            查询条件
        </h3>
    </div>
    <div class="panel-body">
        <form class="form-horizontal" role="form">
            <div class="container">
                <div class="row"><!--第一行 名称 价格-->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">药品名称:</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="name" placeholder="请输⼊药品名称">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">药品价格:</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="minPrice" class="form-control" placeholder="请输入起始价格">
                                    <span class="input-group-addon">--</span>
                                    <input type="text" id="maxPrice" class="form-control" placeholder="请输入结束价格">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row"><!--第一行 销量 产地-->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">销量:</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="minSales" class="form-control" placeholder="请输入起始销量">
                                    <span class="input-group-addon">--</span>
                                    <input type="text" id="maxSales" class="form-control" placeholder="请输入结束销量">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">产地:</label>
                            <div class="col-sm-10">
                                <select id="areaId" class="form-control">
                                    <option value="-1">请选择</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row"><!--第一行 库存 过期时间-->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">库存:</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="minStock" class="form-control">
                                    <span class="input-group-addon">--</span>
                                    <input type="text" id="maxStock" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">过期时间:</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="minExpiredDate" class="form-control">
                                    <span class="input-group-addon">--</span>
                                    <input type="text" id="maxExpiredDate" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row"><!--第一行 品牌 生产时间-->
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">品牌:</label>
                            <div class="col-sm-10">
                                <select id="brandId" class="form-control">
                                    <option value="-1">请选择</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">生产日期:</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="minProducedDate" class="form-control">
                                    <span class="input-group-addon">--</span>
                                    <input type="text" id="maxProducedDate" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6"><!--第一行 人群 处方药-->
                        <div class="form-group">
                            <label class="col-sm-2 control-label">适合人群:</label>
                            <div class="col-sm-10">
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="person" value="1"> 幼儿
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="person" value="2"> 少年
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="person" value="3"> 青年
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="person" value="4"> 中年
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="person" value="5"> 老年
                                </label>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="person" value="6"> 孕妇
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">处方药:</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="isOTC" value="1"> 是
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="isOTC" value="2"> 否
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12" style="text-align:center">
                        <button type="button" class="btn btn-primary" onclick="search()">
                            <span class="glyphicon glyphicon-search"></span>&nbsp;查询
                        </button>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button type="reset" class="btn btn-success">
                            <span class="glyphicon glyphicon-refresh"></span>&nbsp;重置
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!--药品列表面板 -->
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title">
            药品列表
        </h3>
    </div>
    <div class="panel-body">
        <div style="margin-bottom:10px">
            <button onclick="showAddDrugDialog()" type="button" class="btn btn-primary">
                <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
            </button>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <button onclick="batchDeleteDrug()" type="reset" class="btn btn-success">
                <span class="glyphicon glyphicon-minus"></span>&nbsp;批量删除
            </button>
        </div>

        <table id="drugTable" class="table table-striped table-bordered table-hover table-condensed">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" />
                </th>
                <th>药品名称</th>
                <th>价格</th>
                <th>产地</th>
                <th>品牌</th>
                <th>销量</th>
                <th>库存</th>
                <th>处方药</th>
                <th>适合人群</th>
                <th>药品图片</th>
                <th>生产日期</th>
                <th>过期日期</th>
                <th>创建日期</th>
                <th>修改日期</th>
                <th>操作</th>
            </tr>
            </thead>
        </table>
    </div>
</div>

</body>
</html>
