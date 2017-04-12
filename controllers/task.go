package controllers

import (
	"strconv"
	"github.com/lifei6671/gocron/models"
)

// TaskController .
type TaskController struct {
	BaseController
}

func (p *TaskController) Index() {
	p.Prepare()
	p.TplName = "home/index.tpl"
	p.Data["TaskActive"] = true

}

func (p *TaskController) Edit() {
	p.Prepare()
	p.TplName = "home/edit.tpl"
	p.Data["TaskActive"] = true
	p.Data["Model"] = models.NewTask()

	task_id,_ := strconv.Atoi(p.Ctx.Input.Param(":id"))

	if p.Ctx.Input.IsPost() {

	}

	if task_id > 0 {
		if task,err := models.NewTask().Find(task_id);err == nil {
			p.Data["Model"] = task
		}
	}

}