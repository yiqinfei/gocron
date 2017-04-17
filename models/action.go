package models

//TaskAction struct .
type TaskAction struct {
	ActionType string        `json:"type"`
	Shell ShellAction        `json:"shell"`
	Request RequestAction    `json:"request"`
}

func NewTaskAction() *TaskAction {
	return &TaskAction{
		ActionType : "shell",
		Shell : ShellAction{ Path : "", Params: "",Directory:""},
		Request: RequestAction{ Url: "",Header:"", Method:"get",Body:""},
	}
}
//ShellAction struct.
type ShellAction struct {
	Path string        	`json:"path"`
	Params string        	`json:"params"`
	Directory string        `json:"directory"`
}
// RequestAction struct.
type RequestAction struct {
	Url string        	`json:"url"`
	Header string 		`json:"header"`
	Method string 		`json:"method"`
	Body string 		`json:"body"`
}