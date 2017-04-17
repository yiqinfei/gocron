package models

import "encoding/json"

type TaskEntry struct {
	TaskId int              `json:"task_id"`
	Wizard string        	`json:"wizard"`
	TaskName string      	`json:"task_name"`
	Remark string        	`json:"remark"`
	TaskType string 	`json:"task_type"`
	Trigger Trigger        	`json:"trigger"`
	Action TaskAction       `json:"action"`
}

func (p *TaskEntry) ToString() string {
	b,err := json.Marshal(p)
	if err != nil {
		return ""
	}
	return string(b)
}

func NewTaskEntry() *TaskEntry {
	return &TaskEntry{
		Wizard : "one",
		TaskType : "one",
		Trigger : *NewTrigger(),
		Action: *NewTaskAction(),
	}
}