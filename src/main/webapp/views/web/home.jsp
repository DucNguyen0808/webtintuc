<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/lbr.jsp" %>
<!DOCTYPE html>
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Trang chủ</title>
	</head>
	<body>
		<header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">Welcome to Blog Home!</h1>
                    <p class="lead mb-0">A Bootstrap 5 starter layout for your next blog homepage</p>
                </div>
            </div>
        </header>
        <!-- Page content-->
        <div class="container">
            <div class="row">
                <!-- Blog entries-->
                <div class="col-lg-8">
                    <!-- Featured blog post-->
                    <div class="card mb-4">
                        <a href="#!"><img class="card-img-top" src="https://dummyimage.com/850x350/dee2e6/6c757d.jpg" alt="..." /></a>
                        <div class="card-body">
                            <div class="small text-muted">January 1, 2021</div>
                            <h2 class="card-title">Featured Post Title</h2>
                            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis aliquid atque, nulla? Quos cum ex quis soluta, a laboriosam. Dicta expedita corporis animi vero voluptate voluptatibus possimus, veniam magni quis!</p>
                            <a class="btn btn-primary" href="#!">Read more →</a>
                        </div>
                    </div>
                    <!-- Nested row for non-featured blog posts-->
                    <form action="trang-chu?page=1&maxPageItem=4"  id="formSubmit"   method="get">
                    <div class="row">
                   
                        
                            <!-- Blog post-->
                          <c:forEach var="o" items="${news.listResult}">
                          <div class="col-lg-6">
                       <div class="card mb-4">
                                <a href="#!"><img class="card-img-top" src="${o.thumbnail }" alt="..." /></a>
                                <div class="card-body">
                                    <div class="small text-muted">${o.createdDate}</div>
                                    <h2 class="card-title h4">${o.title}</h2>
                                    <p class="card-text">${o.shortdescription } </p>
                                    <a class="btn btn-primary" href="web-blog?id=${o.id}" name="id">Read more →</a>
                                </div>
                                </div>
                            </div></c:forEach>
											<input type="hidden" value=""  id="page" name="page"/>
											<input type="hidden" value=""  id="maxPageItem" name="maxPageItem"/>
										
                            <!-- Blog post-->
                        
                     
                    </div>
                    </form>
                    <!-- Pagination-->
                 <div class="container">
    <nav aria-label="Page navigation">
        <ul class="pagination" id="pagination"></ul>
    </nav>
    </div>
    <script type="text/javascript">
	var limit =4;
	var totalPage=${news.totalPage}+1;
	var start=${news.page};
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPage,
            visiblePages: 3,
            startPage:start,
            onPageClick: function (event, page) {
            	 if(start!=page){
            		  document.getElementById('maxPageItem').value = limit;
                      document.getElementById('page').value = page;
                     document.getElementById('formSubmit').submit();
            	 }	                             
            }
        }).on('page', function (event, page) {
            console.info(page + ' (from event listening)');
        });
    }); 
</script>

                </div>
                <!-- Side widgets-->
       <div class="col-lg-4">
                    <!-- Search widget-->
                    <div class="card mb-4">
                        <div class="card-header">Search</div>
                        <div class="card-body">
                            <div class="input-group">
                                <input class="form-control" type="text" placeholder="Enter search term..." aria-label="Enter search term..." aria-describedby="button-search" />
                                <button class="btn btn-primary" id="button-search" type="button">Go!</button>
                            </div>
                        </div>
                    </div>
                    <!-- Categories widget-->
                    <div class="card mb-4">
                        <div class="card-header">Categories</div>
                        <div class="card-body">
                            <div class="row">
                            <c:forEach var="o" items="${model.listResult}">
                               <div class="col-sm-6">                              
                                    <ul class="list-unstyled mb-0">
                                        <li><a href="categoryid?id=${o.id}" name="categoryid">${o.name}</a></li>                                      
                                    </ul>
                                </div>                           
                            </c:forEach>                                                       
                            </div>
                        </div>
                    </div>
                    <!-- Side widget-->
                    <div class="card mb-4">
                        <div class="card-header">Side Widget</div>
                        <div class="card-body">You can put anything you want inside of these side widgets. They are easy to use, and feature the Bootstrap 5 card component!</div>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>