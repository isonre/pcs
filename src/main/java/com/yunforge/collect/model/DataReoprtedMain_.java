package com.yunforge.collect.model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="Dali", date="2016-01-16T09:09:35.300+0800")
@StaticMetamodel(DataReoprtedMain.class)
public class DataReoprtedMain_ {
	public static volatile SingularAttribute<DataReoprtedMain, String> id;
	public static volatile SingularAttribute<DataReoprtedMain, Integer> period;
	public static volatile SingularAttribute<DataReoprtedMain, String> taskName;
	public static volatile SingularAttribute<DataReoprtedMain, String> description;
	public static volatile SingularAttribute<DataReoprtedMain, String> remark;
	public static volatile SingularAttribute<DataReoprtedMain, Integer> executeType;
	public static volatile SingularAttribute<DataReoprtedMain, Integer> receiveStatus;
	public static volatile SingularAttribute<DataReoprtedMain, String> receiveTime;
	public static volatile SingularAttribute<DataReoprtedMain, Date> beginDate;
	public static volatile SingularAttribute<DataReoprtedMain, Date> endDate;
	public static volatile SingularAttribute<DataReoprtedMain, Integer> reportedStatus;
	public static volatile SingularAttribute<DataReoprtedMain, String> reportedTime;
	public static volatile SingularAttribute<DataReoprtedMain, Integer> editable;
	public static volatile SingularAttribute<DataReoprtedMain, DataCollectPerson> person;
	public static volatile SingularAttribute<DataReoprtedMain, TaskMain> taskMain;
	public static volatile ListAttribute<DataReoprtedMain, DataReoprtedDetail> dataReoprtedDetails;
}
