package service;

import java.util.List;

import dao.DiscDAO;
import dto.DiscDTO;

public class DiscServiceImp implements DiscService{
	//dao 접근
	private DiscDAO dao;
	
	//생성자
	public DiscServiceImp() {
	}
	
	//setter
	public void setDao(DiscDAO dao) {
		this.dao = dao;
	}

	//override
	@Override
	public List<DiscDTO> discListMethod() {
		return dao.discListMethod();
	}
	
}//end class
