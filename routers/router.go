package routers

import (
	"github.com/lifei6671/gocron/controllers"
	"github.com/astaxie/beego"
)

func init()  {
	beego.Router("/", &controllers.TaskController{},"*:Index")
	beego.Router("/task/edit/?:id", &controllers.TaskController{},"*:Edit")

	beego.Router("/scheduler/list/:id",&controllers.SchedulerController{},"*:Index")
}
