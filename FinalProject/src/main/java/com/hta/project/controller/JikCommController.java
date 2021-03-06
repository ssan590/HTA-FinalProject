package com.hta.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hta.project.domain.Jik_Comm;
import com.hta.project.service.Jik_CommService;


@Controller
@RequestMapping(value="/jik_comm")
public class JikCommController {
		

	private static final Logger logger
	= LoggerFactory.getLogger(JikCommController.class);
	
	
	
		@Autowired
		private Jik_CommService jik_commService;
		
		@ResponseBody
		@PostMapping(value = "/list")
		public Map<String,Object> Jik_CommList(int jik_num, int state, int page,String jik_comm_secret){
			
			List<Jik_Comm> list = jik_commService.getJik_CommList(jik_num, page, state);
			int listcount = jik_commService.getListCount(jik_num);
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("list", list);
			map.put("listcount", listcount);
			logger.info("state = " + state);
			return map;
		}
		
		@PostMapping(value = "/add")
		public void Jik_CommAdd(Jik_Comm co, HttpServletResponse response)
				throws Exception{
			int ok = jik_commService.Jik_CommsInsert(co);
			response.getWriter().print(ok);
		}
		
		@RequestMapping(value = "/delete")
		public void Jik_CommDelete(int jik_comm_num, HttpServletResponse response)
				throws Exception{ // int num => Integer.parseInt(request.getParameter)
			
			int select = jik_commService.Jik_comm_ref_select(jik_comm_num);
			int select2 = jik_commService.Jik_comm_ref_select2(select);
			if(select2>=2) {
				int result2=jik_commService.Jik_CommsDelete2(jik_comm_num);
				response.getWriter().print(result2);
			}else {
				int result = jik_commService.Jik_CommsDelete(jik_comm_num);
				response.getWriter().print(result);
			}
			
			
		}
		
		@RequestMapping(value = "/update")
		public void Jik_CommUpdate(Jik_Comm co, HttpServletResponse response)
				throws Exception{
			int ok = jik_commService.Jik_CommsUpdate(co);
			response.getWriter().print(ok);
		}
		
		@RequestMapping("/reply")
		public void BoardReplyAction(Jik_Comm co, HttpServletResponse response)
				throws Exception{
			logger.info("jik_comm_re_ref = " + co.getJik_comm_re_ref());
				int result =jik_commService.Jik_CommsReply(co);
				
				response.getWriter().print(result);
			}
		
}
