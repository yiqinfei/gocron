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
<header class="navbar navbar-static-top bs-docs-nav navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target="#bs-navbar" aria-controls="bs-navbar" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="/" class="navbar-brand" se_prerender_url="complete">SmartCron</a>
        </div>
        <nav class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="/" title="任务列表">任务列表</a> </li>
                <li><a href="/server">用户列表</a> </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <div class="dropdown member-dropdown" id="btnMemberList">
                        <a href="###" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img src="/static/images/headimgurl.jpg" onerror="this.src='/static/images/headimgurl.jpg'" class="img-circle" style="width: 32px;height: 32px;">
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dLabel" style="margin-top: 0px">
                            <li><a href="/my"><i class="fa fa-user" aria-hidden="true"></i> 个人中心</a> </li>
                            <li><a href="/logout"><i class="fa fa-sign-out"></i> 退出</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </nav>
    </div>
</header>
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
            <button class="btn btn-success btn-sm" id="addCronBtn">添加新的定时任务</button>
        </div>
    </div>
</div>

<div class="modal fade" id="webHookModal" tabindex="-1" role="dialog" aria-labelledby="webHookModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <form method="post" id="webHookForm" action='/hook/edit'>
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="webHookTitle">New WebHook</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>Git Repository</label>
                                    <input type="text" name="name" id="repositoryName" placeholder="Repository Name" class="form-control">
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label>Branch</label>
                                    <input type="text" name="branch" id="repositoryBranch" placeholder="Repository Branch" class="form-control">
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label for="hookType">WebHook Type</label>
                                    <select name="hook_type" class="form-control" id="hookType">
                                        <option>None</option>
                                        <option value="github">GitHub</option>
                                        <option value="gitlab">GitLab</option>
                                        <option value="gogs">Gogs</option>
                                        <option value="gitosc">GitOsc</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label for="shellScript">Callback Shell Script <a href="###"><i class="fa fa-question" aria-hidden="true"></i></a></label>
                                    <textarea name="shell" id="shellScript" class="form-control" style="height: 200px;resize: none"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <span id="errorMessage" style="display: inline-block;padding-right: 10px;"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary" id="saveWebHookBtn" data-load-text="saving">Save changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="copySecureModal" tabindex="-1" role="dialog" aria-labelledby="copySecureModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="copySecureModalTitle">Copy Url</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-2">
                            <label>Url </label>
                        </div>
                        <div class="col-lg-10">
                            <input type="text" id="urlInput" placeholder="URL" class="form-control" data-value="http://webhook.iminho.me/payload/">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-2">
                            <label>Secure </label>
                        </div>
                        <div class="col-lg-10">
                            <input type="text" id="secureInput" placeholder="Token" class="form-control" >
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid navbar-fixed-bottom footer">
    <div class="text-center">
        <span><a href="https://hook.iminho.me" target="_blank">SmartWebHook</a> </span>
        <span style="display: inline-block;padding: 0 5px;"> · </span>
        <span><a href="https://github.com/lifei6671/go-git-webhook/issues" target="_blank">意见反馈</a> </span>
        <span style="display: inline-block;padding: 0 5px;"> · </span>
        <span><a href="https://github.com/lifei6671/go-git-webhook" target="_blank">GitHub</a> </span>

    </div>
</div>
<script src="/static/bootstrap/js/bootstrap.js" type="text/javascript"></script>
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