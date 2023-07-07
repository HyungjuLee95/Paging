package text.com.paging.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import text.com.paging.Model.PagingVO;
import text.com.paging.Service.PagingService;


@Slf4j
@Controller
public class PagingController {
	
	@Autowired
	PagingService service;
	
	@Autowired
	HttpSession session;
	
	@RequestMapping(value = "/PagingSelectAll.do", method = RequestMethod.GET)
	public String PagingSelectAll(Model model) {
		log.info("PagingSelectAll.do().....{}");
		

		
		List<PagingVO> vos = service.selectAll();
		log.info("Paging().....{}", vos);

		for (PagingVO vo : vos) {
			log.info(vo.toString());
		}
		model.addAttribute("vos",vos);
	

		return "pagingpage";

	
}	

	
	
	
	@ResponseBody
	@RequestMapping(value = "/json_PagingSelectAll.do", method = RequestMethod.GET)
	public List<PagingVO> json_PagingSelectAll() {
		log.info("PagingSelectAll.do().....{}");
		

		
		List<PagingVO> vos = service.selectAll();
		log.info("Paging().....{}", vos);

	
	

		return vos;

	
}
}
