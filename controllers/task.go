package controllers

import (
	"strconv"
	"github.com/lifei6671/gocron/models"
	"time"
	"encoding/json"
)

// TaskController .
type TaskController struct {
	BaseController
}

func (p *TaskController) Index() {
	p.Prepare()
	p.TplName = "task/index.tpl"
	p.Data["TaskActive"] = true

}

func (p *TaskController) Edit() {
	p.Prepare()
	p.TplName = "task/edit.tpl"
	p.Data["TaskActive"] = true
	p.Data["Model"] = models.NewTask()
	p.Data["StartTime"] = time.Now().Add(time.Hour * 24).Format("2006-01-02T15:04:05")

	task_id,_ := strconv.Atoi(p.Ctx.Input.Param(":id"))

	if p.Ctx.Input.IsPost() {
		data := p.Ctx.Input.RequestBody
		var taskEntry models.TaskEntry

		err := json.Unmarshal(data,&taskEntry)

		if err != nil {
			p.JsonResult(500,err.Error())
		}else{
			var task *models.Task

			if taskEntry.TaskId > 0 {
				if t,err := models.NewTask().Find(taskEntry.TaskId);err != nil {
					task = t
				}
			}

			task.Save()

			p.JsonResult(0,"",taskEntry.ToString())
		}
	}

	if task_id > 0 {
		if task,err := models.NewTask().Find(task_id);err == nil {
			p.Data["Model"] = task
		}
	}

}