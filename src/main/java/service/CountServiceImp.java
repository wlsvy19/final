package service;

import dao.CountDAO;


public class CountServiceImp implements CountService{
	private CountDAO dao;
	
	public CountServiceImp() {
		// TODO Auto-generated constructor stub
	}
	
	public void setDao(CountDAO dao) {
		this.dao = dao;
	}
	
	
	@Override
	public int count_number() {
		// TODO Auto-generated method stub
		return dao.count_number();
	}

	@Override
	public int count_like() {
		// TODO Auto-generated method stub
		return dao.count_like();
	}

	@Override
	public int count_product() {
		// TODO Auto-generated method stub
		return dao.count_product();
	}

}
