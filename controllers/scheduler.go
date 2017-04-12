package controllers

type SchedulerController struct {
	BaseController
}

func (p *SchedulerController) Index()  {
	p.Prepare()
	p.TplName = "scheduler/index.tpl"
	p.Data["TaskActive"] = true
}

