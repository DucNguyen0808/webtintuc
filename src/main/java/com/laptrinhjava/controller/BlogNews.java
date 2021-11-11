package com.laptrinhjava.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demojsp.model.Category;
import com.demojsp.model.News;
import com.laptrinhjava.service.ICatrgoryService;
import com.laptrinhjava.service.INewService;

@WebServlet(urlPatterns = { "/web-blog" })
public class BlogNews extends HttpServlet {
	@Inject
	INewService newss;
	@Inject
	ICatrgoryService allcategory;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long id = Long.parseLong(req.getParameter("id"));
		News newBlog = new News();
		newBlog = newss.findOne(id);
		List<News> b = new ArrayList<News>();
		b.add(newBlog);
		req.setAttribute("model", b);		
		Category cate = new Category();
		cate.setListResult(allcategory.findAll());
         req.setAttribute("category", cate);
         Long categoryId = Long.parseLong(req.getParameter("id"));
 		News new1 = new News();
 		new1.setListResult(newss.categoryById(categoryId));
 		req.setAttribute("news", new1);
		RequestDispatcher a = req.getRequestDispatcher("/views/web/blog.jsp");
		a.forward(req, resp);
	}
}
