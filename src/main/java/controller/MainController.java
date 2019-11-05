package controller;

//server.xml맨밑 Context위에 추가
/*
<Context docBase="C:\study\workspace_spring\finalproject\src\main\webapp\images" path="/nanaland" reloadable="true"></Context>
      
*/

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.json.simple.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

import dao.BoardDAO;
import dto.BoardDTO;
import dto.Board_ReplyDTO;
import dto.ChattingDTO;
import dto.MemberDTO;
import dto.NoticeDTO;
import dto.PageDTO;
import dto.PurchaseDTO;
import dto.ShoppingDTO;
import dto.Shopping_CartDTO;
import dto.Shopping_FileDTO;
import dto.Shopping_InfoDTO;
import dto.Shopping_LikeDTO;
import dto.Shopping_ReplyDTO;
import service.BoardService;
import service.ChattingService;
import service.CountService;
import service.DiscService;
import service.ManagerService;
import service.MemberService;
import service.ShoppingService;

//http://192.168.0.16:8090/myfinal/nanaland.do

//http://localhost:8090/myfinal/nanaland.do

@Controller
public class MainController {
	/* 선언부 */
	private MemberService memberservice;
	private BoardService board_service;
	private BoardDAO board_dao;
	private int currentPage;
	private PageDTO pdto;
	private BoardDTO boardDTO;
	private NoticeDTO noticeDTO;
	private DiscService discService;
	private ShoppingService shopService;
	private Shopping_LikeDTO likeDTO;
	private Shopping_CartDTO cartDTO;
	private PurchaseDTO purchaseDTO;
	// 상품 댓글 멀티파일 설정시 사용할 path
	private String path;
	private ChattingService chatService;
	private CountService countservice;
	private ManagerService managerservice;
	private String newpath;
	private String newpath2;

	public MainController() {

	}// end MainController()

	/* setter */
	public void setMemberservice(MemberService memberservice) {
		this.memberservice = memberservice;
	}

	public void setBoard_service(BoardService board_service) {
		this.board_service = board_service;
	}

	public void setBoard_dao(BoardDAO board_dao) {
		this.board_dao = board_dao;
	}

	public void setDiscService(DiscService discService) {
		this.discService = discService;
	}

	public void setShopService(ShoppingService shopService) {
		this.shopService = shopService;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public void setChatService(ChattingService chatService) {
		this.chatService = chatService;
	}

	public void setCountservice(CountService countservice) {
		this.countservice = countservice;
	}

	public void setManagerservice(ManagerService managerservice) {
		this.managerservice = managerservice;
	}

	public void setNewpath(String newpath) {
		this.newpath = newpath;
	}
	
	public void setNewpath2(String newpath2) {
	      this.newpath2 = newpath2;
	}

	/* 메인실행 */
	@RequestMapping("nanaland.do")
	public ModelAndView mainProcess(PageDTO pv) {
		ModelAndView mav = new ModelAndView();
		int totalRecord = board_service.notice_countProcess();

		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			mav.addObject("pv", pdto);
			mav.addObject("nList", board_service.main_noticeProcess(pdto));
		}
		mav.addObject("aList", shopService.shopListProcess("전체", "별점"));
		mav.setViewName("mainIndex");
		return mav;
	}// end Mainprocess

	// 서비스 이용 약관
	@RequestMapping("footerService.do")
	public String footerServiceForm() {
		return "footerService";
	}

	// 개인정보취급방침
	@RequestMapping("footerPolicy.do")
	public String footerPolicyForm() {
		return "footerPolicy";
	}

	// 서비스 이용 안내
	@RequestMapping("pageInfo.do")
	public String pageInfoForm() {
		return "pageInfo";
	}

	// 진표꺼시작//////////////////////////////////////////////////////////////////////////////

	// 카카오페이 시작화면
	@RequestMapping(value = "/kakaopay.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String kakaoPay(HttpSession session, int sellSum, int usePoint, String person, String phone,
			String address) {
		ArrayList<ShoppingDTO> cartinfoList = (ArrayList<ShoppingDTO>) shoppingCartView(session).getModel()
				.get("cartinfoList");
		int sellCount = (Integer) shoppingCartView(session).getModel().get("sellCount") - 1;

		if (sellCount == 0) {
			return "redirect:" + KakaoController.kakaoPayReady(sellSum, usePoint, cartinfoList.get(0).getShop_name(),
					person, phone, address);
		} else {
			return "redirect:" + KakaoController.kakaoPayReady(sellSum, usePoint,
					cartinfoList.get(0).getShop_name() + " 외 " + sellCount + "개", person, phone, address);
		}

	}// end kakaoPay()

	@RequestMapping(value = "/kakaoPaySuccess.do", method = { RequestMethod.GET })
	public ModelAndView kakaoPayPro(@RequestParam("pg_token") String pg_token, HttpSession session, String person,
			String phone, String address, int usePoint) {
		ModelAndView mav = new ModelAndView();
		KakaoController.kakaoPayInfo(pg_token);

		String id = (String) session.getAttribute("mem_id");
		int point = (int) ((Integer) (shoppingCartView(session).getModel().get("sellSum")) * 0.01);
		ArrayList<ShoppingDTO> cartinfoList = (ArrayList<ShoppingDTO>) shoppingCartView(session).getModel()
				.get("cartinfoList");
		int count = 0;

		purchaseDTO = new PurchaseDTO();
		purchaseDTO.setMem_id(id);
		purchaseDTO.setPurchase_name(person);
		purchaseDTO.setPurchase_phone(phone);
		purchaseDTO.setPurchase_oaddress(address.split("@")[0]);
		purchaseDTO.setPurchase_address(address.split("@")[1]);
		purchaseDTO.setPurchase_detailaddress(address.split("@")[2]);

		for (int i = 0; i < cartinfoList.size(); i++) {
			purchaseDTO.setShop_num(cartinfoList.get(i).getShop_num());
			count = cartinfoList.get(i).getCartList().getCart_buycount();
			purchaseDTO.setPurchase_cnt(count);
			purchaseDTO.setPurchase_totalprice(cartinfoList.get(i).getShop_price() * count);
			shopService.purchaseInsertProcess(purchaseDTO);
		}

		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMem_id(id);
		memberDTO.setMem_point(shopService.payMemInfoProcess(id).getMem_point() + point - usePoint);
		shopService.payCompleteProcess(memberDTO, id);
		mav.setViewName("kakaoPaySuccess");
		return mav;
	}// end kakaoPayPro()

	@RequestMapping("kakaoPayReady.do")
	public ModelAndView kakaoPayReady(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		String id = (String) session.getAttribute("mem_id");

		List<ShoppingDTO> slist = shopService.shopCartInfoProcess(id);
		int sellSum = 0;

		for (int i = 0; i < slist.size(); i++) {
			sellSum += (slist.get(i).getShop_price() * slist.get(i).getCartList().getCart_buycount());
		}

		// 세션값
		mav.addObject("memInfo", shopService.payMemInfoProcess(id));
		mav.addObject("sellSum", sellSum);
		mav.addObject("cartinfoList", slist);

		mav.setViewName("kakaoPayReady");
		return mav;
	}

	/* NaverLoginDTO */
	private NaverController naverLoginDTO;
	private String apiResult = null;

	/* NaverLoginDTO */
	@Autowired
	private void setNaverLoginDTO(NaverController naverLoginDTO) {
		this.naverLoginDTO = naverLoginDTO;
	}

	// 회원가입 화면이 나온다.
	@RequestMapping(value = "/memberjoinform.do", method = RequestMethod.GET)
	public ModelAndView memberJoinForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberjoinform");
		return mav;
	}// end memberJoinForm()

	// 회원가입정보를 다 입력하고 회원가입 버튼을 누른다.
	@RequestMapping(value = "/memberjoinpro.do", method = RequestMethod.POST)
	public ModelAndView memberJoinPro(MemberDTO dto) {
		ModelAndView mav = new ModelAndView();
		memberservice.memberJoinProcess(dto);
		mav.setViewName("memberloginform");
		return mav;
	}// end memberJoinPro()

	// 로그인 화면
	@RequestMapping(value = "/memberloginform.do", method = RequestMethod.GET)
	public ModelAndView memberLoginForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
		String naverAuthUrl = naverLoginDTO.getAuthorizationUrl(session);
		String kakaoUrl = KakaoController.getAuthorizationUrl(session);

		/* 생성한 인증 URL을 View로 전달 */
		mav.setViewName("memberloginform");
		// 네이버 로그인
		mav.addObject("naver_url", naverAuthUrl);
		// 카카오 로그인
		mav.addObject("kakao_url", kakaoUrl);

		return mav;
	}// end memberLoginForm()

	// 네이버 로그인 & 회원정보(이름) 가져오기
	@RequestMapping(value = "/naverlogin.do", produces = "application/json;charset=utf-8", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		ModelAndView mav = new ModelAndView();
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginDTO.getAccessToken(session, code, state);

		// 로그인한 사용자의 모든 정보가 JSON타입으로 저장되어 있음
		apiResult = naverLoginDTO.getUserProfile(oauthToken);

		// 내가 원하는 정보 (이름)만 JSON타입에서 String타입으로 바꿔 가져오기 위한 작업
		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonobj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonobj.get("response");
		String nname = (String) response.get("name");
		String nemail = (String) response.get("email");
		String ngender = (String) response.get("gender");
		String nbirthday = (String) response.get("birthday");
		String nage = (String) response.get("age");
		String nimage = (String) response.get("profile_image");

		// 로그인&아웃 하기위한 세션값 주기
		session.setAttribute("nname", nname);
		session.setAttribute("nemail", nemail);
		session.setAttribute("ngender", ngender);
		session.setAttribute("nbirthday", nbirthday);
		session.setAttribute("nage", nage);
		session.setAttribute("nimage", nimage);

		// 네이버 로그인 성공 페이지 View 호출
		mav.setViewName("main");
		return mav;
	}// end naverLogin()

	// 카카오 로그인 & 회원정보(이메일) 가져오기
	@RequestMapping(value = "/kakaologin.do", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView kakaoLogin(@RequestParam("code") String code, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 결과값을 node에 담아줌
		JsonNode node = KakaoController.getAccessToken(code);
		// accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token");
		// 사용자의 정보
		JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);

		String kemail = null;
		String kname = null;
		String kgender = null;
		String kbirthday = null;
		String kage = null;
		String kimage = null;

		// 유저정보 카카오에서 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");

		kemail = kakao_account.path("email").asText();
		kname = properties.path("nickname").asText();
		kimage = properties.path("profile_image").asText();
		kgender = kakao_account.path("gender").asText();
		kbirthday = kakao_account.path("birthday").asText();
		kage = kakao_account.path("age_range").asText();

		session.setAttribute("kemail", kemail);
		session.setAttribute("kname", kname);
		session.setAttribute("kimage", kimage);
		session.setAttribute("kgender", kgender);
		session.setAttribute("kbirthday", kbirthday);
		session.setAttribute("kage", kage);

		mav.setViewName("main");
		return mav;
	}// end kakaoLogin()

	// 마이 페이지 접속
	@RequestMapping("/mypage.do")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		String id = (String) session.getAttribute("mem_id");
		System.out.println("id ==>" + id);
		mav.addObject("aList", memberservice.id_point(id));
		mav.setViewName("mypageform");

		return mav;
	}// end myPage()

	// 마이페이지 내 게시글 가져오기
	@RequestMapping("/mypageboard.do")
	public @ResponseBody List<BoardDTO> my_board(HttpSession session) {
		String id = (String) session.getAttribute("mem_id");
		List<BoardDTO> list = memberservice.my_board(id);
		System.out.println(list.size());
		return list;
	}

	/* 판매 관리 */
	@RequestMapping("/member_purchase.do")
	public @ResponseBody List<PurchaseDTO> member_purchase(HttpSession session) {
		String id = (String) session.getAttribute("mem_id");
		System.out.println("id 잘뜨나요?" + id);
		List<PurchaseDTO> list = memberservice.PurchaseList(id);

		return list;
	}

	// 카카오 마이페이지
	@RequestMapping(value = "/kmypage.do", method = RequestMethod.GET)
	public ModelAndView kmyPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("kmypageform");
		return mav;
	}// end kmyPage()

	// 네이버 마이페이지
	@RequestMapping(value = "/nmypage.do", method = RequestMethod.GET)
	public ModelAndView nmyPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("nmypageform");
		return mav;
	}// end nmyPage()

	// 나나랜드 로그인 처리
	@RequestMapping(value = "/memberloginpro.do", method = RequestMethod.POST)
	public ModelAndView loginCheck(@ModelAttribute MemberDTO dto, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		boolean result = memberservice.loginCheckProcess(dto, session);
		if (result == true) { // 로그인성공
			// main페이지이동
			mav.setViewName("main");
			mav.addObject("msg", "success");
		} else {// 로그인 실패
			mav.setViewName("memberloginform");// 이 페이지로
			mav.addObject("msg", "아이디나 비밀번호를 확인하세요.");// msg를 보내준다, jsp에선 ${msg}' 로쓴다.
		}
		return mav;
	} // end loginCheck()

	// 세개의 로그아웃 방법이 모두가 들어있는 로그아웃메소드
	@RequestMapping(value = "/memberlogoutform.do", method = RequestMethod.GET)
	public ModelAndView logoutForm(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();

		// 글쓰기 권한제거를 위한 쿠키삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookies[i].setMaxAge(0); // 유효시간을 0으로 설정
				response.addCookie(cookies[i]); // 응답 헤더에 추가
			}
		}

		// 세션제거
		session.removeAttribute("mem_id");
		// 카카오 로그인 세션 제거
		session.removeAttribute("kemail");
		// 네이버 로그인 세션 제거
		// session.removeAttribute("nname");
		session.removeAttribute("nemail");

		mav.setViewName("mainIndex");
		return mav;
	}// end memberJoinForm()

	// 아이디 찾기 화면
	@RequestMapping(value = "/idsearch.do")
	public ModelAndView idSearchForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("idsearchform");
		return mav;
	}// end idSearchForm()

	// 아이디 찾기 처리
	@RequestMapping(value = "/idsearchpro.do", method = RequestMethod.POST)
	public ModelAndView idSearchPro(HttpServletResponse resp, MemberDTO dto, Model model) throws IOException {
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		String mem_id = memberservice.idSearchProcess(resp, dto);

		model.addAttribute("mem_id", memberservice.idSearchProcess(resp, dto));
		ModelAndView mav = new ModelAndView();

		if (mem_id == null) {
			out.println("<script>");
			out.println("alert('이름 또는 이메일을 확인하세요.');");
			out.println("history.go(-1);");
			out.println("</script>");
			return null;
		} else {
			mav.setViewName("idsearchresult");
		}

		return mav;
	}// end idSearchPro()

	// 아이디 중복확인
	@RequestMapping("/idcheck.do")
	@ResponseBody
	public Map<Object, Object> idCheck(@RequestBody String mem_id) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();

		count = memberservice.idCheckProcess(mem_id);
		map.put("cnt", count);

		return map;
	}// end idCheck()

	// 비번 찾기 화면
	@RequestMapping(value = "/pwsearch.do")
	public ModelAndView pwSearchForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pwsearchform");
		return mav;
	}// end pwSearchForm()

	// 비번 찾기 처리
	@RequestMapping(value = "/pwsearchpro.do", method = RequestMethod.POST)
	public ModelAndView pwSearchPro(HttpServletResponse resp, MemberDTO dto, Model model) throws IOException {
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		String mem_pw = memberservice.pwSearchProcess(resp, dto);

		model.addAttribute("mem_pw", memberservice.pwSearchProcess(resp, dto));
		ModelAndView mav = new ModelAndView();

		if (mem_pw == null) {
			out.println("<script>");
			out.println("alert('아이디 또는 생년월일을 확인해주세요.');");
			out.println("history.go(-1);");
			out.println("</script>");
			return null;
		} else
			mav.setViewName("pwsearchresult");

		return mav;
	}// end pwSearchPro()

	// 개인정보수정 화면
	@RequestMapping(value = "/membermodifyform.do", method = RequestMethod.GET)
	public ModelAndView memberUpdateForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberupdateform");
		return mav;
	}// end memberUpdateForm()

	// 개인정보수정 처리
	@RequestMapping(value = "/memberupdatepro.do", method = RequestMethod.POST)
	public ModelAndView memberUpdatePro(MemberDTO dto, HttpSession session, HttpServletResponse resp)
			throws IOException {
		ModelAndView mav = new ModelAndView();
		resp.setContentType("text/html;charset=utf-8");
		memberservice.memberUpdateProcess(dto);

		session.removeAttribute("mem_id");

		mav.setViewName("memberloginform");
		return mav;
	}// end memberUpdatePro()
		////////////////////////////////////////////////////////////////////////////////

	// 회원탈퇴 화면
	@RequestMapping(value = "/memberdelete.do", method = RequestMethod.GET)
	public ModelAndView memberDeleteForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberdeleteform");
		return mav;
	}// end memberDeleteForm()

	// 회원탈퇴 처리
	@RequestMapping(value = "/memberdeletepro.do", method = RequestMethod.POST)
	public ModelAndView memberDeletePro(@RequestParam String mem_id, @RequestParam String mem_pw, Model model,
			HttpSession session, HttpServletResponse resp) throws IOException {
		ModelAndView mav = new ModelAndView();
		resp.setContentType("text/html;charset=utf-8");
		boolean result = memberservice.checkPwProcess(mem_id, mem_pw);
		if (result == true) {// 비밀번호가 맞다면 삭제후 메인페이지 이동
			memberservice.memberDeleteProcess(mem_id);
			mav.setViewName("mainIndex");
			session.invalidate();
			return mav;
		} else {
			model.addAttribute("msg1", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("msg2", "비밀번호 일치시 탈퇴됩니다.");
			mav.setViewName("memberdeleteform");
			return mav;
		}
	}// end memberDeletePro()
		// 진표꺼끝/////////////////////////////////////////////////////////////////////////////////////////////////////////

	/* 정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱 */
	@RequestMapping("/nanaInfo.do")
	public ModelAndView nanaInfoForm() {

		ModelAndView mav = new ModelAndView();

		mav.addObject("memcnt", countservice.count_number());
		mav.addObject("likecnt", countservice.count_like());
		mav.addObject("productcnt", countservice.count_product());

		mav.setViewName("nanaInfo");
		return mav;
	}// end mapForm
	/* 정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱정욱 */

	/* 형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철 */
	/* 형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철 */
	/* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 */
	/* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 */
	/* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 *//* 게시글 */

	/* 게시글 목록 */
	@RequestMapping("/list.do")
	public ModelAndView listMethod(PageDTO pv) {
		ModelAndView mav = new ModelAndView();
		int totalRecord = board_service.countProcess();

		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			mav.addObject("pv", pdto);
			mav.addObject("aList", board_service.listProcess(pdto));
		}
		mav.setViewName("list");
		return mav;
	}// end listMethod()

	/* 게시글 내용 */
	@RequestMapping("/view.do")
	public ModelAndView viewMethod(int currentPage, int num) {
		ModelAndView mav = new ModelAndView();
		Board_ReplyDTO dto = new Board_ReplyDTO();
		System.out.println("num==================>" + num);

		/* dto에 board_num 저장 */
		dto.setBoard_num(num);

		/* board_num을 활용해 댓글 작성, 출력 ===== list에 저장 */
		List<Board_ReplyDTO> list = board_service.replyListProcess(dto);
		BoardDTO bdto = new BoardDTO();
		bdto.setReplyList(list);

		mav.addObject("boardDTO", bdto);
		mav.addObject("dto", board_service.contentProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("view");
		return mav;
	}// end viewMethod()

	/* 게시글 작성 페이지 */
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public ModelAndView writerMethod(PageDTO pv, BoardDTO dto) {
		ModelAndView mav = new ModelAndView();
		/* 답변글인 경우 */
		if (pv.getCurrentPage() != 0) {
			mav.addObject("currentPage", pv.getCurrentPage());
			mav.addObject("dto", dto);
		}
		mav.setViewName("write");
		return mav;
	}// end writerMethod()

	/* 게시글 작성 */
	@RequestMapping(value = "/write.do", method = RequestMethod.POST)
	public String writeProMethod(BoardDTO dto, HttpServletRequest request) {
		MultipartFile file = dto.getFilename();
		/* 첨부파일 존재 */
		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			/* 중복 파일명을 처리하기 위해 난수 발생 */
			UUID random = UUID.randomUUID();

			/* 반영구적으로 보관하기 위한 주소 */
			String root = request.getSession().getServletContext().getRealPath("/");
			// == root + "temp/"
			String saveDirectory = root + "temp" + File.separator;

			File fe = new File(saveDirectory);

			if (!fe.exists())
				fe.mkdir();

			File ff = new File(saveDirectory, random + "_" + fileName);

			try {
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
			} catch (IOException e) {
				e.printStackTrace();
			}
			dto.setBoard_file(random + "_" + fileName);
		}

		/* 답변글이면 */
		if (dto.getBoard_ref() != 0) {
			board_service.reStepProcess(dto);
		} else {
			/* 제목글이면 */
			board_service.insertProcess(dto);
		}
		return "redirect:/list.do";
	}// end writeProMethod()

	/* 게시글 수정 페이지 */
	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public ModelAndView updateMethod(int num, int currentPage) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", board_service.updateSelectProcess(num));
		mav.addObject("currentPage", currentPage);
		/* currentPage == 수정 후 돌아올 페이지를 가져오기 위해 필요함. */
		mav.setViewName("update");
		return mav;
	}// end updateMethod()

	/* 게시글 수정 */
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public ModelAndView updateProc(BoardDTO dto, int currentPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		board_service.updateProcess(dto, request);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("redirect:/list.do");
		return mav;
	}// end updateProc()

	/* 게시글 삭제 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public ModelAndView deleteMethod(int num, int currentPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		board_service.deleteProcess(num, request);

		PageDTO pv = new PageDTO(currentPage, board_service.countProcess());
		if (pv.getTotalPage() <= currentPage)
			mav.addObject("currentPage", pv.getTotalPage());
		else {
			mav.addObject("currentPage", currentPage);
		}
		mav.setViewName("redirect:/list.do");
		return mav;
	}// end deleteMethod()

	/* 답변글 삭제 */
	@RequestMapping(value = "/delete2.do", method = RequestMethod.GET)
	public ModelAndView deleteMethod2(int num, int currentPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		board_service.deleteProcess2(num, request);

		PageDTO pv = new PageDTO(currentPage, board_service.countProcess());
		if (pv.getTotalPage() <= currentPage)
			mav.addObject("currentPage", pv.getTotalPage());
		else {
			mav.addObject("currentPage", currentPage);
		}
		mav.setViewName("redirect:/list.do");
		return mav;
	}// end deleteMethod()

	/* 파일 다운로드 */
	@RequestMapping("/contentdownload.do")
	public ModelAndView downMethod(int num) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("num", num);
		mav.setViewName("download");
		return mav;
	}// end downMethod

	/* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 */
	/* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 */
	/* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 *//* 댓글 */

	@RequestMapping(value = "/boardList.do")
	public ModelAndView boardListPage() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", board_service.boardListProcess());
		mav.setViewName("list");
		return mav;
	}

	@RequestMapping(value = "/boardView.do")
	public ModelAndView boardViewPage(int bno) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("boardDTO", board_service.boardViewProcess(bno));
		mav.setViewName("view");
		return mav;
	}

	@RequestMapping(value = "/replyInsertList.do")
	public @ResponseBody List<Board_ReplyDTO> replyListPage(Board_ReplyDTO rdto, HttpServletRequest request) {
		return board_service.replyListProcess(rdto);
	}

	@RequestMapping(value = "/replyDelete.do")
	public @ResponseBody List<Board_ReplyDTO> replyDeleteListPage(Board_ReplyDTO rdto) {
		return board_service.replyDeleteProcess(rdto);
	}

	@RequestMapping(value = "/replyUpdateList.do")
	public @ResponseBody List<Board_ReplyDTO> replyUpdateListPage(Board_ReplyDTO rdto) {
		board_service.replyUpdateProcess(rdto);
		List<Board_ReplyDTO> list = board_service.replyListProcess(rdto);
		return list;
	}

	/* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 */
	/* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 */
	/* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 *//* 카테고리 */

	/* 카테고리별 list */
	@RequestMapping(value = "/categoryList.do")
	public ModelAndView categoryList(BoardDTO bdto, PageDTO pv) {
		ModelAndView mav = new ModelAndView();
		int totalRecord = board_service.category_countProcess(bdto);
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			boardDTO = new BoardDTO();

			mav.addObject("pv", pdto);
			mav.addObject("board", boardDTO);
			mav.addObject("aList", board_service.category_listProcess(bdto, pdto));
		}
		mav.setViewName("list");
		return mav;
	}// end categoryList()

	/* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 */
	/* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 */
	/* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 *//* 공지사항 */

	/* 관리자 공지사항 */
	@RequestMapping("/notice.do")
	public ModelAndView notice(PageDTO pv) {
		ModelAndView mav = new ModelAndView();
		int totalRecord = board_service.notice_countProcess();

		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			mav.addObject("pv", pdto);
			mav.addObject("aList", board_service.notice_listProcess(pdto));
		}
		mav.setViewName("notice");
		return mav;
	}

	/* 게시글 내용 */
	@RequestMapping("/notice_view.do")
	public ModelAndView notice_viewMethod(int currentPage, int num) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", board_service.notice_contentProcess(num));
		mav.addObject("currentPage", currentPage);
		mav.setViewName("notice_view");
		return mav;
	}// end viewMethod()

	/* 게시글 작성 페이지 */
	@RequestMapping(value = "/notice_write.do", method = RequestMethod.GET)
	public ModelAndView notice_writerMethod(PageDTO pv, NoticeDTO dto) {
		ModelAndView mav = new ModelAndView();
		/* 답변글인 경우 */
		if (pv.getCurrentPage() != 0) {
			mav.addObject("currentPage", pv.getCurrentPage());
			mav.addObject("dto", dto);
		}
		mav.setViewName("notice_write");
		return mav;
	}// end writerMethod()

	/* 게시글 작성 */
	@RequestMapping(value = "/notice_write.do", method = RequestMethod.POST)
	public String notice_writeProMethod(NoticeDTO dto, HttpServletRequest request) {
		MultipartFile file = dto.getFilename();
		/* 첨부파일 존재 */
		if (!file.isEmpty()) {
			String fileName = file.getOriginalFilename();
			/* 중복 파일명을 처리하기 위해 난수 발생 */
			UUID random = UUID.randomUUID();

			/* 반영구적으로 보관하기 위한 주소 */
			String root = request.getSession().getServletContext().getRealPath("/");
			// == root + "temp/"
			String saveDirectory = root + "temp" + File.separator;

			File fe = new File(saveDirectory);

			if (!fe.exists())
				fe.mkdir();

			File ff = new File(saveDirectory, random + "_" + fileName);

			try {
				FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
			} catch (IOException e) {
				e.printStackTrace();
			}
			dto.setNotice_file(random + "_" + fileName);
		}

		board_service.notice_insertProcess(dto);

		return "redirect:/notice.do";
	}// end writeProMethod()

	/* 게시글 수정 페이지 */
	@RequestMapping(value = "/notice_update.do", method = RequestMethod.GET)
	public ModelAndView notice_updateMethod(int num, int currentPage) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("dto", board_service.notice_updateSelectProcess(num));
		mav.addObject("currentPage", currentPage);
		/* currentPage == 수정 후 돌아올 페이지를 가져오기 위해 필요함. */
		mav.setViewName("notice_update");
		return mav;
	}// end updateMethod()

	/* 게시글 수정 */
	@RequestMapping(value = "/notice_update.do", method = RequestMethod.POST)
	public ModelAndView notice_updateProc(NoticeDTO dto, int currentPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		board_service.notice_updateProcess(dto, request);
		mav.addObject("currentPage", currentPage);
		mav.setViewName("redirect:/notice.do");
		return mav;
	}// end updateProc()

	/* 게시글 삭제 */
	@RequestMapping(value = "/notice_delete.do", method = RequestMethod.GET)
	public ModelAndView notice_deleteMethod(int num, int currentPage, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		board_service.notice_deleteProcess(num, request);

		PageDTO pv = new PageDTO(currentPage, board_service.notice_countProcess());
		if (pv.getTotalPage() <= currentPage)
			mav.addObject("currentPage", pv.getTotalPage());
		else {
			mav.addObject("currentPage", currentPage);
		}
		mav.setViewName("redirect:/notice.do");
		return mav;
	}// end deleteMethod()

	/* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 */
	/* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 */
	/* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 *//* 검색 */

	@RequestMapping("/board_search.do")
	public @ResponseBody ModelAndView search(BoardDTO bdto, PageDTO pv) {
		ModelAndView mav = new ModelAndView();

		int totalRecord = board_service.search_countProcess(bdto);
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			boardDTO = new BoardDTO();

			mav.addObject("pv", pdto);
			mav.addObject("board", boardDTO);
			mav.addObject("aList", board_service.board_searchProcess(bdto, pdto));
		}
		mav.setViewName("list");
		return mav;
	}// end search()

	@RequestMapping("/notice_search.do")
	public @ResponseBody ModelAndView noticesearch(NoticeDTO ndto, PageDTO pv) {
		ModelAndView mav = new ModelAndView();
		int totalRecord = board_service.noticesearch_countProcess(ndto);
		System.out.println("컨트롤러 =======>" + ndto.getNotice_writer());
		System.out.println("컨트롤러 =======>" + ndto.getNotice_title());
		if (totalRecord >= 1) {
			if (pv.getCurrentPage() == 0) {
				currentPage = 1;
			} else {
				currentPage = pv.getCurrentPage();
			}
			pdto = new PageDTO(currentPage, totalRecord);
			noticeDTO = new NoticeDTO();

			mav.addObject("pv", pdto);
			mav.addObject("notice", noticeDTO);
			mav.addObject("aList", board_service.notice_searchProcess(ndto, pdto));
		}
		mav.setViewName("notice");
		return mav;
	}// end search()

	/* 형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철 */
	/* 형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철 */

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
	/* 재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민 */
	// 취미 분석하기를 눌렀을때 넘어갈페이지
	@RequestMapping("/discStart.do")
	public String discStartForm() {
		return "discStart";
	}// end discForm()

	// 취미 테스트 시작하기를 눌렀을때 넘어갈페이지
	@RequestMapping("/discTest.do")
	public ModelAndView discTestForm() {
		ModelAndView mav = new ModelAndView();

		// 확인용
		/*
		 * List<DiscDTO> alist = discService.discListMethod(); for(DiscDTO dto : alist)
		 * { System.out.printf("%d %s %s %s %s\n",dto.getDisc_num(), dto.getDisc_one(),
		 * dto.getDisc_two(), dto.getDisc_three(), dto.getDisc_four()); }
		 */

		mav.addObject("discList", discService.discListMethod());
		mav.setViewName("discTest");
		return mav;
	}// end discForm()

	// 회원정보 취미 입력
	@RequestMapping("/discInput.do")
	public void discInput(String discResult, HttpSession session) {
		MemberDTO dto = new MemberDTO();
		String id = (String) session.getAttribute("mem_id");

		System.out.println(discResult);

		dto.setMem_id(id);
		if (discResult.equals("d"))
			dto.setMem_hobby("주도형");
		else if (discResult.equals("i"))
			dto.setMem_hobby("사교형");
		else if (discResult.equals("s"))
			dto.setMem_hobby("안정형");
		else if (discResult.equals("c"))
			dto.setMem_hobby("신중형");

		memberservice.hobbyInsertProcess(dto);
	}
	/////////////////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////// shopping
	/////////////////////////////////// controller///////////////////////////////////
	@RequestMapping("shoppingMain.do")
	public ModelAndView shoppingView() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("aList", shopService.shopListProcess("전체", "등록"));
		mav.setViewName("shoppingMain");
		return mav;
	}

	@RequestMapping("shoppingList.do")
	public @ResponseBody List<ShoppingDTO> shoppingList(String category, String selectOption) {
		return shopService.shopListProcess(category, selectOption);
	}

	@RequestMapping("shoppingView.do")
	public ModelAndView shoppingView(HttpSession session, int shop_num, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		String id = (String) session.getAttribute("mem_id");

		likeDTO = new Shopping_LikeDTO();
		// 아이디값에 세션에 저장된 아이디값 입력
		likeDTO.setMem_id(id);
		likeDTO.setShop_num(shop_num);

		String root = request.getSession().getServletContext().getRealPath("/") + "images" + File.separator
				+ shopService.shopInfoProcess(shop_num).getShop_code() + File.separator
				+ shopService.shopInfoProcess(shop_num).getShop_name() + " "
				+ shopService.shopInfoProcess(shop_num).getShop_price();

		File fe = new File(root);
		File ff = new File(root + File.separator + "Thumbs.db");

		if (ff.exists()) {
			mav.addObject("picCount", fe.listFiles().length - 2);
		} else {
			mav.addObject("picCount", fe.listFiles().length - 1);
		}

		if (id != null) {
			if (shopService.shopLikeChkProcess(likeDTO).size() == 1) {
				mav.addObject("likeChk", true);
			} else {
				mav.addObject("likeChk", false);
			}
		} else {
			mav.addObject("likeChk", false);
		}

		////////////////////////////////////////////////////////////////////////////////
		// 추가
		// 회원이 해당 상품의 상품을 구매완료한 상태인지 (상품후기 작성 권한을 주기 위해)
		// 상품번호(shop_num)와 회원 아이디(id) 값을 넘겨줘서 배송상태 = purchase_condition 값을 받아와서 모델에 담아
		//////////////////////////////////////////////////////////////////////////////// 넘겨줌
		PurchaseDTO pdto = new PurchaseDTO();
	      pdto.setMem_id(id);
	      pdto.setShop_num(shop_num);

	      if (id != null) {
	         // 확인용
	         String result = " ";
	         List<Integer> list = shopService.purConditionProcess(pdto);
	         for (int i = 0; i < list.size(); i++) {
	            System.out.println("list.get(i) : " + list.get(i));
	            if(list.get(i) == 3) {
	               result = "true";
	            }
	         }
	         mav.addObject("purCondition", result);
	      } else {
	         mav.addObject("purCondition", "false");
	      }
		////////////////////////////////////////////////////////////////////////////////

		System.out.println(shopService.shopInfoProcess(shop_num).getShop_starcnt());

		mav.addObject("shopInfo", shopService.shopInfoProcess(shop_num));
		mav.addObject("point", (Integer) (shopService.shopInfoProcess(shop_num).getShop_price() / 100));
		mav.setViewName("shoppingView");
		return mav;
	}

	@RequestMapping("shoppingLike.do")
	public void shoppingLike(HttpSession session, String like, int shop_num) {
		String id = (String) session.getAttribute("mem_id");

		likeDTO = new Shopping_LikeDTO();
		likeDTO.setMem_id(id);
		likeDTO.setShop_num(shop_num);

		if (like.equals("on")) {
			shopService.shopLikeOnProcess(likeDTO);
		} else if (like.equals("off")) {
			shopService.shopLikeOffProcess(likeDTO);
		}
	}

	@RequestMapping("shoppingCart.do")
	public ModelAndView shoppingCartView(HttpSession session) {
		ModelAndView mav = new ModelAndView();

		String id = (String) session.getAttribute("mem_id");

		List<ShoppingDTO> slist = shopService.shopCartInfoProcess(id);
		int sellCount = slist.size();
		int sellSum = 0;
		String stockpro = "";
		String paypro = "";

		for (int i = 0; i < slist.size(); i++) {
			sellSum += (slist.get(i).getShop_price() * slist.get(i).getCartList().getCart_buycount());
			if (i == slist.size() - 1) {
				stockpro = stockpro + slist.get(i).getShop_stock();
				paypro = paypro + slist.get(i).getCartList().getCart_buycount();
			} else {
				stockpro = stockpro + slist.get(i).getShop_stock() + "*";
				paypro = paypro + slist.get(i).getCartList().getCart_buycount() + "*";
			}
		}

		// 세션값
		mav.addObject("sellCount", sellCount);
		mav.addObject("sellSum", sellSum);
		mav.addObject("sellPoint", (int) (sellSum * 0.01));
		mav.addObject("cartinfoList", slist);
		mav.addObject("size", slist.size());
		mav.addObject("stockpro", stockpro);
		mav.addObject("paypro", paypro);
		mav.setViewName("shoppingCart");
		return mav;
	}

	@RequestMapping("shoppingCartPro.do")
	public void shoppingCartProcess(HttpSession session, int shop_num, int cart_buycount) {
		cartDTO = new Shopping_CartDTO();

		String id = (String) session.getAttribute("mem_id");

		cartDTO.setMem_id(id);
		cartDTO.setShop_num(shop_num);
		cartDTO.setCart_buycount(cart_buycount);

		shopService.shopCartInProcess(cartDTO);
	}

	@RequestMapping("shoppingCartDel.do")
	public @ResponseBody List<ShoppingDTO> shoppingCartDelete(HttpSession session, int shop_num) {
		String id = (String) session.getAttribute("mem_id");

		cartDTO = new Shopping_CartDTO();
		cartDTO.setMem_id(id);
		cartDTO.setShop_num(shop_num);

		return shopService.shopCartOutProcess(cartDTO);
	}

	@RequestMapping("shoppingCartPlusMinus.do")
	public @ResponseBody List<ShoppingDTO> shoppingPlusMinus(HttpSession session, int shop_num, int cart_buycount) {
		String id = (String) session.getAttribute("mem_id");

		cartDTO = new Shopping_CartDTO();
		cartDTO.setMem_id(id);
		cartDTO.setShop_num(shop_num);
		cartDTO.setCart_buycount(cart_buycount);

		return shopService.shopCartUpdateProcess(cartDTO);
	}

	/////////////////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////////////////////////////////////////////////////////////

	// 상품 후기(댓글)작성 완료를 눌렀을때
	@RequestMapping(value = "/commWrite.do")
	public @ResponseBody List<Shopping_ReplyDTO> shoppingCommInsert(Shopping_ReplyDTO rdto,
			HttpServletRequest request) {
		System.out.println("*******************shoppingCommInsert Method In*************"); // 확인용

		System.out.println("rdto.getShop_num() : " + rdto.getShop_num());
		System.out.println("rdto.getSreply_writer() : " + rdto.getSreply_writer());
		System.out.println("rdto.getSreply_content() : " + rdto.getSreply_content());
		System.out.println("rdto.getSreply_star() : " + rdto.getSreply_star());
		System.out.println("fdto.getFilename() : " + rdto.getFilename());

		// 넘어온 파라미터 값에서 filename에 있는 객체에 대한 정보를 받아옴 => MultipartFile
		// 대신 한개가 아닌 여러개를 처리해야 하기 때문에 list로 받아와서 처리해주어야 한다.
		List<MultipartFile> files = rdto.getFilename();
		List<Shopping_FileDTO> flist = new ArrayList<Shopping_FileDTO>();

		// 첨부파일 읽어오는 과정 (여러개이기 떄문에 for문을 이용해서 처리해야 함)
		// 파일명받기, 중복제거를 위한 난수발생, 경로지정, 첨부파일 서버에 저장, dto에 저장
		if (files != null) {
			for (MultipartFile file : files) {
				// 원래 파일명 받아옴
				String fileName = file.getOriginalFilename();
				System.out.println("fileName : " + fileName);

				// 중복 제거를 하기 위해 난수를 발생시켜서 파일명을 테이블에 저장해줌
				UUID random = UUID.randomUUID();

				String saveDirectory = path; // Controller Bean 설정할때 path값 받아올 것임

				// temp라는 폴더가 없는 경우 만들어라
				File fe = new File(saveDirectory);
				if (!fe.exists()) {
					fe.mkdir();
				}

				// 중복되지 않도록 fileName과 발생시킨 난수를 합쳐줌
				File ff = new File(saveDirectory, random + "_" + fileName);

				// 파일 안에 있는 내용 읽어와서 서버에 저장시켜줌
				try {
					FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));

				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				Shopping_FileDTO fdto = new Shopping_FileDTO();
				fdto.setShop_num(rdto.getShop_num());
				fdto.setShop_file(random + "_" + fileName);
				fdto.setSreply_num(rdto.getSreply_num());
				flist.add(fdto);
				rdto.setmFileList(flist);

			} // end for문(멀티파일 처리 끝)

		} // end if문

		return shopService.replyListProcess(rdto);

	}// end shoppingCommInsert()

	// 상품 후기 댓글 삭제 버튼을 눌렀을때
	@RequestMapping(value = "/sreplyDelete.do")
	public @ResponseBody List<Shopping_ReplyDTO> sreplyDeleteProcess(int shop_num, int sreply_num) {
		System.out.println("*******************sreplyDeleteProcess Method In*************"); // 확인용
		/*
		 * System.out.println("shop_num : " + rdto.getShop_num());
		 * System.out.println("sreply_num : " + rdto.getSreply_num());
		 */
		System.out.println("shop_num : " + shop_num);
		System.out.println("sreply_num : " + sreply_num);
		System.out.println("*************************************************************");

		// return shopService.replyDeleteProcess(URLEncoder.encode(rdto,"UTF-8"));
		return shopService.replyDeleteProcess(shop_num, sreply_num);
	}// end sreplyDeleteProcess()

	// 상품 후기 댓글 수정할때 선택된 이미지 값들만 가지고 오기 위해
	@RequestMapping(value = "/sreplyUpdateFile.do", produces = "application/json; charset=utf-8")
	public @ResponseBody List<Shopping_FileDTO> sreplyUpdateFileProcess(int sreply_num) {
		System.out.println("*******************sreplyUpdateFileProcess Method In*************"); // 확인용

		List<Shopping_FileDTO> test = shopService.replyUpdateFileProcess(sreply_num);
		for (Shopping_FileDTO fdto : test) {
			System.out.println("수정모달에 띄워줄 값 가지고 오는 것 : " + fdto.getShop_file());
		}

		return shopService.replyUpdateFileProcess(sreply_num);
	}// end sreplyUpdateFileProcess()

	// 상품 후기 댓글 수정 모달에서 수정버튼을 눌렀을때
	   @RequestMapping(value = "/commUpdate.do")
	   public @ResponseBody List<Shopping_ReplyDTO> sreplyUpdateProcess(Shopping_ReplyDTO rdto,
	         HttpServletRequest request) {
	      System.out.println("*******************sreplyUpdateProcess Method In*************"); // 확인용
	      System.out.println("rdto.getShop_num() : " + rdto.getShop_num());
	      System.out.println("rdto.getSreply_writer() : " + rdto.getSreply_writer());
	      System.out.println("rdto.getSreply_content() : " + rdto.getSreply_content());
	      System.out.println("rdto.getSreply_star() : " + rdto.getSreply_star());

	      List<Shopping_FileDTO> oflist = new ArrayList<Shopping_FileDTO>();
	      
	      //수정
	      for (int i = 0; i < rdto.getOldFilename().size(); i++) {
	            System.out.println("rdto.getOldFilename() : " + rdto.getOldFilename().get(i)); // 확인용

	            Shopping_FileDTO ofdto = new Shopping_FileDTO();
	            ofdto.setShop_num(rdto.getShop_num());
	            ofdto.setShop_file(rdto.getOldFilename().get(i));
	            ofdto.setSreply_num(rdto.getSreply_num());
	            oflist.add(ofdto);
	            rdto.setOldFileList(oflist);
	      }
	            
	      // 수정하기 위해 가지고 온 파일들을 담는 과정 필요
	      // 넘어온 파라미터 값에서 filename에 있는 객체에 대한 정보를 받아옴 => MultipartFile
	      // 대신 한개가 아닌 여러개를 처리해야 하기 때문에 list로 받아와서 처리해주어야 한다.
	      List<MultipartFile> files = rdto.getFilename();
	      List<Shopping_FileDTO> flist = new ArrayList<Shopping_FileDTO>();

	      // 첨부파일 읽어오는 과정 (여러개이기 떄문에 for문을 이용해서 처리해야 함)
	      // 파일명받기, 중복제거를 위한 난수발생, 경로지정, 첨부파일 서버에 저장, dto에 저장
	      if (files != null) {
	         for (MultipartFile file : files) {
	            // 원래 파일명 받아옴
	            String fileName = file.getOriginalFilename();
	            System.out.println("fileName : " + fileName);

	            // 중복 제거를 하기 위해 난수를 발생시켜서 파일명을 테이블에 저장해줌
	            UUID random = UUID.randomUUID();

	            String saveDirectory = path; // Controller Bean 설정할때 path값 받아올 것임

	            // temp라는 폴더가 없는 경우 만들어라
	            File fe = new File(saveDirectory);
	            if (!fe.exists()) {
	               fe.mkdir();
	            }

	            // 중복되지 않도록 fileName과 발생시킨 난수를 합쳐줌
	            File ff = new File(saveDirectory, random + "_" + fileName);

	            // 파일 안에 있는 내용 읽어와서 서버에 저장시켜줌
	            try {
	               FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));

	            } catch (FileNotFoundException e) {
	               e.printStackTrace();
	            } catch (IOException e) {
	               e.printStackTrace();
	            }

	            Shopping_FileDTO fdto = new Shopping_FileDTO();
	            fdto.setShop_num(rdto.getShop_num());
	            fdto.setShop_file(random + "_" + fileName);
	            fdto.setSreply_num(rdto.getSreply_num());
	            flist.add(fdto);
	            rdto.setmFileList(flist);

	         } // end for문(멀티파일 처리 끝)

	      } // end if문


	      System.out.println("***************service 호출한다!***************");
	      return shopService.replyUpdateProcess(rdto);

	   }// end sreplyUpdateProcess()

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
	/* 재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민재민 */

	/* 형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철 */
	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */

	/* 판매 관리 */
	@RequestMapping("/marketing.do")
	public ModelAndView marketing() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("list", managerservice.month());
		mav.addObject("aList", managerservice.PurchaseList());
		mav.setViewName("marketing");

		return mav;
	}

	/* 판매 완료 관리 */
	@RequestMapping("/complete.do")
	public ModelAndView marketingComplete() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("list", managerservice.month());
		mav.addObject("aList", managerservice.completeList());
		mav.setViewName("marketingComplete");

		return mav;
	}

	/* 배송 상태 업데이트 */
	@RequestMapping(value = "/purchase_update.do", method = RequestMethod.GET)
	public @ResponseBody List<PurchaseDTO> purchase_update(PurchaseDTO dto) {
		managerservice.updateList(dto);
		List<PurchaseDTO> list = managerservice.PurchaseList();

		return list;
	}

	/* 재고 관리 */
	@RequestMapping("/stock.do")
	public ModelAndView stock() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("aList", managerservice.stock_list());
		mav.setViewName("stock");
		return mav;
	}

	/* 입고 관리 */
	@RequestMapping("/stock_update.do")
	public @ResponseBody List<ShoppingDTO> stock_update(String snArr, String stArr) {
		System.out.println("controller===================================");
		System.out.println("받아온 상품번호 값 =====>" + snArr);
		System.out.println("해당 상품의 입력 값 =====>" + stArr);

		/* 상품 입력 값 나누기 */
		String[] str = stArr.split(",");
		/* 상품 번호 값 나누기 */
		String[] sn = snArr.split(",");
		int cnt = 0;

		List<ShoppingDTO> alist = new ArrayList<ShoppingDTO>();
		ShoppingDTO dto = new ShoppingDTO();
		for (String zz : str) {
			/* sn 배열 값 index 1씩 증가 시키면서 shop_num 값에 담기 */
			dto.setShop_num(Integer.parseInt(sn[cnt]));
			/* str 배열 for each문 통해 반복해서 값 넣기 */
			dto.setShop_stock(Integer.parseInt(zz));
			managerservice.stock_update(dto);
			cnt++;
		}
		return managerservice.stock_list();
	}

	/* 상품 관리 */
	@RequestMapping(value = "/product.do")
	public ModelAndView productForm() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("sList", managerservice.shoppingInfoListMethod());
		mav.setViewName("product");
		return mav;
	}

	/* 판매 중지 */
	@RequestMapping(value = "/productStop.do")
	public @ResponseBody List<Shopping_InfoDTO> productStopProcess(int shop_num) {
		return managerservice.shoppingStopMethod(shop_num);
	}

	/* 재판매 */
	@RequestMapping(value = "/productResale.do")
	public @ResponseBody List<Shopping_InfoDTO> productResaleProcess(int shop_num) {
		return managerservice.shoppingResaleMethod(shop_num);
	}

	/* 상품 삭제 */
	@RequestMapping(value = "/productDelete.do")
	public @ResponseBody List<Shopping_InfoDTO> productDeleteProcess(int shop_num) {

		// 파일까지 삭제하는 과정이 필요함 ->안해도 기능상 문제는 없을것같음

		return managerservice.shoppingDeleteMethod(shop_num);
	}

	/* 상품 추가 페이지 이동 */
	@RequestMapping(value = "/clickAddProduct")
	public String productInsertForm() {
		return "productAdd";
	}

	/* 상품 추가 */
	   @RequestMapping(value = "/productInsert.do")
	   @ResponseBody
	   public ModelAndView /* void */ productInsertProcess(ShoppingDTO dto, List<MultipartFile> filename) {
	      ModelAndView mav = new ModelAndView();

	      // 확인용
	      System.out.println("name : " + dto.getShop_name());
	      System.out.println("code : " + dto.getShop_code());
	      System.out.println("price : " + dto.getShop_price());
	      System.out.println("stock : " + dto.getShop_stock());
	      System.out.println("imgpath : " + dto.getShop_imgpath());

	      String last_path = dto.getShop_imgpath().substring(10);
	      System.out.println("last_path : " + last_path);

	      // 멀피파일 처리
	      List<MultipartFile> files = filename;
	      // List<Shopping_FileDTO> flist = new ArrayList<Shopping_FileDTO>();

	      // 첨부파일 읽어오는 과정 (여러개이기 떄문에 for문을 이용해서 처리해야 함)
	      // 파일명받기, 중복제거를 위한 난수발생, 경로지정, 첨부파일 서버에 저장, dto에 저장
	      if (files != null) {
	         for (MultipartFile file : files) {
	            // 원래 파일명 받아옴
	            String fileName = file.getOriginalFilename();
	            System.out.println("fileName : " + fileName);


	            // "C:\Users\jlg21\workspace_spring\finalproject_nanaland\src\main\webapp\images"
	            String saveDirectory = newpath + "/" +last_path;
	            String saveDirectory2 = newpath2 +last_path; 

	            
	            // '/nanaland/카테고리/상품명 상품가격' 이라는 폴더가 없는 경우 만들어라
	            File fe = new File(saveDirectory);
	            if (!fe.exists()) {
	               fe.mkdir();
	            }
	            
	            File fe2 = new File(saveDirectory2);
	            if (!fe2.exists()) {
	               fe2.mkdir();
	            }

	            // 중복되지 않도록 fileName과 발생시킨 난수를 합쳐줌
	            File ff = new File(saveDirectory, fileName);
	            File ff2 = new File(saveDirectory2, fileName);

	            // 파일 안에 있는 내용 읽어와서 서버에 저장시켜줌
	            try {
	               FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff));
	               FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(ff2));

	            } catch (FileNotFoundException e) {
	               e.printStackTrace();
	            } catch (IOException e) {
	               e.printStackTrace();
	            }

	            // 원래는 여기서 가지고 온 멀티파일의 값을 테이블에 저장하는 과정을 거치는데
	            // 이 경우는 파일에만 저장해주고 디비에는 경로만 저장되면 되므로 생략한다.

	         } // end for문(멀티파일 처리 끝)

	      } // end if문

	      /* managerservice.shoppingInsertMethod(dto); */

	      mav.addObject("sList", managerservice.shoppingInsertMethod(dto));
	      mav.setViewName("product");
	      return mav;
	   }

	/* 혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린혜린 */
	/* 형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철형철 */

	/* 채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅 */
	/* 채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅 */
	/* 오픈 채팅으로 이동 */
	@RequestMapping("/openchat.do")
	public String openchatting() {
		return "openchatting";
	}// end process()

	/* 채팅 문의하기 입장 */
	@RequestMapping("/userchat.do")
	public @ResponseBody List<ChattingDTO> userchat(HttpSession session) {
		String sendid = (String) session.getAttribute("mem_id");

		return chatService.user_chat_list(sendid);
	}

	/* 채팅 문의하기 입력 */
	@RequestMapping(value = "/userchat_insert.do", method = RequestMethod.GET)
	public @ResponseBody List<ChattingDTO> userchat_insert(ChattingDTO dto, HttpSession session) {
		String sendid = (String) session.getAttribute("mem_id");
		dto.setChat_sendid(sendid);
		System.out.println("컨트롤러 sendid=================>" + sendid);
		System.out.println("컨트롤러 컨텐츠 ===================>" + dto.getChat_content());

		return chatService.user_chat_insert(dto);
	}

	/* 관리자 채팅 */
	@RequestMapping("/chatting.do")
	public ModelAndView chattingStartProcess() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("chattingList", chatService.forManagerListAll());
		mav.setViewName("chattingStart");
		return mav;
	}

	@RequestMapping("managerChattingList.do")
	public @ResponseBody List<ChattingDTO> managerChattingList(String chat_receiver) {
		for (int i = 0; i < chatService.managerChatListProcess(chat_receiver).size(); i++) {
			System.out.println(chatService.managerChatListProcess(chat_receiver).get(i).getChat_content());
		}
		return chatService.managerChatListProcess(chat_receiver);
	}

	@RequestMapping("managerChattingInsert.do")
	public @ResponseBody void managerChattingInsert(String chat_content, String chat_receiver) {
		System.out.println("넘어온값:" + chat_content);
		ChattingDTO cdto = new ChattingDTO();
		cdto.setChat_content(chat_content);
		cdto.setChat_receiver(chat_receiver);

		chatService.managerChatInsertProcess(cdto);
	}

	/* 채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅 */
	/* 채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅채팅 */
	@RequestMapping("/member_like.do")
	public @ResponseBody List<Shopping_LikeDTO> member_like(HttpSession session) {
		String id = (String) session.getAttribute("mem_id");

		List<Shopping_LikeDTO> list = memberservice.member_like(id);

		return list;
	}

}// end class
