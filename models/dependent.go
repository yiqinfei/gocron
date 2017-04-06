package models

// Dependent 任务依赖表.
type Dependent struct {
	// DependentId 主键.
	DependentId int		`orm:"pk;auto;unique;column(dependent_id)" json:"dependent_id"`
	// TaskId 所属任务 .
	TaskId int		`orm:"column(task_id)" json:"task_id"`
	//  OrderIndex 排序，需要越大优先级越高 .
	OrderIndex int		`orm:"column(order_index);default(0)" json:"order_index"`
	// DependentTaskId 依赖的任务ID .
	DependentTaskId int 	`orm:"column(dependent_task_id)" json:"dependent_task_id"`
}
