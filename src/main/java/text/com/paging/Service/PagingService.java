package text.com.paging.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import text.com.paging.Model.PagingDAO;
import text.com.paging.Model.PagingVO;

@Service
public class PagingService {
	@Autowired
	PagingDAO dao;
	
	public List<PagingVO> selectAll(){
		return dao.selectAll() ;
	}
}
