package com.sfr.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class StatisticsController {

	/**
	 * 통계관리
	 * @return
	 */
	@RequestMapping("/statistics.do")
	public String statistics(){
		
		return "admin/statistics/statistics.admin";
	}
	
	
}
