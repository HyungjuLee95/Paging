package text.com.paging.Model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PagingDAOimpl implements PagingDAO {
	
	@Autowired
	SqlSession sqlsession;
	
	public PagingDAOimpl () {
		log.info("PagingDAOimpl()...");
	}

	@Override
	public List<PagingVO> selectAll() {
		log.info("selectAll in DAOimpl()...");
		return sqlsession.selectList("Paging_SELECT_ALL");
	}
	
	

}
