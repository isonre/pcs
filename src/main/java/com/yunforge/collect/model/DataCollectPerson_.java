package com.yunforge.collect.model;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="Dali", date="2016-01-19T16:49:47.767+0800")
@StaticMetamodel(DataCollectPerson.class)
public class DataCollectPerson_ {
	public static volatile SingularAttribute<DataCollectPerson, String> id;
	public static volatile SingularAttribute<DataCollectPerson, String> code;
	public static volatile SingularAttribute<DataCollectPerson, String> name;
	public static volatile SingularAttribute<DataCollectPerson, String> alias;
	public static volatile SingularAttribute<DataCollectPerson, String> sex;
	public static volatile SingularAttribute<DataCollectPerson, String> telephone;
	public static volatile SingularAttribute<DataCollectPerson, String> adress;
	public static volatile SingularAttribute<DataCollectPerson, Integer> state;
	public static volatile SingularAttribute<DataCollectPerson, String> description;
	public static volatile SingularAttribute<DataCollectPerson, String> remark;
	public static volatile SingularAttribute<DataCollectPerson, DataCollectPoint> dataCollectPoint;
	public static volatile ListAttribute<DataCollectPerson, TaskGive> taskGives;
	public static volatile ListAttribute<DataCollectPerson, PersonGroup> personGroups;
	public static volatile ListAttribute<DataCollectPerson, DataReoprtedMain> dataReoprtedMain;
}
