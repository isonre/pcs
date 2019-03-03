package com.yunforge.collect.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.yunforge.collect.jackson.serializer.DataIDSerializer;
import com.yunforge.collect.jackson.serializer.NullableSerializer;
import com.yunforge.common.util.StringUtil;

@Entity
@Table(name = "Oper_DataReoprtedDetail")
public class DataReoprtedDetail {

	@Id
	@GeneratedValue(generator = "system-uuid")
	@Column(name="ID", nullable = false, updatable = false, length = 100)
	private String id;
	
	@Column(name="DATA",length = 10)
	private String data; //数据值
		
	@Transient
	private String dataName;
	
	@JsonProperty("dataID")
	@JsonSerialize(using = DataIDSerializer.class)
	public String getDataID(){
		return getTaskDetail().getDataID();
	}
	
	@JsonProperty("remark")
	public String getRemark(){
		return getTaskDetail().getRemark();
	}
	
	@JsonProperty("nullable")
	public Integer getNullable(){
		return getTaskDetail().getNullable();
	}
	
	@ManyToOne(fetch=FetchType.LAZY, optional = false)
	@JoinColumn(name = "DATAREOPRTEDMAIN")
	private DataReoprtedMain dataReoprtedMain;//填报主表外键
	
	@ManyToOne(fetch=FetchType.LAZY, optional = false)
	@JoinColumn(name = "TASKDETAILID")
	private TaskDetail taskDetail;//任务细表外键
	
	@JsonProperty("agrProCategory2Name")
	public String getAgrProCategory2Name(){
		return getTaskDetail().getAgrProCategory2Name();
	}
	
	@Column( name="EDITABLE")
	private Integer editable=0;
	
	@Transient
	private Integer nullalbe;
	
	public static final class DATAID{
		public static final int YIELD  = 11;
		public static final int SALECOUNT = 21;
		public static final int WHOLESALEPRICE  = 31;
		public static final int MARKETVALUE  = 41;
		public static final int HIGHESTPRICE  = 42;
		public static final int LOWESTPRICE  = 43;
		public static final int AVGPRICE  = 44;
		public static final int STAPLEPRICE  = 45;
	}
	
	public Integer getEditable() {
		return editable;
	}

	public void setEditable(Integer editable) {
		this.editable = editable;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public DataReoprtedMain getDataReoprtedMain() {
		return dataReoprtedMain;
	}

	public void setDataReoprtedMain(DataReoprtedMain dataReoprtedMain) {
		this.dataReoprtedMain = dataReoprtedMain;
	}

	public TaskDetail getTaskDetail() {
		return taskDetail;
	}

	public void setTaskDetail(TaskDetail taskDetail) {
		this.taskDetail = taskDetail;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
	public String getDataName() {
		return dataName;
	}


	public void setDataName(String dataName) {
		this.dataName = dataName;
	}

	public Integer getNullalbe() {
		return getTaskDetail().getNullable();
	}

	public void setNullalbe(Integer nullalbe) {
		this.nullalbe = nullalbe;
	}

}
