package main

import (
	_ "github.com/go-sql-driver/mysql"
	_ "github.com/lifei6671/gocron/routers"
	"github.com/lifei6671/gocron/commands"
)

func main() {

	commands.RegisterLogger()
	commands.RegisterDataBase()
	commands.RegisterModel()
	commands.RunCommand()

	commands.Run()
}
