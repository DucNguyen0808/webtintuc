package com.laptrinhjava.controller.admin.api;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demojsp.model.News;
import com.demojsp.model.UserModel;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.laptrinhjava.service.INewService;
import com.laptrinhjava.utils.HttpUtils;
import com.laptrinhjava.utils.SessionUtil;

@WebServlet(urlPatterns = { "/api-admin-new" })
public class NewAPI extends HttpServlet {
	@Inject INewService newss;
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        News news =  HttpUtils.of(req.getReader()).toModel(News.class); 
        newss.delete(news.getIds());
        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(resp.getOutputStream(), "{}");
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        News news =  HttpUtils.of(req.getReader()).toModel(News.class); 
//        news.setCreatedBy(((UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL")).getFullName());
        news =newss.save(news);
        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(resp.getOutputStream(), news);
	}
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	req.setCharacterEncoding("UTF-8");
	resp.setContentType("application/json");
	 News news =  HttpUtils.of(req.getReader()).toModel(News.class); 
//	 news.setMofdifiedBy( ((UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL")).getFullName());
	 news =newss.update(news);
	 ObjectMapper mapper = new ObjectMapper();
     mapper.writeValue(resp.getOutputStream(), news);
	}
}
