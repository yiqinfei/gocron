<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>任务列表 - SmartCron</title>
    <link rel="stylesheet" href="/static/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="/static/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="/static/css/global.css">
    <script src="/static/scripts/jquery-1.12.4.min.js" type="text/javascript"></script>
    <script src="/static/scripts/jquery.form.js" type="text/javascript"></script>
    <script src="/static/vuejs/vue.min.js" type="text/javascript"></script>
</head>
<body>
{{template "widgets/header.tpl" .}}
<div class="container">
    <div class="bs-docs-container">
        <div class="title">
            <h3>任务列表</h3>
            <hr>
        </div>
        <div class="body">
            <table class="table table-condensed" id="tableCronList">
                <thead>
                <tr>
                    <th width="10%">任务编号</th>
                    <th>任务名称</th>
                    <th width="15%">超时时间</th>
                    <th width="10%">重试次数</th>
                    <th width="15%">更新时间</th>
                    <th width="10%">状态</th>
                    <th width="12%">操作</th>
                </tr>
                </thead>
                <tbody>

                <tr v-if="lists.length <= 0">
                    <td colspan="5" class="text-center">暂无记录</td>
                </tr>
                <template v-else>
                <tr v-for="item in lists">
                    <td>${item.task_id}</td>
                    <td>${item.task_name}</td>
                    <td>${item.timeout}秒</td>
                    <td>${item.retry_count}次</td>
                    <td>${item.update_time}</td>
                    <td>
                        <span class="label label-success">正常</span>
                    </td>
                    <td>
                        <a :href="'{{urlfor "TaskController.Edit" ":id" ""}}' + item.task_id"   title="编辑" class="btn btn-default btn-sm edit-btn" data-toggle="tooltip"><i class="fa fa-edit" aria-hidden="true"></i></a>
                        <a href="###" title="删除" class="btn btn-default btn-sm delete-hook-btn" data-id="2" data-toggle="tooltip"><i class="fa fa-times" aria-hidden="true"></i></a>
                        <a :href="'{{urlfor "SchedulerController.Index" ":id" ""}}' + item.task_id" title="执行记录" class="btn btn-default btn-sm" data-toggle="tooltip"><i class="fa fa-clock-o" aria-hidden="true"></i></a>
                    </td>
                </tr>
                </template>
                </tbody>
            </table>

        </div>
        <div class="body-botton text-center">
            <a href="{{urlfor "TaskController.Edit" ":id" ""}}" class="btn btn-success btn-sm">添加新的定时任务</a>
        </div>
    </div>
</div>

{{template "widgets/footer.tpl" .}}
<script type="text/javascript" src="/static/scripts/scripts.js"></script>
<script type="text/javascript">
    var app = new Vue({
        el : "#tableCronList",
        delimiters : ['${','}'],
        data : {
            lists: [
                {task_id : 1 , "task_name" : "电商频道订单结束","timeout" : 0,"retry_count" : 0,"update_time" : "2017-04-15 05:12:14","url" :"a"}
            ]
        },
        methods : {

        }
    });
</script>

</body>
</html>