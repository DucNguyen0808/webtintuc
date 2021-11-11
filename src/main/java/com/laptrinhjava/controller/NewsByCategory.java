package com.laptrinhjava.controller;

import java.io.IOException;

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

@WebServlet(urlPatterns = { "/categoryid" })
public class NewsByCategory extends HttpServlet {
	@Inject
	INewService newss;
	@Inject
	ICatrgoryService allcategory;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long categoryId = Long.parseLong(req.getParameter("id"));
		News new1 = new News();
		new1.setListResult(newss.categoryById(categoryId));
		req.setAttribute("news", new1);
		Category cate = new Category();
		cate.setListResult(allcategory.findAll());
		req.setAttribute("model", cate);
		RequestDispatcher b = req.getRequestDispatcher("/views/web/home.jsp");
		b.forward(req, resp);
	}

	
}
