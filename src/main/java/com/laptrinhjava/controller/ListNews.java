package com.laptrinhjava.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demojsp.model.News;
import com.laptrinhjava.contant.SystemConstant;
import com.laptrinhjava.service.ICatrgoryService;
import com.laptrinhjava.service.INewService;
import com.laptrinhjava.utils.FormUtil;

@WebServlet(urlPatterns = { "/admin-list" })
public class ListNews extends HttpServlet {
	@Inject
	INewService news;
	@Inject
	ICatrgoryService allcategory;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
		News news1 = FormUtil.toModel(News.class, req);
		String views="";
		if(news1.getStyle()==null) {
		if (news1.getPage() == null)
			news1.setPage(1);
		if (news1.getMaxPageItem() == null)
			news1.setMaxPageItem(2);
		Integer offset = (news1.getPage() - 1) * news1.getMaxPageItem();
		news1.setListResult(news.findAllNews(offset, news1.getMaxPageItem(), "id", "desc"));
		news1.setTotalItem(news.contItem());
		int a = news1.getTotalItem();
		news1.setTotalPage(a / news1.getMaxPageItem());
		req.setAttribute("model", news1);
		views="/views/admin/news/list.jsp";
		}
		else if(news1.getStyle().equals(SystemConstant.EDIT)) {
			req.setAttribute("allcategory", allcategory.findAll());
			if(news1.getId()!=null) {
				news1= news.findOne(news1.getId());
				req.setAttribute("model", news1);
			}else {
				
			}
			views="/views/admin/news/apinews.jsp";
		
		}
		RequestDispatcher c = req.getRequestDispatcher(views);
		c.forward(req, resp);
	}
}
