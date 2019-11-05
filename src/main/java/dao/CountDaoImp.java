package dao;



import org.mybatis.spring.SqlSessionTemplate;



public class CountDaoImp implements CountDAO{
	private SqlSessionTemplate sqlSession;
	
	public CountDaoImp() {
		
	}
	
	public void setSqlSession(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public int count_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("lib.count_number");
	}

	@Override
	public int count_like() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("lib.count_like");
	}

	@Override
	public int count_product() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("lib.count_product");
	}




	
	
}
