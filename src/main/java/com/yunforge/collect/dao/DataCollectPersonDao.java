package com.yunforge.collect.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.yunforge.collect.model.DataCollectPerson;
import com.yunforge.collect.model.TaskGive;

public interface DataCollectPersonDao extends JpaRepository<DataCollectPerson, String>,JpaSpecificationExecutor<DataCollectPerson>{
	
	@Query("select t from DataCollectPerson t order by t.code")
	public List<DataCollectPersonDao> findDataCollectPersonByOrderByCode();
	
	@Query("select t from TaskGive t where  t.taskMain.id=?1")
	public List<TaskGive> findByTaskMain(String taskMainId);

	@Query(value="select dd.* from oper_datacollectperson dd where dd.id not in (select dp.datacollectpersonid from oper_persongroup dp)",nativeQuery=true)
	public List<DataCollectPerson> getNotGroupPersonList();
}
