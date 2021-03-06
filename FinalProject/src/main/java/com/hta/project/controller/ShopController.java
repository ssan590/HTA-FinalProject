package com.hta.project.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hta.project.domain.Category;
import com.hta.project.domain.Member;
import com.hta.project.domain.OrderDetailList;
import com.hta.project.domain.Order_Detail;
import com.hta.project.domain.Order_Market;
import com.hta.project.domain.Product;
import com.hta.project.domain.Review;
import com.hta.project.service.MemberService;
import com.hta.project.service.ShopService;

@Controller
@RequestMapping(value="/shop")
public class ShopController {

    	private static final Logger logger
        = LoggerFactory.getLogger(ShopController.class);
    	
    	@Autowired
    	private ShopService shopService;
    	
    	@Autowired
    	private MemberService memberService;
    	
    	//http:localhost:8088/project/shop/shop_detail?product_code=000001
    	@RequestMapping(value = "/shop_detail", method = RequestMethod.GET)
    	public ModelAndView main(ModelAndView mv, String product_code, String pageName) {
    		Product product = shopService.getShopProductDetail(product_code);
    		mv.addObject("p", product);
    		mv.addObject("pageName", pageName);
    		mv.setViewName("hyun/shop/shop_detail");
    		return mv;
    	}
    	


    	
    	//?????? ?????? ?????? ?????? - ?????? ?????? 
    	@RequestMapping("/shopmain")
    	public String shopmain(Model model, String pageName,
    			@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="6", required=false) int limit) {
    		logger.info("Shop productList()");
    		
    		List<Product> productlist  = shopService.getProductList(page, limit);		
    		
    		int listcount = shopService.getProductListCount();
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		model.addAttribute("page", page);
    		model.addAttribute("maxpage", maxpage);
    		model.addAttribute("startpage", startpage);
    		model.addAttribute("endpage", endpage);
    		model.addAttribute("listcount", listcount);
    		model.addAttribute("productlist", productlist);
    		model.addAttribute("limit", limit);
    		model.addAttribute("pageName", pageName);
    		
    		return "hyun/shop/shop_main";
    	}
    	
    	//?????? ?????? 
    	@RequestMapping(value = "/shop_list", method = RequestMethod.GET)
    	public ModelAndView getProductsList(int category_code, ModelAndView mv,
    			@RequestParam(value="page", defaultValue="1", required = false) int page,
    			@RequestParam(value="limit", defaultValue="6", required=false) int limit,
    			String pageName) {
    		logger.info("get products list");
    		System.out.println(pageName);
    		List<Product> productlist = shopService.getCategoryProductList(page, limit, category_code);
    		
    		switch(category_code) {
    			case 100:
    				mv.setViewName("hyun/shop/shop_seed");
    			break;
    			case 200:
    				mv.setViewName("hyun/shop/shop_soil");
    			break;
    			case 300:
    				mv.setViewName("hyun/shop/shop_pesticide");
    			break;
    			case 400:
    				mv.setViewName("hyun/shop/shop_tools");
    			break;
    			case 500:
    				mv.setViewName("hyun/shop/shop_goods");
    			break;
    		}
    		
    		int listcount = shopService.getCategoryProductListCount(category_code);
    		
    		int maxpage = (listcount + limit - 1) / limit;
    		
    		int startpage = ((page - 1) / 10) * 10 + 1;
    		
    		int endpage = startpage + 10 - 1;
    		
    		if(endpage > maxpage) {
    			endpage = maxpage;
    		}
    		
    		mv.addObject("page", page);
    		mv.addObject("maxpage", maxpage);
    		mv.addObject("startpage", startpage);
    		mv.addObject("endpage", endpage);
    		mv.addObject("listcount", listcount);
    		mv.addObject("productlist", productlist);
    		mv.addObject("limit", limit);
    		mv.addObject("pageName", pageName);
    		
    		return mv;
    	}
    	
    	@PostMapping("/categoryList")
    	@ResponseBody
    	public Map<String, Object> categoryList() {
    		logger.info("Shop categoryList()");
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		List<Category> categoryList = shopService.getCategoryList();
    		
    		map.put("categoryList", categoryList);
    		
    		return map;
    	}
    	
    	@PostMapping("/productDetail")
    	@ResponseBody
    	public Map<String, Object> productDetail(String code, HttpSession session) {
    		logger.info("Shop productDetail()");
    		
    		Map<String, Object> map = new HashMap<String, Object>();
    		
    		Product product = shopService.getShopProductDetail(code);
    		String id = (String)session.getAttribute("id");
    		Member member = memberService.member_info(id);
    		
    		map.put("product", product);
    		map.put("member", member);
    		
    		return map;
    	}
    	
    	@GetMapping("/productDetailView")
    	public ModelAndView productDetail(String code, ModelAndView mv, 
    			   HttpServletRequest request) {
    		logger.info("Shop productDetailView()");
    		
    		Product product = shopService.getShopProductDetail(code);
    		
    		if(product==null) {
    			logger.info("???????????? ??????");
    			mv.setViewName("hyun/error/error");
    			mv.addObject("url", request.getRequestURL());
    			mv.addObject("message", "???????????? ???????????????.");
    		}else {
    			logger.info("???????????? ??????");
    			mv.setViewName("hyun/shop/productDetailView");
    			mv.addObject("product", product);
    		}
    		return mv;
    	}
    	
    	
    	
    	@GetMapping("/orderListView")
    	public String orderList() {
    		logger.info("Shop orderList()");
    		return "hyun/cart/orderListView";
    	}
    	
    	@GetMapping("/orderDetailView")
    	public String orderDetail() {
    		logger.info("Shop orderDetail()");
    		return "hyun/cart/orderDetailView";
    	}
    	
 //////////////////////////////////////////////1013
    	
    	// ?????? ?????? - ??????(??????) ??????
    	@ResponseBody   	
    	@RequestMapping(value = "/registReview", method = RequestMethod.POST)
    	public void registReview(Review review, HttpSession session) throws Exception {
    	 logger.info("regist review");
    	 
    	 String id = (String)session.getAttribute("id");
    	 Member member = memberService.member_info(id);
    	 review.setId(id);
    	 
    	 review.setMember_nick(member.getNick());
    	 
    	 shopService.registReview(review);
    	 
    	}
    	
    	
    	
    	// ?????? ??????(??????) ??????
    	@ResponseBody
    	@RequestMapping(value = "/reviewList", method = RequestMethod.GET)
    	public List<Review> getReviewList(@RequestParam("n") String product_code) throws Exception {
    	 logger.info("get review list");
    	   
    	 List<Review> review = shopService.reviewList(product_code);
    	 
    	 return review;
    	} 
    	
    	
    	
    	// ?????? ??????(??????) ??????
    	@ResponseBody
    	@RequestMapping(value = "/deleteReview", method = RequestMethod.POST)
    	public int getReviewList(Review review,  HttpSession session) throws Exception {
    		logger.info("post delete review");

    		// ???????????? ????????? ???????????? ?????? ??????
    		int result = 0;

    		Member member = (Member)session.getAttribute("member");  // ?????? ????????????  member ????????? ?????????
    		String userNick = shopService.nickCheck(review.getMember_nick());  // ??????(??????)??? ????????? ???????????? ???????????? ?????????

    		// ???????????? ????????????, ????????? ????????? ???????????? ??????
    		if(member.getNick().equals(userNick)) {

    			// ???????????? ???????????? ????????? ???????????? ?????????

    			review.setMember_nick(member.getId());  // reply??? userId ??????
    			shopService.deleteReview(review);  // ???????????? deleteReply ????????? ??????

    			// ????????? ??????
    			result = 1;
    		}

    		// ??????????????? ???????????? ?????? ????????? ????????????, result?????? 1?????????
    		// ?????????????????? ???????????? ?????? ????????? ?????????, result?????? 0
    		return result;	
    	}

    	// ?????? ??????(??????) ??????
    	@ResponseBody
    	@RequestMapping(value = "/modifyReview", method = RequestMethod.POST)
    	public int modifyReview(Review review, HttpSession session) throws Exception {
    		logger.info("modify review");

    		int result = 0;

    		Member member = (Member)session.getAttribute("member");
    		String userNick = shopService.idCheck(review.getMember_nick());  // ??????(??????)??? ????????? ???????????? ???????????? ?????????

    		if(member.getNick().equals(userNick)) {

    			review.setMember_nick(member.getId());  // reply??? userId ??????
    			shopService.deleteReview(review);  // ???????????? deleteReply ????????? ??????
    			result = 1;
    		}

    		return result;

    	}

    	// ??????
    	@RequestMapping(value = "/cartList", method = RequestMethod.POST)
    	public String order(HttpSession session, Order_Market ordermarket, Order_Detail orderDetail) throws Exception {
    		logger.info("order");

    		Member member = (Member)session.getAttribute("member");		
    		String userId = member.getId();

    		// ????????? ??????
    		Calendar cal = Calendar.getInstance();
    		int year = cal.get(Calendar.YEAR);  // ?????? ??????
    		String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);  // ??? ??????
    		String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));  // ??? ??????
    		String subNum = "";  // ?????? ????????? ????????? ????????? ??????

    		for(int i = 1; i <= 6; i ++) {  // 6??? ??????
    			subNum += (int)(Math.random() * 10);  // 0~9????????? ????????? ???????????? subNum??? ??????
    		}

    		String ordernum = ymd + "_" + subNum;  // [?????????]_[????????????] ??? ????????? ??????

    		ordermarket.setOrder_num(ordernum);
    		ordermarket.setOrder_name(userId);

    		shopService.orderInfo(ordermarket);

    		orderDetail.setId(userId);			
    		shopService.orderInfo_Details(orderDetail);

    		// ?????? ?????????, ?????? ?????? ???????????? ???????????? ????????????, ?????? ?????????
    		shopService.cartAllDelete(userId);

    		return "redirect:/shop/orderList";		
    	}

    	// ?????? ??????
    	@RequestMapping(value = "/orderList", method = RequestMethod.GET)
    	public void getOrderList(HttpSession session,  Order_Market ordermarket, Model model) throws Exception {
    		logger.info("get order list");

    		Member member = (Member)session.getAttribute("member");
    		String userId = member.getId();

    		ordermarket.setId(userId);

    		List<Order> orderList = shopService.orderList(ordermarket);

    		model.addAttribute("orderList", orderList);
    	}

    	// ?????? ?????? ??????
    	@RequestMapping(value = "/orderView", method = RequestMethod.GET)
    	public void getOrderList(HttpSession session,
    							@RequestParam("n") String orderId,
    							 Order_Market ordermarket, Model model) throws Exception {
    		logger.info("get order view");

    		Member member = (Member)session.getAttribute("member");
    		String userId = member.getId();

    		ordermarket.setId(userId);
    		ordermarket.setOrder_name(orderId);

    		List<OrderDetailList> orderView = shopService.orderView(ordermarket);

    		model.addAttribute("orderView", orderView);
    	}

}
