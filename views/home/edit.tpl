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
        <form method="post" action='/hook/edit' id="addTaskForm">
            <input type="hidden" name="id" value="2">
            <div class="title">
                <h3>添加或编辑任务 </h3>
                <hr>
            </div>
            <div class="body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="bwizard clearfix" style="margin-bottom: 10px;">
                            <ol class="bwizard-steps clearfix clickable">
                                <li role="tab" aria-selected="true" style="z-index: 4;width: 24%;" :class="[wizard == 'first' ? 'active' : '']" @click="wizard = 'first'"><span class="label" :class="[wizard == 'first' ? 'label-inverse' : 'label-default']">1</span><a href="#step1" class="hidden-phone">基本信息</a></li>
                                <li role="tab" aria-selected="false" style="z-index: 3;width: 24%;" :class="[wizard == 'second' ? 'active' : '']" @click="wizard = 'second'"><span class="label" :class="[wizard == 'second' ? 'label-inverse' : 'label-default']">2</span><a href="#step2" class="hidden-phone">触发器</a></li>
                                <li role="tab" aria-selected="true" style="z-index: 2;width: 24%;" :class="[wizard == 'third' ? 'active' : '']" @click="wizard = 'third'"><span class="label" :class="[wizard == 'third' ? 'label-inverse' : 'label-default']">3</span><a href="#step1" class="hidden-phone">操作</a></li>
                                <li role="tab" aria-selected="true" style="z-index: 2;width: 24%;" :class="[wizard == 'fourth' ? 'active' : '']" @click="wizard = 'fourth'"><span class="label" :class="[wizard == 'third' ? 'label-inverse' : 'label-default']">4</span><a href="#step1" class="hidden-phone">完成</a></li>

                            </ol>
                        </div>
                    </div>
                </div>
                <template v-if="wizard == 'first'">
                    <div class="row">
                       <div class="col-lg-12">
                           <div class="form-group">
                               <label>任务名称</label>
                               <input type="text" name="name" id="taskName" placeholder="任务名称" class="form-control" v-model.lazy="task_name">
                           </div>
                       </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group">
                                <label for="remark">描述</label>
                                <textarea class="form-control" name="remark" id="remark" style="resize: none" placeholder="备注" v-model.trim="remark"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="body-botton text-center">
                        <span class="text" style="padding-right: 15px;" id="errorMessage"></span>
                        <a href="{{urlfor "TaskController.Index"}}" class="btn btn-success btn-sm" @click="wizard='first'">返回列表</a>
                        <button type="button" class="btn btn-info btn-sm" :disabled="task_name==''"  @click="wizard='second'">下一步</button>
                    </div>
                </template>
                <template v-if="wizard == 'second'">
                <div class="row">
                    <div class="col-lg-5">
                        <div class="form-group">
                            <label for="taskType">希望该任务何时执行？</label>
                            <select id="taskType" v-model="task_type" class="form-control">
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
                                    <template v-if="task_type == 'one'">
                                        <div class="form-group">
                                            执行日期 <input type="datetime-local" value="2015-04-02T10:24:10" name="execution_time" id="executionTime" placeholder="执行时间" class="form-control" v-model="trigger.one.execution_time" style="width: 50%;display: inline-block;">
                                        </div>
                                    </template>
                                    <template v-else>
                                        <div class="form-group">
                                        开始：<input type="datetime-local" name="start_time" id="startTime" placeholder="开始时间" class="form-control" v-model="trigger.start_time" style="width: 25%;display: inline-block;">
                                        </div>
                                        <div class="form-group">

                                        <template v-if="task_type == 'second'">
                                            每隔：<input type="number" min="1" max="59" name="second" id="secondNumber" placeholder="间隔的时间" class="form-control" v-model="trigger.second.interval"  style="width: 25%;display: inline-block;"> 秒
                                        </template>
                                        <template v-if="task_type == 'minute'">
                                            每隔：<input type="number" min="1" name="minute" id="minuteNumber" placeholder="间隔的时间" class="form-control" v-model="trigger.minute.interval"  style="width: 25%;display: inline-block;"> 分
                                        </template>
                                        <template v-if="task_type == 'hour'">
                                            每隔：<input type="number" min="1" name="hour" id="hourNumber" placeholder="间隔的时间" class="form-control" v-model="trigger.hour.interval"  style="width: 25%;display: inline-block;"> 小时
                                        </template>
                                        <template v-if="task_type == 'day'">
                                            每隔： <input type="number" min="1" name="day" id="dayNumber" placeholder="间隔的时间" class="form-control" v-model="trigger.day.interval"  style="width: 25%;display: inline-block;"> 天
                                        </template>
                                        <template v-if="task_type == 'week'">
                                            每隔： <input type="number" min="0" name="interval" id="interval" placeholder="间隔的时间" class="form-control" v-model="trigger.week.interval"  style="width: 25%;display: inline-block;"> 周

                                            <div class="form-group label-margin-right">
                                               周几：
                                                <label><input type="checkbox" value="sunday" name="week" v-model="trigger.week.weeks"> 星期日</label>
                                                <label><input type="checkbox" value="monday" name="week" v-model="trigger.week.weeks"> 星期一</label>
                                                <label><input type="checkbox" value="tuesday" name="week" v-model="trigger.week.weeks"> 星期二</label>
                                                <label><input type="checkbox" value="wednesday" name="week" v-model="trigger.week.weeks"> 星期三</label>
                                                <label><input type="checkbox" value="thursday" name="week" v-model="trigger.week.weeks"> 星期四</label>
                                                <label><input type="checkbox" value="friday" name="week" v-model="trigger.week.weeks"> 星期五</label>
                                                <label><input type="checkbox" value="saturday" name="week" v-model="trigger.week.weeks"> 星期六</label>
                                            </div>
                                        </template>
                                        <template v-if="task_type == 'month'">
                                            <div class="form-group label-margin-right">
                                                几月：
                                                <label><input  type="checkbox" value="january" name="month" v-model="trigger.month.months">一月</label>
                                                <label><input  type="checkbox" value="february" name="month" v-model="trigger.month.months">二月</label>
                                                <label><input  type="checkbox" value="march" name="month" v-model="trigger.month.months">三月</label>
                                                <label><input  type="checkbox" value="april" name="month" v-model="trigger.month.months">四月</label>
                                                <label><input  type="checkbox" value="may" name="month" v-model="trigger.month.months">五月</label>
                                                <label><input  type="checkbox" value="june" name="month" v-model="trigger.month.months">六月</label>
                                                <label><input  type="checkbox" value="july" name="month" v-model="trigger.month.months">七月</label>
                                                <label><input  type="checkbox" value="august" name="month" v-model="trigger.month.months">八月</label>
                                                <label><input  type="checkbox" value="september" name="month" v-model="trigger.month.months">九月</label>
                                                <label><input  type="checkbox" value="october" name="month" v-model="trigger.month.months">十月</label>
                                                <label><input  type="checkbox" value="november" name="month" v-model="trigger.month.months">十一月</label>
                                                <label><input  type="checkbox" value="december" name="month" v-model="trigger.month.months">十二月</label>
                                            </div>
                                            <div class="form-group">
                                                周期：
                                                <label><input type="radio" name="monthInterval" value="day" v-model="trigger.month.interval"> 天</label>
                                                <label><input type="radio" name="monthInterval" value="week" v-model="trigger.month.interval"> 周</label>
                                            </div>
                                            <div class="form-group label-margin-right">
                                                <template v-if="trigger.month.interval == 'day'">
                                                    哪天：
                                                    <label><input type="checkbox" value="1" name="monthDay" v-model="trigger.month.days">1</label>
                                                    <label><input type="checkbox" value="2" name="monthDay" v-model="trigger.month.days">2</label>
                                                    <label><input type="checkbox" value="3" name="monthDay" v-model="trigger.month.days">3</label>
                                                    <label><input type="checkbox" value="4" name="monthDay" v-model="trigger.month.days">4</label>
                                                    <label><input type="checkbox" value="5" name="monthDay" v-model="trigger.month.days">5</label>
                                                    <label><input type="checkbox" value="6" name="monthDay" v-model="trigger.month.days">6</label>
                                                    <label><input type="checkbox" value="7" name="monthDay" v-model="trigger.month.days">7</label>
                                                    <label><input type="checkbox" value="8" name="monthDay" v-model="trigger.month.days">8</label>
                                                    <label><input type="checkbox" value="9" name="monthDay" v-model="trigger.month.days">9</label>
                                                    <label><input type="checkbox" value="10" name="monthDay" v-model="trigger.month.days">10</label>
                                                    <label><input type="checkbox" value="11" name="monthDay" v-model="trigger.month.days">11</label>
                                                    <label><input type="checkbox" value="12" name="monthDay" v-model="trigger.month.days">12</label>
                                                    <label><input type="checkbox" value="13" name="monthDay" v-model="trigger.month.days">13</label>
                                                    <label><input type="checkbox" value="14" name="monthDay" v-model="trigger.month.days">14</label>
                                                    <label><input type="checkbox" value="15" name="monthDay" v-model="trigger.month.days">15</label>
                                                    <label><input type="checkbox" value="16" name="monthDay" v-model="trigger.month.days">16</label>
                                                    <label><input type="checkbox" value="17" name="monthDay" v-model="trigger.month.days">17</label>
                                                    <label><input type="checkbox" value="18" name="monthDay" v-model="trigger.month.days">18</label>
                                                    <label><input type="checkbox" value="19" name="monthDay" v-model="trigger.month.days">19</label>
                                                    <label><input type="checkbox" value="20" name="monthDay" v-model="trigger.month.days">20</label>
                                                    <label><input type="checkbox" value="21" name="monthDay" v-model="trigger.month.days">21</label>
                                                    <label><input type="checkbox" value="22" name="monthDay" v-model="trigger.month.days">22</label>
                                                    <label><input type="checkbox" value="23" name="monthDay" v-model="trigger.month.days">23</label>
                                                    <label><input type="checkbox" value="24" name="monthDay" v-model="trigger.month.days">24</label>
                                                    <label><input type="checkbox" value="25" name="monthDay" v-model="trigger.month.days">25</label>
                                                    <label><input type="checkbox" value="26" name="monthDay" v-model="trigger.month.days">26</label>
                                                    <label><input type="checkbox" value="27" name="monthDay" v-model="trigger.month.days">27</label>
                                                    <label><input type="checkbox" value="28" name="monthDay" v-model="trigger.month.days">28</label>
                                                    <label><input type="checkbox" value="29" name="monthDay" v-model="trigger.month.days">29</label>
                                                    <label><input type="checkbox" value="30" name="monthDay" v-model="trigger.month.days">30</label>
                                                    <label><input type="checkbox" value="31" name="monthDay" v-model="trigger.month.days">31</label>
                                                    <label><input type="checkbox" value="32" name="monthDay" v-model="trigger.month.days">最后一天</label>
                                                </template>
                                            </div>
                                            <template v-if="trigger.month.interval == 'week'">
                                                <div class="form-group label-margin-right">
                                                    哪周：
                                                    <label><input type="checkbox" name="monthSerialWeek" value="1" v-model="trigger.month.week_serial">第一个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="2" v-model="trigger.month.week_serial">第二个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="3" v-model="trigger.month.week_serial">第三个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="4" v-model="trigger.month.week_serial">第四个</label>
                                                    <label><input type="checkbox" name="monthSerialWeek" value="last" v-model="trigger.month.week_serial">最后一周</label>
                                                </div>
                                                <div class="form-group label-margin-right">
                                                    周几：
                                                    <label><input type="checkbox" value="sunday" name="month_week" v-model="trigger.month.weeks"> 星期日</label>
                                                    <label><input type="checkbox" value="monday" name="month_week" v-model="trigger.month.weeks"> 星期一</label>
                                                    <label><input type="checkbox" value="tuesday" name="month_week" v-model="trigger.month.weeks"> 星期二</label>
                                                    <label><input type="checkbox" value="wednesday" name="month_week" v-model="trigger.month.weeks"> 星期三</label>
                                                    <label><input type="checkbox" value="thursday" name="month_week" v-model="trigger.month.weeks"> 星期四</label>
                                                    <label><input type="checkbox" value="friday" name="month_week" v-model="trigger.month.weeks"> 星期五</label>
                                                    <label><input type="checkbox" value="saturday" name="month_week" v-model="trigger.month.weeks"> 星期六</label>
                                                </div>
                                            </template>
                                        </template>
                                        </div>
                                        结束： <input type="datetime-local" name="end_time" id="endTime" placeholder="终止时间" class="form-control" v-model="trigger.end_time" style="width: 25%;display: inline-block;">

                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="body-botton text-center">
                        <span class="text" style="padding-right: 15px;" id="errorMessage"></span>
                        <button type="button" class="btn btn-success btn-sm" @click="wizard='first'">上一步</button>
                        <button type="button" class="btn btn-info btn-sm" :disabled="nextThirdStep()">下一步</button>
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
            wizard : "first",
            task_name : "",
            remark  : "",
            task_type : "second",
            trigger : {
                start_time : '2018-01-25T14:20:10',
                end_time : '',
                one : { execution_time : ''},
                second : { interval : 20 },
                minute : { interval : 50 },
                hour : { interval : 2 },
                day : { interval : 1 },
                week : {
                    interval:1,
                    weeks : ['sunday']
                },
                month : {
                    interval : 'day',
                    months : [],
                    week_serial : [],
                    weeks : [],
                    days : []
                }
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
                if(this.task_type === 'one'){
                    return this.trigger.one.execution_time === "";
                }
                if(this.task_type === 'second'){
                    return this.trigger.second.interval <= 0;
                }
                if(this.task_type === 'minute'){
                    return this.trigger.minute.interval <= 0;
                }
                if(this.task_type === 'hour'){
                    return this.trigger.hour.interval <= 0;
                }
                if(this.task_type === 'day'){
                    return this.trigger.day.interval <= 0;
                }
                if(this.task_type === 'week'){
                    return this.trigger.week.weeks.length <= 0;
                }
                if(this.task_type === 'month'){
                    if(this.trigger.month.months.length <= 0){
                        return true;
                    }
                    if(this.trigger.month.interval === 'day' && this.trigger.month.days.length <= 0){
                        return true;
                    }else if(this.trigger.month.interval === 'week' && (this.trigger.month.week_serial.length <= 0 || this.trigger.month.weeks.length <= 0)){
                        return true;
                    }
                }
                return false;
            }
        }
    });
</script>

</body>
</html>