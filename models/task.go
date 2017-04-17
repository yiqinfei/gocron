package models

import (
	"time"
	"github.com/astaxie/beego/orm"
)

// Task 任务列表.
type Task struct {
	TaskId int		`orm:"pk;auto;unique;column(task_id)" json:"task_id"`
	// TaskName 任务名称
	TaskName string		`orm:"column(task_name);size(200)" json:"task_name"`
	// Regulation 执行规则，该规则即为 crontab 的定时规则
	Regulation string 	`orm:"column(regulation);size(200)" json:"regulation"`
	// Status 任务状态：0 正常/1 禁用/2 删除 .
	Status int		`orm:"column(status);default(0)" json:"status"`
	// Timeout 超时时间： 0 永不超时/其他 指定超时时间，单位为秒 .
	Timeout int		`orm:"column(timeout);default(0)" json:"timeout"`
	// RetryCount 重试次数： 0 不重试/其他指定的次数，如果当前任务未执行完毕时又一次触发了该任务，则将直接重置为失败 .
	RetryCount int		`orm:"column(retry_count);default(0)" json:"retry_count"`
	// Shell 任务执行的内容.
	Shell string 		`orm:"column(shell);type(text)" json:"shell"`
	// Remark 备注
	Remark string		`orm:"column(remark);type(text)" json:"remark"`
	// MemberId 所有者.
	MemberId int		`orm:"column(member_id)" json:"member_id"`
	//StartTime 任务在该之间后开始执行.
	StartTime time.Time	`orm:"column(start_time)" json:"start_time"`
	// EndTime 任务截至到该时间，停止任务.
	EndTime	time.Time	`orm:"column(end_time)" json:"end_time"`
	// CreateTime 创建时间.
	CreateTime time.Time	`orm:"column(create_time);auto_now_add;type(datetime)" json:"create_time"`
	// UpdateTime 最后更新时间.
	UpdateTime time.Time	`orm:"column(update_time);auto_now_add;type(datetime)" json:"update_time"`
}


// TableName 获取对应数据库表名
func (m *Task) TableName() string {
	return "tasks"
}

// TableEngine 获取数据使用的引擎
func (m *Task) TableEngine() string {
	return "INNODB"
}

// NewScheduler 新建对象
func NewTask() *Task {
	return &Task{}
}

func (p *Task) Find(id int) (*Task,error) {
	p.TaskId = id
	o := orm.NewOrm()
	if err := o.Read(p);err != nil {
		return p,err
	}
	return p,nil
}

func (p *Task) Save()  {

}