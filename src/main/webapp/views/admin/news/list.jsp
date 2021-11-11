<%@include file="/common/lbr.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <c:url var="APIurl" value="/api-admin-new" />
          <c:url var="Newurl" value="/admin-list" />
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Danh sách bài viết</title>
	</head>

	<body>

		<div class="main-content">
			<form action="${pageContext.request.contextPath}/admin-list" id="formSubmit"  method="get">
				<div class="main-content-inner">
					<div class="breadcrumbs ace-save-state" id="breadcrumbs">
						<ul class="breadcrumb">
							<li>
								<i class="ace-icon fa fa-home home-icon"></i>
								<a href="admin-home">Trang chủ</a>
							</li>
						</ul>
						<!-- /.breadcrumb -->
					</div>
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
								<c:if test="${not empty messageResponse}">
									<div class="alert alert-${alert}">
  										${messageResponse}
									</div>
								</c:if>
								<div class="widget-box table-filter">
									<div class="table-btn-controls">
										<div class="pull-right tableTools-container">
											<div class="dt-buttons btn-overlap btn-group">
												<a flag="info"
												   class="dt-button buttons-colvis btn btn-white btn-primary btn-bold" data-toggle="tooltip"
												   title='Thêm bài viết' href='<c:url value="/admin-list?style=edit"/>'>
															<span>
																<i class="fa fa-plus-circle bigger-110 purple"></i>
															</span>
												</a>
												<button id="btnDelete" type="button"
														class="dt-button buttons-html5 btn btn-white btn-primary btn-bold" data-toggle="tooltip" title='Xóa bài viết'>
																<span>
																	<i class="fa fa-trash-o bigger-110 pink"></i>
																</span>
												</button>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12">
										<div class="table-responsive">
											<table class="table table-bordered">
												<thead>
													<tr>
														<th><input type="checkbox" id="checkAll"></th>
														<th>ID</th>
														<th>Tên bài viết</th>
														<th>Mô tả ngắn</th>
														<th>Thao tác</th>
													</tr>
												</thead>
												<tbody>												
													<c:forEach var="p" items="${model.listResult}">
														<tr>
															<td><input  type="checkbox" id="checkbox_${p.id}" value="${p.id}"></td>
															<th>${p.id }</th>
															<td>${p.title}</td>
															<td>${p.shortdescription}</td>
															<td>
																<c:url var="editURL" value="/admin-list">
																	<c:param name="style" value="edit"/>
																	<c:param name="id" value="${p.id}"/>
																</c:url>
																<a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip"
																   title="Cập nhật bài viết" href='${editURL}'><i class="fa fa-pencil-square-o" aria-hidden="true"></i>
																</a>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<ul class="pagination" id="pagination"></ul>
											<input type="hidden" value=""  id="page" name="page"/>
											<input type="hidden" value=""  id="maxPageItem" name="maxPageItem"/>
										
										
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
		</form>
		</div>
		
		<!-- /.main-content -->

<button type="button" ></button>
		<script >
		


		var limit =2;
		var totalPage=${model.totalPage}+1;
		var start=${model.page};
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
	 
        $('#btnDelete').click(function() {
            var data = {};
            var dataArr=$('tbody input[type=checkbox]:checked').map(function(){
            	return $(this).val();
            }).get();
            data['ids']=dataArr;
            deleteNew(data);

        });

        function deleteNew(data) {
            $.ajax({
                url: '${APIurl}',
                type: 'DELETE',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function(result) {
                    window.location.href = "${Newurl}?page=1&maxPageItem=2";
                    alert("xóa thành công");
                },
                error: function(ero) {
                    console.log(ero);
                },
            });

        }

		/** jQuery Bootstrap Pagination v1.4.2
 * https://github.com/josecebe/twbs-pagination
 *
 * Copyright 2014-2018, Eugene Simakin <john-24@list.ru>
 * Released under Apache-2.0 license
 * http://apache.org/licenses/LICENSE-2.0.html
 */

!function(o,e,t,s){"use strict";var i=o.fn.twbsPagination,r=function(t,s){if(this.$element=o(t),this.options=o.extend({},o.fn.twbsPagination.defaults,s),this.options.startPage<1||this.options.startPage>this.options.totalPages)throw new Error("Start page option is incorrect");if(this.options.totalPages=parseInt(this.options.totalPages),isNaN(this.options.totalPages))throw new Error("Total pages option is not correct!");if(this.options.visiblePages=parseInt(this.options.visiblePages),isNaN(this.options.visiblePages))throw new Error("Visible pages option is not correct!");if(this.options.beforePageClick instanceof Function&&this.$element.first().on("beforePage",this.options.beforePageClick),this.options.onPageClick instanceof Function&&this.$element.first().on("page",this.options.onPageClick),this.options.hideOnlyOnePage&&1==this.options.totalPages)return this.options.initiateStartPageClick&&this.$element.trigger("page",1),this;if(this.options.href&&(this.options.startPage=this.getPageFromQueryString(),this.options.startPage||(this.options.startPage=1)),"UL"===("function"==typeof this.$element.prop?this.$element.prop("tagName"):this.$element.attr("tagName")))this.$listContainer=this.$element;else{var e=this.$element,i=o([]);e.each(function(t){var s=o("<ul></ul>");o(this).append(s),i.push(s[0])}),this.$listContainer=i,this.$element=i}return this.$listContainer.addClass(this.options.paginationClass),this.options.initiateStartPageClick?this.show(this.options.startPage):(this.currentPage=this.options.startPage,this.render(this.getPages(this.options.startPage)),this.setupEvents()),this};r.prototype={constructor:r,destroy:function(){return this.$element.empty(),this.$element.removeData("twbs-pagination"),this.$element.off("page"),this},show:function(t){if(t<1||t>this.options.totalPages)throw new Error("Page is incorrect.");this.currentPage=t,this.$element.trigger("beforePage",t);var s=this.getPages(t);return this.render(s),this.setupEvents(),this.$element.trigger("page",t),s},enable:function(){this.show(this.currentPage)},disable:function(){var t=this;this.$listContainer.off("click").on("click","li",function(t){t.preventDefault()}),this.$listContainer.children().each(function(){o(this).hasClass(t.options.activeClass)||o(this).addClass(t.options.disabledClass)})},buildListItems:function(t){var s=[];if(this.options.first&&s.push(this.buildItem("first",1)),this.options.prev){var e=1<t.currentPage?t.currentPage-1:this.options.loop?this.options.totalPages:1;s.push(this.buildItem("prev",e))}for(var i=0;i<t.numeric.length;i++)s.push(this.buildItem("page",t.numeric[i]));if(this.options.next){var a=t.currentPage<this.options.totalPages?t.currentPage+1:this.options.loop?1:this.options.totalPages;s.push(this.buildItem("next",a))}return this.options.last&&s.push(this.buildItem("last",this.options.totalPages)),s},buildItem:function(t,s){var e=o("<li></li>"),i=o("<a></a>"),a=this.options[t]?this.makeText(this.options[t],s):s;return e.addClass(this.options[t+"Class"]),e.data("page",s),e.data("page-type",t),e.append(i.attr("href",this.makeHref(s)).addClass(this.options.anchorClass).html(a)),e},getPages:function(t){var s=[],e=Math.floor(this.options.visiblePages/2),i=t-e+1-this.options.visiblePages%2,a=t+e,n=this.options.visiblePages;n>this.options.totalPages&&(n=this.options.totalPages),i<=0&&(i=1,a=n),a>this.options.totalPages&&(i=this.options.totalPages-n+1,a=this.options.totalPages);for(var o=i;o<=a;)s.push(o),o++;return{currentPage:t,numeric:s}},render:function(s){var e=this;this.$listContainer.children().remove();var t=this.buildListItems(s);o.each(t,function(t,s){e.$listContainer.append(s)}),this.$listContainer.children().each(function(){var t=o(this);switch(t.data("page-type")){case"page":t.data("page")===s.currentPage&&t.addClass(e.options.activeClass);break;case"first":t.toggleClass(e.options.disabledClass,1===s.currentPage);break;case"last":t.toggleClass(e.options.disabledClass,s.currentPage===e.options.totalPages);break;case"prev":t.toggleClass(e.options.disabledClass,!e.options.loop&&1===s.currentPage);break;case"next":t.toggleClass(e.options.disabledClass,!e.options.loop&&s.currentPage===e.options.totalPages)}})},setupEvents:function(){var e=this;this.$listContainer.off("click").on("click","li",function(t){var s=o(this);if(s.hasClass(e.options.disabledClass)||s.hasClass(e.options.activeClass))return!1;!e.options.href&&t.preventDefault(),e.show(parseInt(s.data("page")))})},changeTotalPages:function(t,s){return this.options.totalPages=t,this.show(s)},makeHref:function(t){return this.options.href?this.generateQueryString(t):"#"},makeText:function(t,s){return t.replace(this.options.pageVariable,s).replace(this.options.totalPagesVariable,this.options.totalPages)},getPageFromQueryString:function(t){var s=this.getSearchString(t),e=new RegExp(this.options.pageVariable+"(=([^&#]*)|&|#|$)").exec(s);return e&&e[2]?(e=decodeURIComponent(e[2]),e=parseInt(e),isNaN(e)?null:e):null},generateQueryString:function(t,s){var e=this.getSearchString(s),i=new RegExp(this.options.pageVariable+"=*[^&#]*");return e?"?"+e.replace(i,this.options.pageVariable+"="+t):""},getSearchString:function(t){var s=t||e.location.search;return""===s?null:(0===s.indexOf("?")&&(s=s.substr(1)),s)},getCurrentPage:function(){return this.currentPage},getTotalPages:function(){return this.options.totalPages}},o.fn.twbsPagination=function(t){var s,e=Array.prototype.slice.call(arguments,1),i=o(this),a=i.data("twbs-pagination"),n="object"==typeof t?t:{};return a||i.data("twbs-pagination",a=new r(this,n)),"string"==typeof t&&(s=a[t].apply(a,e)),void 0===s?i:s},o.fn.twbsPagination.defaults={totalPages:1,startPage:1,visiblePages:5,initiateStartPageClick:!0,hideOnlyOnePage:!1,href:!1,pageVariable:"{{page}}",totalPagesVariable:"{{total_pages}}",page:null,first:"First",prev:"Previous",next:"Next",last:"Last",loop:!1,beforePageClick:null,onPageClick:null,paginationClass:"pagination",nextClass:"page-item next",prevClass:"page-item prev",lastClass:"page-item last",firstClass:"page-item first",pageClass:"page-item",activeClass:"active",disabledClass:"disabled",anchorClass:"page-link"},o.fn.twbsPagination.Constructor=r,o.fn.twbsPagination.noConflict=function(){return o.fn.twbsPagination=i,this},o.fn.twbsPagination.version="1.4.2"}(window.jQuery,window,document);
/*
 * jQuery Bootstrap Pagination v1.4.2
 * https://github.com/josecebe/twbs-pagination
 *
 * Copyright 2014-2018, Eugene Simakin <john-24@list.ru>
 * Released under Apache-2.0 license
 * http://apache.org/licenses/LICENSE-2.0.html
 */

 !function(o,e,t,s){"use strict";var i=o.fn.twbsPagination,r=function(t,s){if(this.$element=o(t),this.options=o.extend({},o.fn.twbsPagination.defaults,s),this.options.startPage<1||this.options.startPage>this.options.totalPages)throw new Error("Start page option is incorrect");if(this.options.totalPages=parseInt(this.options.totalPages),isNaN(this.options.totalPages))throw new Error("Total pages option is not correct!");if(this.options.visiblePages=parseInt(this.options.visiblePages),isNaN(this.options.visiblePages))throw new Error("Visible pages option is not correct!");if(this.options.beforePageClick instanceof Function&&this.$element.first().on("beforePage",this.options.beforePageClick),this.options.onPageClick instanceof Function&&this.$element.first().on("page",this.options.onPageClick),this.options.hideOnlyOnePage&&1==this.options.totalPages)return this.options.initiateStartPageClick&&this.$element.trigger("page",1),this;if(this.options.href&&(this.options.startPage=this.getPageFromQueryString(),this.options.startPage||(this.options.startPage=1)),"UL"===("function"==typeof this.$element.prop?this.$element.prop("tagName"):this.$element.attr("tagName")))this.$listContainer=this.$element;else{var e=this.$element,i=o([]);e.each(function(t){var s=o("<ul></ul>");o(this).append(s),i.push(s[0])}),this.$listContainer=i,this.$element=i}return this.$listContainer.addClass(this.options.paginationClass),this.options.initiateStartPageClick?this.show(this.options.startPage):(this.currentPage=this.options.startPage,this.render(this.getPages(this.options.startPage)),this.setupEvents()),this};r.prototype={constructor:r,destroy:function(){return this.$element.empty(),this.$element.removeData("twbs-pagination"),this.$element.off("page"),this},show:function(t){if(t<1||t>this.options.totalPages)throw new Error("Page is incorrect.");this.currentPage=t,this.$element.trigger("beforePage",t);var s=this.getPages(t);return this.render(s),this.setupEvents(),this.$element.trigger("page",t),s},enable:function(){this.show(this.currentPage)},disable:function(){var t=this;this.$listContainer.off("click").on("click","li",function(t){t.preventDefault()}),this.$listContainer.children().each(function(){o(this).hasClass(t.options.activeClass)||o(this).addClass(t.options.disabledClass)})},buildListItems:function(t){var s=[];if(this.options.first&&s.push(this.buildItem("first",1)),this.options.prev){var e=1<t.currentPage?t.currentPage-1:this.options.loop?this.options.totalPages:1;s.push(this.buildItem("prev",e))}for(var i=0;i<t.numeric.length;i++)s.push(this.buildItem("page",t.numeric[i]));if(this.options.next){var a=t.currentPage<this.options.totalPages?t.currentPage+1:this.options.loop?1:this.options.totalPages;s.push(this.buildItem("next",a))}return this.options.last&&s.push(this.buildItem("last",this.options.totalPages)),s},buildItem:function(t,s){var e=o("<li></li>"),i=o("<a></a>"),a=this.options[t]?this.makeText(this.options[t],s):s;return e.addClass(this.options[t+"Class"]),e.data("page",s),e.data("page-type",t),e.append(i.attr("href",this.makeHref(s)).addClass(this.options.anchorClass).html(a)),e},getPages:function(t){var s=[],e=Math.floor(this.options.visiblePages/2),i=t-e+1-this.options.visiblePages%2,a=t+e,n=this.options.visiblePages;n>this.options.totalPages&&(n=this.options.totalPages),i<=0&&(i=1,a=n),a>this.options.totalPages&&(i=this.options.totalPages-n+1,a=this.options.totalPages);for(var o=i;o<=a;)s.push(o),o++;return{currentPage:t,numeric:s}},render:function(s){var e=this;this.$listContainer.children().remove();var t=this.buildListItems(s);o.each(t,function(t,s){e.$listContainer.append(s)}),this.$listContainer.children().each(function(){var t=o(this);switch(t.data("page-type")){case"page":t.data("page")===s.currentPage&&t.addClass(e.options.activeClass);break;case"first":t.toggleClass(e.options.disabledClass,1===s.currentPage);break;case"last":t.toggleClass(e.options.disabledClass,s.currentPage===e.options.totalPages);break;case"prev":t.toggleClass(e.options.disabledClass,!e.options.loop&&1===s.currentPage);break;case"next":t.toggleClass(e.options.disabledClass,!e.options.loop&&s.currentPage===e.options.totalPages)}})},setupEvents:function(){var e=this;this.$listContainer.off("click").on("click","li",function(t){var s=o(this);if(s.hasClass(e.options.disabledClass)||s.hasClass(e.options.activeClass))return!1;!e.options.href&&t.preventDefault(),e.show(parseInt(s.data("page")))})},changeTotalPages:function(t,s){return this.options.totalPages=t,this.show(s)},makeHref:function(t){return this.options.href?this.generateQueryString(t):"#"},makeText:function(t,s){return t.replace(this.options.pageVariable,s).replace(this.options.totalPagesVariable,this.options.totalPages)},getPageFromQueryString:function(t){var s=this.getSearchString(t),e=new RegExp(this.options.pageVariable+"(=([^&#]*)|&|#|$)").exec(s);return e&&e[2]?(e=decodeURIComponent(e[2]),e=parseInt(e),isNaN(e)?null:e):null},generateQueryString:function(t,s){var e=this.getSearchString(s),i=new RegExp(this.options.pageVariable+"=*[^&#]*");return e?"?"+e.replace(i,this.options.pageVariable+"="+t):""},getSearchString:function(t){var s=t||e.location.search;return""===s?null:(0===s.indexOf("?")&&(s=s.substr(1)),s)},getCurrentPage:function(){return this.currentPage},getTotalPages:function(){return this.options.totalPages}},o.fn.twbsPagination=function(t){var s,e=Array.prototype.slice.call(arguments,1),i=o(this),a=i.data("twbs-pagination"),n="object"==typeof t?t:{};return a||i.data("twbs-pagination",a=new r(this,n)),"string"==typeof t&&(s=a[t].apply(a,e)),void 0===s?i:s},o.fn.twbsPagination.defaults={totalPages:1,startPage:1,visiblePages:5,initiateStartPageClick:!0,hideOnlyOnePage:!1,href:!1,pageVariable:"{{page}}",totalPagesVariable:"{{total_pages}}",page:null,first:"First",prev:"Previous",next:"Next",last:"Last",loop:!1,beforePageClick:null,onPageClick:null,paginationClass:"pagination",nextClass:"page-item next",prevClass:"page-item prev",lastClass:"page-item last",firstClass:"page-item first",pageClass:"page-item",activeClass:"active",disabledClass:"disabled",anchorClass:"page-link"},o.fn.twbsPagination.Constructor=r,o.fn.twbsPagination.noConflict=function(){return o.fn.twbsPagination=i,this},o.fn.twbsPagination.version="1.4.2"}(window.jQuery,window,document);
</script>
	
	</body>

	</html>