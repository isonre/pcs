package com.yunforge.collect.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.yunforge.collect.jackson.serializer.EnableOrDisableSerializer;
import com.yunforge.collect.model.GropInfo;

@Entity
@Table(name = "oper_PersonGroup")
public class PersonGroup {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@Column(name="ID", nullable = false, updatable = false, length = 100)
	private String id;
	
	@ManyToOne(fetch=FetchType.LAZY, optional = false)
	@JoinColumn(name = "GROPINFOID")
	private GropInfo gropInfo;//分组外键
	
	@ManyToOne(fetch=FetchType.LAZY, optional = false)
	@JoinColumn(name = "DATACOLLECTPERSONID")
	private DataCollectPerson dataCollectPerson;//人外键
	
	@JsonProperty("personName")
	public String getPersonName(){
		return getDataCollectPerson().getName();
	}
	
	@JsonProperty("personCode")
	public String getPersonCode(){
		return getDataCollectPerson().getCode();
	}
	
	@JsonProperty("personAlias")
	public String getPersonAliass(){
		return getDataCollectPerson().getAlias();
	}
	
	@JsonProperty("personRemark")
	public String getPersonRemark(){
		return getDataCollectPerson().getRemark();
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public GropInfo getGropInfo() {
		return gropInfo;
	}

	public void setGropInfo(GropInfo gropInfo) {
		this.gropInfo = gropInfo;
	}
	
	public DataCollectPerson getDataCollectPerson() {
		return dataCollectPerson;
	}

	public void setDataCollectPerson(DataCollectPerson dataCollectPerson) {
		this.dataCollectPerson = dataCollectPerson;
	}

}
