<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/lbr.jsp" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="trang-chu">News 24/7</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="trang-chu">Home</a></li>
                        <c:if test="${not empty USERMODEL }">  
                        <li class="nav-item"><a class="nav-link" href="#!">Wellcom,${USERMODEL.userName }</a></li>
                        <li class="nav-item"><a class="nav-link" href="thoat?login=thoat">Thoat</a></li>
                          </c:if>
                        <c:if test="${ empty USERMODEL }">
                        <li class="nav-item"><a class="nav-link" href="dang-nhap?login=login">Đăng nhập</a></li>
                        </c:if>
                        
                        <li class="nav-item"><a class="nav-link" href="#!">Contact</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#">Blog</a></li>
                    </ul>
                </div>
            </div>
        </nav>