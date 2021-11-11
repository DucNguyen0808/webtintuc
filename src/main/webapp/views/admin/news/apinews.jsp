<%@include file="/common/lbr.jsp"%>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <c:url var="APIurl" value="/api-admin-new" />
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>EDIT NEWS</title>
        </head>

        <body>
            <div class="main-content">
                <div class="main-content-inner">
                    <form id="submitForm">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Title</label>

                            <input value="${model.title}" style="border-style: solid;border-color: black;" type="text" class="col-sm-8" id="title" name="title" placeholder="Nhập title">
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Mô tả ngắn</label>
                            <input value="${model.shortdescription}" style="border-style: solid;border-color: black;" type="text" class="col-sm-8" id="shortdescription" name="shortdescription" placeholder="Nhập mô tả ngắn">
                        </div> <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Hình Ảnh</label>
                            <input value="${model.thumbnail}" style="border-style: solid;border-color: black;" type="text" class="col-sm-8" id="thumbnail" name="thumbnail" placeholder="Nhập mô tả ngắn">
                        </div> <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="exampleFormControlSelect1">Thể Loại</label>
                            <select style="border-style: solid;border-color: black;" class="col-sm-8" id="categorycode" name="categorycode">
    <c:if test="${empty model.categorycode}">
       <option style="color: black;font-size: 16px; " value="">Chọn loại bài viết</option>
     <c:forEach items="${allcategory}" var="a">
      <option value="${a.code}" style="color: black;font-size: 16px; ">${a.name}</option>
     </c:forEach></c:if>
    <c:if test="${ not empty model.categorycode}">
       
     <c:forEach items="${allcategory}" var="a">
     <c:if test="${a.code==model.categorycode}">
      <option value="${a.code}" style="color: black;font-size: 16px; " selected="selected" >${a.name}</option>
     </c:if>
      <c:if test="${a.code!=model.categorycode}">
      <option value="${a.code}" style="color: black;font-size: 16px; " >${a.name}</option>
     </c:if>
     </c:forEach>
     <option style="color: black;font-size: 16px; " value="">Chọn loại bài viết</option>
     </c:if>
    </select>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="exampleFormControlTextarea1">Nội Dung</label>
                          
                            <textarea class="col-sm-3 control-label no-padding-right" rows="20" cols="20"  class="col-sm-8" id="content" name="content" >${model.content}</textarea>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <c:if test="${not empty model.id}">
                                    <input type="button" class="btn btn-green btn-success btn-bold" value="Cập nhật bài viết" id="btnAddOrUpdateNew" />
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <input type="button" class="btn btn-green btn-success btn-bold" value="Thêm bài viết" id="btnAddOrUpdateNew" />
                                </c:if>
                            </div>
                        </div>
                        <input type="hidden" value="${model.id}" id="id" name="id" />

                    </form>
                </div>
            </div>
            <script>
            var editor='';
            $(document).ready(function(){
            	editor=CKEDITOR.replace('content');
            })
                $('#btnAddOrUpdateNew').click(function(e) {
                    e.preventDefault();
                
                    var data = {};
                    var formData = $('#submitForm').serializeArray();
                    $.each(formData, function(ind, vl) {
                        console.log(vl);
                        data["" + vl.name + ""] = vl.value;

                    });
                    var id = $('#id').val();
                    if (id == "") {
                        addNew(data);
                    } else {
                        updateNews(data);
                    }
                    function addNew(data) {
                        $.ajax({
                            url: '${APIurl}',
                            type : 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify(data),
                            dataType: 'json',
                            success: function(result) {
                                console.log(result);
                            },
                            error: function(ero) {
                                console.log(ero);
                            },
                        });

                    }
                    function updateNews(data) {
                        $.ajax({
                            url: '${APIurl}',
                            type : 'PUT',
                            contentType: 'application/json',
                            data: JSON.stringify(data),
                            dataType: 'json',
                            success: function(result) {
                                console.log(result);
                            },
                            error: function(ero) {
                                console.log(ero);
                            },
                        });
                    }

                });
            </script>
        </body>
        <script src="jquery-3.5.1.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        </html>