package com.postboard.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RedirectController {

	@RequestMapping("/toRedirectPage")
	public String toRedirectPage(Model model,String msg,String url){
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		return "redirectPage";
	}
}
