package com.yunforge.base.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.yunforge.base.model.Person;

public interface PersonManager {

	public Person findById(String id);

	public Person findByPersName(String personName);
	
	public Person findByUserId(String userId);
	
	public Person findByUsername(String username);

	public Page<Person> findAll(Pageable pageable);

	public List<Person> findAll(String[] ids);

	public Person savePerson(Person person);

	public void removePerson(Person person);

	public void removePersons(List<Person> persons);

	public void removePersons(String[] ids);

	public Page<Person> listPersons(String filters, Pageable pageable,String persName);

	public Page<Person> listOrgPersons(String orgId, String filters,
			Pageable pageable);

	void setUnIsCollect(String[] id);


	Page<Person> listPersonByOrgAndIsCollect(String orgId, Integer isCollect,
			Pageable pageable,String persNameParam);

}