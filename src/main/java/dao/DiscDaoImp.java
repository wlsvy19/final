package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import dto.DiscDTO;

public class DiscDaoImp implements DiscDAO{
	//mybatis에 접근하기 위한 SqlSessionTemplate 변수
	private SqlSessionTemplate sqlSession;
	
	//생성자
	public DiscDaoImp() {
		
	}
	
	//setter
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//DiscDAO Override
	@Override
	public List<DiscDTO> discListMethod() {
		return sqlSession.selectList("disc.list");
	}

}
