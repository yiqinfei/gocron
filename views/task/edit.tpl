<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>任务列表 - SmartCron</title>
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="/static/bootstrap/plugins/bwizard/bwizard.min.css">
    <link rel="stylesheet" href="/static/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="/static/css/global.css">
    <style type="text/css">
        .label-margin-right>label{ margin-right: 10px;}
    </style>
    <script src="/static/scripts/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="/static/scripts/jquery.form.js" type="text/javascript"></script>
    <script src="/static/vuejs/vue.min.js" type="text/javascript"></script>

</head>
<body>
{{template "widgets/header.tpl" .}}
<div class="container">
    <div class="bs-docs-container">
        <form method="post" action='{{urlfor "TaskController.Edit" ":id" .Model.TaskId}}' id="addTaskForm">
            <input type="hidden" name="id" value="2">
            <div class="title">
                <h3>添加或编辑任务 </h3>
                <hr>
            </div>
            <div class="body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="bwizard clearfix" style="margin-bottom: 20px;">
                            <ol class="bwizard-steps clearfix clickable">
                                <li role="tab" aria-selected="true" style="z-index: 4;width: 24%;" :class="[task.wizard == 'first' ? 'active' : '']" @click="task.wizard = 'first'"><span class="label" :class="[task.wizard == 'first' ? 'label-inverse' : 'label-default']">1</span><a href="#step1" class="hidden-phone">基本信息</a></li>
                                <li role="tab" aria-selected="false" style="z-index: 3;width: 24%;" :class="[task.wizard == 'second' ? 'active' : '']" @click="task.wizard = 'second'"><span class="label" :class="[task.wizard == 'second' ? 'label-inverse' : 'label-default']">2</span><a href="#step2" class="hidden-phone">触发器</a></li>
                                <li role="tab" aria-selected="true" style="z-index: 2;width: 24%;" :class="[task.wizard == 'third' ? 'active' : '']" @click="task.wizard = 'third'"><span class="label" :class="[task.wizard == 'third' ? 'label-inverse' : 'label-default']">3</span><a href="#step1" class="hidden-phone">操作</a></li>
                                <li role="tab" aria-selected="true" style="z-index: 1;width: 24%;" :class="[task.wizard == 'fourth' ? 'active' : '']" @click="task.wizard = 'fourth'"><span class="label" :class="[task.wizard == 'fourth' ? 'label-inverse' : 'label-default']">4</span><a href="#step1" class="hidden-phone">完成</a></li>
                            </ol>
                        </div>
                    </div>
                </div>
                <template v-if="task.wizard == 'first'">
                    <div class="row">
                       <div class="col-lg-12">
                           <div class="form-group">
                               <label>任务名称</label>
                               <input type="text" name="name" id="taskName" placeholder="任务名称" class="form-control" v-model.trim="task.task_name">
                           </div>
                       </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="remark">描述</label>
                                <textarea class="form-control" name="remark" id="remark" style="resize: none" placeholder="备注" v-model.trim="task.remark"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="body-botton text-center">
                        <span class="text" style="padding-right: 15px;" id="errorMessage"></span>
                        <a href="{{urlfor "TaskController.Index"}}" class="btn btn-success btn-sm">返回列表</a>
                        <button type="button" class="btn btn-info btn-sm" :disabled="task.task_name==''"  @click="task.wizard='second'">下一步</button>
                    </div>
                </template>
                <template v-if="task.wizard === 'second'">
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="form-group">
                                <label for="taskType">希望该任务何时执行？</label>
                                <select id="taskType" v-model="task.task_type" class="form-control">
                                    <option value="one">一次</option>
                                    <option value="second">秒</option>
                                    <option value="minute">分</option>
                                    <option value="hour">小时</option>
                                    <option value="day">日</option>
                                    <option value="week">周</option>
                                    <option value="month">月</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>规则 <span class="text">(日期格式：2017-04-15 15:30)</span></label>
                                <div>
                                    <template v-if="task.task_type == 'one'">
                                        <div class="form-group">
                                            执行日期 <input type="datetime-local" step="1"  name="execution_time" id="executionTime" placeholder="执行时间" class="form-control" v-model="task.trigger.one.execution_time" style="width: 50%;display: inline-block;">
                                        </div>
                                    </template>
                                    <template v-else>
                                        <div class="form-group">
                                        开始：<input type="datetime-local" step="1" name="start_time" id="startTime" placeholder="开始时间" class="form-control" v-model="task.trigger.start_time" style="width: 25%;display: inline-block;">
                                        </div>
                                        <div class="form-group">

                                        <template v-if="task.task_type == 'second'">
                                            每隔：<input type="number" min="1" max="59" name="second" id="secondNumber" placeholder="间隔的时间" class="form-control" v-model.number="task.trigger.second.interval"  style="width: 25%;display: inline-block;"> 秒
                                        </template>
                                        <template v-if="task.task_type == 'minute'">
                                            每隔：<input type="number" min="1" name="minute" id="minuteNumber" placeholder="间隔的时间" class="form-control" v-mode.numberl="task.trigger.minute.interval"  style="width: 25%;display: inline-block;"> 分
                                        </template>
                                        <template v-if="task.task_type == 'hour'">
                                            每隔：<input type="number" min="1" name="hour" id="hourNumber" placeholder="间隔的时间" class="form-control" v-model.number="task.trigger.hour.interval"  style="width: 25%;display: inline-block;"> 小时
                                        </template>
                                        <template v-if="task.task_type == 'day'">
                                            每隔： <input type="number" min="1" name="day" id="dayNumber" placeholder="间隔的时间" class="form-control" v-model.number="task.trigger.day.interval"  style="width: 25%;display: inline-block;"> 天
                                        </template>
                                        <template v-if="task.task_type == 'week'">
                                            每隔： <input type="number" min="0" name="interval" id="interval" placeholder="间隔的时间" class="form-control" v-model.number="task.trigger.week.interval"  style="width: 25%;display: inline-block;"> 周

                                            <div class="form-group label-margin-right">
                                               周几：
                                                <label><input type="checkbox" value="7" name="week" v-model.number="task.trigger.week.weeks"> 星期日</label>
                                                <label><input type="checkbox" value="1" name="week" v-model.number="task.trigger.week.weeks"> 星期一</label>
                                                <label><input type="checkbox" value="2" name="week" v-model.number="task.trigger.week.weeks"> 星期二</label>
                                                <label><input type="checkbox" value="3" name="week" v-model.number="task.trigger.week.weeks"> 星期三</label>
                                                <label><input type="checkbox" value="4" name="week" v-model.number="task.trigger.week.weeks"> 星期四</label>
                                                <label><input type="checkbox" value="5" name="week" v-model.number="task.trigger.week.weeks"> 星期五</label>
                                                <label><input type="checkbox" value="6" name="week" v-model.number="task.trigger.week.weeks"> 星期六</label>
                                            </div>
                                        </template>
                                        <template v-if="task.task_type == 'month'">
                                            <div class="form-group label-margin-right">
                                                几月：
                                                <label><input  type="checkbox" value="1" name="month" v-model.number="task.trigger.month.months">一月</label>
                                                <label><input  type="checkbox" value="2" name="month" v-model.number="task.trigger.month.months">二月</label>
                                                <label><input  type="checkbox" value="3" name="month" v-model.number="task.trigger.month.months">三月</label>
                                                <label><input  type="checkbox" value="4" name="month" v-model.number="task.trigger.month.months">四月</label>
                                                <label><input  type="checkbox" value="5" name="month" v-model.number="task.trigger.month.months">五月</label>
                                                <label><input  type="checkbox" value="6" name="month" v-model.number="task.trigger.month.months">六月</label>
                                                <label><input  type="checkbox" value="7" name="month" v-model.number="task.trigger.month.months">七月</label>
                                                <label><input  type="checkbox" value="8" name="month" v-model.number="task.trigger.month.months">八月</label>
                                                <label><input  type="checkbox" value="9" name="month" v-model.number="task.trigger.month.months">九月</label>
                                                <label><input  type="checkbox" value="10" name="month" v-model.number="task.trigger.month.months">十月</label>
                                                <label><input  type="checkbox" value="11" name="month" v-model.number="task.trigger.month.months">十一月</label>
                                                <label><input  type="checkbox" value="12" name="month" v-model.number="task.trigger.month.months">十二月</label>
                                            </div>
                                            <div class="form-group">
                                                周期：
                                                <label><input type="radio" name="monthInterval" value="day" v-model="task.trigger.month.interval"> 天</label>
                                                <label><input type="radio" name="monthInterval" value="week" v-model="task.trigger.month.interval"> 周</label>
                                            </div>
                                            <div class="form-group label-margin-right">
                                                <template v-if="trigger.month.interval == 'day'">
                                                    哪天：
                                                    <label><input type="checkbox" value="1" name="monthDay" v-model.number="task.trigger.month.days">1</label>
                                                    <label><input type="checkbox" value="2" name="monthDay" v-model.number="task.trigger.month.days">2</label>
                                                    <label><input type="checkbox" value="3" name="monthDay" v-model.number="task.trigger.month.days">3</label>
                                                    <label><input type="checkbox" value="4" name="monthDay" v-model.number="task.trigger.month.days">4</label>
                                                    <label><input type="checkbox" value="5" name="monthDay" v-model.number="task.trigger.month.days">5</label>
                                                    <label><input type="checkbox" value="6" name="monthDay" v-model.number="task.trigger.month.days">6</label>
                                                    <label><input type="checkbox" value="7" name="monthDay" v-model.number="task.trigger.month.days">7</label>
                                                    <label><input type="checkbox" value="8" name="monthDay" v-model.number="task.trigger.month.days">8</label>
                                                    <label><input type="checkbox" value="9" name="monthDay" v-model.number="task.trigger.month.days">9</label>
                                                    <label><input type="checkbox" value="10" name="monthDay" v-model.number="task.trigger.month.days">10</label>
                                                    <label><input type="checkbox" value="11" name="monthDay" v-model.number="task.trigger.month.days">11</label>
                                                    <label><input type="checkbox" value="12" name="monthDay" v-model.number="task.trigger.month.days">12</label>
                                                    <label><input type="checkbox" value="13" name="monthDay" v-model.number="task.trigger.month.days">13</label>
                                                    <label><input type="checkbox" value="14" name="monthDay" v-model.number="task.trigger.month.days">14</label>
                                                    <label><input type="checkbox" value="15" name="monthDay" v-model.number="task.trigger.month.days">15</label>
                                                    <label><input type="checkbox" value="16" name="monthDay" v-model.number="task.trigger.month.days">16</label>
                                                    <label><input type="checkbox" value="17" name="monthDay" v-model.number="task.trigger.month.days">17</label>
                                                    <label><input type="checkbox" value="18" name="monthDay" v-model.number="task.trigger.month.days">18</label>
                                                    <label><input type="checkbox" value="19" name="monthDay" v-model.number="task.trigger.month.days">19</label>
                                                    <label><input type="checkbox" value="20" name="monthDay" v-model.number="task.trigger.month.days">20</label>
                                                    <label><input type="checkbox" value="21" name="monthDay" v-model.number="task.trigger.month.days">21</label>
                                                    <label><input type="checkbox" value="22" name="monthDay" v-model.number="task.trigger.month.days">22</label>
                                                    <label><input type="checkbox" value="23" name="monthDay" v-model.number="task.trigger.month.days">23</label>
                                                    <label><input type="checkbox" value="24" name="monthDay" v-model.number="task.trigger.month.days">24</label>
                                                    <label><input type="checkbox" value="25" name="monthDay" v-model.number="task.trigger.month.days">25</label>
                                                    <label><input type="checkbox" value="26" name="monthDay" v-model.number="task.trigger.month.days">26</label>
                                                    <label><input type="checkbox" value="27" name="monthDay" v-model.number="task.trigger.month.days">27</label>
                                                    <label><input type="checkbox" value="28" name="monthDay" v-model.number="task.trigger.month.days">28</label>
                                                    <label><input type="checkbox" value="29" name="monthDay" v-model.number="task.trigger.month.days">29</label>
                                                    <label><input type="checkbox" value="30" name="monthDay" v-model.number="task.trigger.month.days">30</label>
                                                    <label><input type="checkbox" value="31" name="monthDay" v-model.number="task.trigger.month.days">31</label>
                                                    <label><input type="checkbox" value="32" name="monthDay" v-model.number="task.trigger.month.days">最后一天</label>
                                                </template>
                                            </div>
                                            <template v-if="trigger.month.interval == 'week'">
                                                <div class="form-group label-margin-right">
                                                    哪周：
                                                    <label><input type="checkbox" name="monthSerialWeek" value="1" v-model.number="task.trigger.month.week_serial">第一个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="2" v-model.number="task.trigger.month.week_serial">第二个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="3" v-model.number="task.trigger.month.week_serial">第三个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="4" v-model.number="task.trigger.month.week_serial">第四个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="5" v-model.number="task.trigger.month.week_serial">最后一周</label>
                                                </div>
                                                <div class="form-group label-margin-right">
                                                    周几：
                                                    <label><input type="checkbox" value="7" name="month_week" v-model.number="task.trigger.month.weeks"> 星期日</label>
                                                    <label><input type="checkbox" value="1" name="month_week" v-model.number="task.trigger.month.weeks"> 星期一</label>
                                                    <label><input type="checkbox" value="2" name="month_week" v-model.number="task.trigger.month.weeks"> 星期二</label>
                                                    <label><input type="checkbox" value="3" name="month_week" v-model.number="task.trigger.month.weeks"> 星期三</label>
                                                    <label><input type="checkbox" value="4" name="month_week" v-model.number="task.trigger.month.weeks"> 星期四</label>
                                                    <label><input type="checkbox" value="5" name="month_week" v-model.number="task.trigger.month.weeks"> 星期五</label>
                                                    <label><input type="checkbox" value="6" name="month_week" v-model.number="task.trigger.month.weeks"> 星期六</label>
                                                </div>
                                            </template>
                                        </template>
                                        </div>
                                        结束： <input type="datetime-local" step="1"  name="end_time" id="endTime" placeholder="终止时间" class="form-control" v-model="task.trigger.end_time" style="width: 25%;display: inline-block;">

                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="body-botton text-center">
                        <button type="button" class="btn btn-success btn-sm" @click="task.wizard='first'">上一步</button>
                        <button type="button" class="btn btn-info btn-sm" :disabled="nextThirdStep()" @click="task.wizard = 'third'">下一步</button>
                    </div>
                </template>
                <template v-if="task.wizard === 'third'">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>你希望任务执行什么操作？</label>
                                <div class="form-group label-margin-right">
                                    类型：
                                    <label><input type="radio" name="task_action" value="shell" v-model="task.action.type"> 执行脚本</label>
                                    <label><input type="radio" name="task_action" value="request" v-model="task.action.type"> Web请求</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <template v-if="task.action.type === 'shell'">
                                    <label>执行脚本配置</label>
                                    <div class="form-group">
                                        脚本路径：<input type="text" class="form-control" placeholder="执行脚本在服务器上的路径" name="shell_path" v-model.trim="task.action.shell.path" style="width: 65%;display: inline-block;">
                                    </div>
                                    <div class="form-group">
                                        启动参数：<input type="text" class="form-control" placeholder="执行脚本传递的参数" name="action_params" v-model.trim="task.action.shell.params" style="width: 65%;display: inline-block;">
                                    </div>
                                    <div class="form-group">
                                        工作目录：<input type="text" class="form-control" placeholder="脚本工作目录" name="action_directory" v-model.trim="task.action.shell.directory" style="width: 65%;display: inline-block;">
                                    </div>
                                </template>
                                <template v-if="task.action.type === 'request'">
                                    <label>Web请求参数配置</label>
                                    <div class="form-group">
                                        请求URL：<input type="text" class="form-control" placeholder="Web请求的URL地址" name="action_request_url" v-model.trim="task.action.request.url" style="width: 65%;display: inline-block;">
                                    </div>
                                    <div class="form-group">
                                        &nbsp; &nbsp;&nbsp;&nbsp;请求头：<input type="text" class="form-control" placeholder="请求头信息: key1=value&key2=value" name="action_request_header" v-model.trim="task.action.request.header" style="width: 65%;display: inline-block;">
                                        格式： key1=value&key2=value
                                    </div>
                                    <div class="form-group">
                                        请求方法：
                                        <select name="action_request_method" class="form-control" style="width: 30%;display: inline-block" v-model="task.action.request.method">
                                            <option value="get">GET</option>
                                            <option value="post">POST</option>
                                            <option value="put">PUT</option>
                                            <option value="delete">DELETE</option>
                                            <option value="head">HEAD</option>
                                            <option value="options">OPTIONS</option>
                                        </select>
                                    </div>
                                    <template v-if="task.action.request.method != 'get' && task.action.request.method != 'head'">
                                        <div class="form-group">
                                            请求内容：<input type="text" class="form-control" placeholder="请求Body信息: key1=value&key2=value" name="action_request_body" v-model.trim="task.action.request.body" style="width: 65%;display: inline-block;">
                                            格式： key1=value&key2=value
                                        </div>
                                    </template>
                                </template>
                            </div>
                        </div>
                        <div class="body-botton text-center">
                            <button type="button" class="btn btn-success btn-sm" @click="task.wizard='second'">上一步</button>
                            <button type="button" class="btn btn-info btn-sm" :disabled="nextFourthStep()" @click="task.wizard='fourth'">下一步</button>
                        </div>
                    </div>
                </template>
                <template v-if="task.wizard === 'fourth'">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label>完成定时任务的创建</label>
                                <div class="form-group">
                                    名&nbsp;&nbsp;&nbsp;&nbsp;称：<input placeholder="任务名称" type="text" readonly class="form-control" v-model.trim="task.task_name" style="display: inline-block;width: 50%">
                                </div>
                                <div class="form-group">
                                    描&nbsp;&nbsp;&nbsp;&nbsp;述：<textarea v-model.trim="task.remark" class="form-control" readonly style="display: inline-block;width: 50%;vertical-align: text-top;resize: none;"></textarea>
                                </div>
                                <div class="form-group">
                                    触发器：<input placeholder="触发器" type="text" readonly class="form-control" style="display: inline-block;width: 80%" v-model="trigger_text">
                                </div>
                            </div>
                        </div>
                        <div class="body-botton text-center">
                            <button type="button" class="btn btn-success btn-sm" @click="task.wizard='third'">上一步</button>
                            <button type="button" class="btn btn-info btn-sm" @click="save()">完成</button>
                        </div>
                    </div>
                </template>
            </div>
        </form>
    </div>
</div>

{{template "widgets/footer.tpl" .}}
<script type="text/javascript" src="/static/scripts/scripts.js"></script>
<script type="text/javascript">

    var app = new Vue({
        el : "#addTaskForm",
        delimiters : ['${','}'],
        data : {
            task : {
                task_id : 0,
                wizard : "first",
                task_name : "",
                remark  : "",
                task_type : "one",
                trigger : {
                    start_time : '{{ .StartTime }}',
                    end_time : '',
                    one : { execution_time : '{{ .StartTime }}' },
                    second : { interval : 20 },
                    minute : { interval : 50 },
                    hour : { interval : 2 },
                    day : { interval : 1 },
                    week : {
                        interval:1,
                        weeks : []
                    },
                    month : {
                        interval : 'day',
                        months : [],
                        week_serial : [],
                        weeks : [],
                        days : []
                    }
                },
                action : {
                    type : "shell",
                    shell : {
                        path : "",
                        params : "",
                        directory : ""
                    },
                    request : {
                        url : "",
                        header : "",
                        method : "get",
                        body : ""
                    }
                }
            }
        },
        computed : {
            trigger_text : function () {
                var text = "";

                if(this.task.task_type === "second"){
                    text = "每秒;每隔" + this.task.trigger.second.interval + "秒执行一次";
                    if(this.task.trigger.start_time !== ""){
                        text += ";生效时间 " + this.task.trigger.start_time;
                    }
                    if(this.task.trigger.end_time !== ""){
                        text += ";截至时间 " + this.task.trigger.end_time;
                    }
                }else if(this.task.task_type === "minute"){
                    text = "每分;每隔" + this.task.trigger.second.interval + "分钟执行一次";
                    if(this.task.trigger.start_time !== ""){
                        text += ";生效时间 " + this.task.trigger.start_time;
                    }
                    if(this.task.trigger.end_time !== ""){
                        text += ";截至时间 " + this.task.trigger.end_time;
                    }
                }else if(this.task.task_type === "hour"){
                    text = "每小时;每隔" + this.task.trigger.second.interval + "小时执行一次";
                    if(this.task.trigger.start_time !== ""){
                        text += ";生效时间 " + this.task.trigger.start_time;
                    }
                    if(this.task.trigger.end_time !== ""){
                        text += ";截至时间 " + this.task.trigger.end_time;
                    }
                }else if(this.task.task_type === "day"){
                    text = "每天;在每" + this.task.trigger.second.interval + "天的 ";

                    if(this.task.trigger.start_time !== ""){
                        var start_time = new Date(this.task.trigger.start_time);
                        text += start_time.getUTCHours() + ":" + start_time.getMinutes();
                    }
                }else if(this.task.task_type === 'one'){
                    text = "一次; 在" + this.task.trigger.one.execution_time;
                }else if(this.task.task_type === 'week'){
                    text = "每周";
                    if(this.task.trigger.week.interval > 0){
                        text += "; 每隔 " + this.task.trigger.week.interval + " 周执行一次";
                    }else{
                        text += "; 每周执行一次";
                    }
                    text += "; 在每周的 ";

                    for(var index in this.task.trigger.week.weeks){
                        text += convertWeekToChinese(this.task.trigger.week.weeks[index]) + ",";
                    }

                    if(this.task.trigger.start_time !== ""){
                        text += "; 生效时间 " + this.task.trigger.start_time ;
                    }
                    if(this.task.trigger.end_time !== ""){

                        text += "; 截至时间 " + this.task.trigger.end_time;
                    }
                }else if(this.task.task_type === "month"){
                    text = "每月; 在 ";
                    this.task.trigger.month.months.sort(function (a,b) {
                        return a-b;
                    });

                    for(var index in this.task.trigger.month.months){
                        text += convertMonthToChinese(this.task.trigger.month.months[index]) +"，";
                    }

                    text =  text.substring(0,text.length -1) + " 的 ";

                    if(this.task.trigger.month.interval === "day") {
                        this.task.trigger.month.days.sort(function (a, b) {
                            return a - b;
                        });
                        for (var index in this.task.trigger.month.days) {
                            var day = this.task.trigger.month.days[index];
                            if (day === "32") {
                                day = "最后一天";
                            }
                            text += day + "，";
                        }
                        text = text.substring(0,text.length -1) + " 运行 ";
                    }else{
                        this.task.trigger.month.week_serial.sort();
                        this.task.trigger.month.weeks.sort();
                        for(var index in this.task.trigger.month.week_serial){
                            var serial = this.task.trigger.month.week_serial[index];
                            if(serial === "1"){
                                text += " 第一个,"
                            }
                            if(serial === "2"){
                                text += "第二个,";
                            }
                            if(serial === "3"){
                                text += "第三个,";
                            }
                            if(serial === "4"){
                                text += "第四个,";
                            }
                            if(serial === "5"){
                                text += "最后一个";
                            }
                        }
                        text = text.substring(0,text.length -1) + " ";

                        for(var index in this.task.trigger.month.weeks){
                            var week = this.task.trigger.month.weeks[index];

                            text += convertWeekToChinese(week) +","
                        }
                        text = text.substring(0,text.length -1) + " 运行";
                    }

                    if(this.task.trigger.start_time !== ""){
                        var start_time = new Date(this.task.trigger.start_time);
                        text += ",时间：" + start_time.getUTCHours() + ":" + start_time.getMinutes() +
                            " ,开始日期：" + start_time.getFullYear() + "/" + (start_time.getMonth() + 1)+ "/" + start_time.getDate()
                    }
                }
                return text;
            }
        },
        methods : {
            saveTask : function (e) {
                var btn = $("#btnSaveTask");
                btn.button("load");
                alert(e)
                btn.button("reset");
            },
            nextThirdStep : function () {
                if(this.task.task_type === 'one'){
                    return this.task.trigger.one.execution_time === "";
                }
                if(this.task.task_type === 'second'){
                    return this.task.trigger.second.interval <= 0;
                }
                if(this.task.task_type === 'minute'){
                    return this.task.trigger.minute.interval <= 0;
                }
                if(this.task.task_type === 'hour'){
                    return this.task.trigger.hour.interval <= 0;
                }
                if(this.task.task_type === 'day'){
                    return this.task.trigger.day.interval <= 0;
                }
                if(this.task.task_type === 'week'){
                    return this.task.trigger.week.weeks.length <= 0;
                }
                if(this.task.task_type === 'month'){
                    if(this.task.trigger.month.months.length <= 0){
                        return true;
                    }
                    if(this.task.trigger.month.interval === 'day' && this.task.trigger.month.days.length <= 0){
                        return true;
                    }else if(this.task.trigger.month.interval === 'week' && (this.task.trigger.month.week_serial.length <= 0 || this.task.trigger.month.weeks.length <= 0)){
                        return true;
                    }
                }
                return false;
            },
            nextFourthStep: function () {
                if(this.task.action.type === 'shell'){
                    return !this.task.action.hasOwnProperty('shell') || !this.task.action.shell.hasOwnProperty('path') || this.task.action.shell.path === "";
                }
                if (this.task.action.type === "request"){
                    return !this.task.action.hasOwnProperty('request') || !this.task.action.request.hasOwnProperty('url') || this.task.action.request.url === "";
                }
                return false;
            },
            save : function () {
                var $this = this;
                var btn = $("#btnSaveTask");

                btn.button("load")
                $.ajax({
                    url : '{{urlfor "TaskController.Edit" ":id" .Model.TaskId}}',
                    type : "post",
                    contentType: "application/json; charset=utf-8",
                    data : JSON.stringify($this.task),
                    dataType : "json",
                    success : function (res) {
                        if(res.errcode !== 0){
                            alert(res.message);
                        }else{
                            window.location = '{{urlfor "TaskController.Index"}}';
                        }
                        btn.button("reset");
                    }
                })
            }
        }
    });
</script>

</body>
</html>