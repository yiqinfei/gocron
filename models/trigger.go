package models

import "time"

//Trigger struct .
type Trigger struct {
	StartTime string	`json:"start_time"`
	EndTime string		`json:"end_time"`
	One OneTrigger          `json:"one"`
	Second SecondTrigger 	`json:"second"`
	Minute MinuteTrigger 	`json:"minute"`
	Hour HourTrigger 	`json:"hour"`
	Day DayTrigger 		`json:"day"`
	Week WeekTrigger  	`json:"week"`
}

func NewTrigger() *Trigger {
	return &Trigger{
		StartTime : time.Now().Add(time.Hour * 24).Format("2006-01-02T15:04:05"),
		EndTime : "",
		One: OneTrigger{ ExecutionTime : ""},
		Second: SecondTrigger{ Interval : 1 },
		Minute: MinuteTrigger{ Interval: 1},
		Hour: HourTrigger{ Interval: 1},
		Day: DayTrigger{ Interval: 1},
		Week:WeekTrigger{ Interval: 0 },
	}
}

type OneTrigger struct {
	ExecutionTime string	`json:"execution_time"`
}

type SecondTrigger struct {
	Interval int        `json:"interval"`
}
type MinuteTrigger struct {
	Interval int        `json:"interval"`
}
type HourTrigger struct {
	Interval int        `json:"interval"`
}
type DayTrigger struct {
	Interval int        `json:"interval"`
}

type WeekTrigger struct {
	Interval int        `json:"interval"`

}

