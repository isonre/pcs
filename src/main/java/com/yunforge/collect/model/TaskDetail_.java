package com.yunforge.collect.model;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="Dali", date="2016-01-15T10:24:55.524+0800")
@StaticMetamodel(TaskDetail.class)
public class TaskDetail_ {
	public static volatile SingularAttribute<TaskDetail, String> id;
	public static volatile SingularAttribute<TaskDetail, String> dataID;
	public static volatile SingularAttribute<TaskDetail, Date> beginDate;
	public static volatile SingularAttribute<TaskDetail, Date> endDate;
	public static volatile SingularAttribute<TaskDetail, String> cron;
	public static volatile SingularAttribute<TaskDetail, String> timeframe;
	public static volatile SingularAttribute<TaskDetail, Integer> nullable;
	public static volatile SingularAttribute<TaskDetail, String> checkExp;
	public static volatile SingularAttribute<TaskDetail, String> remark;
	public static volatile SingularAttribute<TaskDetail, AgrProCategory2> agrProCategory2;
	public static volatile SingularAttribute<TaskDetail, TaskMain> taskMain;
	public static volatile ListAttribute<TaskDetail, DataReoprtedDetail> dataReoprtedDetails;
}
