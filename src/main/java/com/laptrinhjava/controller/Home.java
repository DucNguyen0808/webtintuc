package com.laptrinhjava.controller;

import java.io.IOException;
import java.util.ResourceBundle;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demojsp.model.Category;
import com.demojsp.model.News;
import com.demojsp.model.UserModel;
import com.laptrinhjava.service.ICatrgoryService;
import com.laptrinhjava.service.INewService;
import com.laptrinhjava.service.IUserService;
import com.laptrinhjava.utils.FormUtil;
import com.laptrinhjava.utils.SessionUtil;

@WebServlet(urlPatterns = { "/trang-chu","/dang-nhap","/thoat" })
public class Home extends HttpServlet {
	@Inject
	private INewService newsbycateogy;
	@Inject
	private IUserService user;
	@Inject
	ICatrgoryService allcategory;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ResourceBundle mybl1 = ResourceBundle.getBundle("message");
		String action = req.getParameter("login");
		if(action==null) {
			News news1 = FormUtil.toModel(News.class, req);
			if (news1.getPage() == null)
				news1.setPage(1);
			if (news1.getMaxPageItem() == null)
				news1.setMaxPageItem(4);
			Integer offset = (news1.getPage() - 1) * news1.getMaxPageItem();
			news1.setListResult(newsbycateogy.findAllNews(offset, news1.getMaxPageItem(), "id", "desc"));
			news1.setTotalItem(newsbycateogy.contItem());
			news1.setTotalPage(news1.getTotalItem()/ news1.getMaxPageItem());
			req.setAttribute("news", news1);
		Category cate = new Category();
			cate.setListResult(allcategory.findAll());
			req.setAttribute("model", cate);
			RequestDispatcher b = req.getRequestDispatcher("/views/web/home.jsp");
			b.forward(req, resp);
		}else if(action!=null && action.equals("login")){
			String msg= req.getParameter("msg");
			String alert=req.getParameter("alert");
			if(msg!=null&&alert!=null) {
			req.setAttribute("alert", alert);
			req.setAttribute("msg", mybl1.getString(msg));
			}
			RequestDispatcher b = req.getRequestDispatcher("/views/login/login.jsp");
			b.forward(req, resp);
			
		}else if(action!=null && action.equals("thoat")){
			SessionUtil.getInstance().removeValue(req,"USERMODEL" );
			resp.sendRedirect(req.getContextPath()+"/trang-chu");
			
	}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		UserModel paraUser = FormUtil.toModel(UserModel.class, req);
		paraUser= user.findUserModel(paraUser.getUserName(), paraUser.getPassword(), 1);
		if(paraUser!=null)
		{
			SessionUtil.getInstance().putValue(req,"USERMODEL", paraUser);
			if(paraUser.getRole().getCode().equals("USER"))
			{
				resp.sendRedirect(req.getContextPath()+"/trang-chu");
				
			}else if(paraUser.getRole().getCode().equals("ADMIN"))
			{
				resp.sendRedirect(req.getContextPath()+"/admin-home");
			}
		}else
		{
			resp.sendRedirect(req.getContextPath()+"/dang-nhap?login=login&msg=false_login&alert=danger");
			
			
		}
		
		
	}
}