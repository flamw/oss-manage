package com.flame.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.flame.dao.DemoMapper;
import com.flame.model.DemoExample;

@Controller
@RequestMapping("/page")
public class TestController {
	@Autowired
	DemoMapper demoMapper;
    @RequestMapping("/a")
    public String b(Map<String, Object> model,HttpServletRequest request){
        model.put("msg", "张三2");     
//        model.put("msg2", demoMapper.selectByExample(new DemoExample()));  
        HttpSession session = request.getSession();
            session.setAttribute("msg2", demoMapper.selectByExample(new DemoExample()));
        return "index3";
    }
    @RequestMapping("/b")
    public String bc(Map<String, Object> model,HttpServletRequest request){
    	model.put("msg", "张三1");     
    	request.getSession().invalidate();
    	return "index3";
    }
    @RequestMapping("/c")
    public String bcc(Map<String, Object> model,HttpServletRequest request){
    	model.put("msg", "张三3");     
    	request.getSession().invalidate();
    	return "menu/main";
    }

}