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
        <form method="post" action='/hook/edit' id="webHookForm">
            <input type="hidden" name="id" value="2">
            <div class="title">
                <h3>Edit WebHook </h3>
                <hr>
            </div>
            <div class="body">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label>Git Repository</label>
                            <input type="text" name="name" id="repositoryName" placeholder="Repository Name" class="form-control" value="go-git-webhook-demo">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label>Branch</label>
                            <input type="text" name="branch" id="repositoryBranch" placeholder="Repository Branch" class="form-control" value="master">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label for="hookType">WebHook Type</label>
                            <select name="hook_type" class="form-control" id="hookType">
                                <option>None</option>
                                <option value="github" selected>GitHub</option>
                                <option value="gitlab">GitLab</option>
                                <option value="gogs">Gogs</option>
                                <option value="gitosc">GitOsc</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label>URL</label>
                            <input type="text" readonly name="key" id="privateKey" placeholder="Git Web Hook URL" class="form-control" value="http://webhook.iminho.me/payload/69a7e2dbaffbab54371fd5ef73fa7196">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="form-group">
                            <label>Secure</label>
                            <input type="text" readonly name="secure" id="secure" placeholder="Secure" class="form-control" value="168653020ae2c82c210be4070b38a040">
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <div class="form-group">
                            <div class="form-group">
                                <label>Status</label>
                                <div>
                                    <label>
                                        <input type="radio" name="status" value="0" checked> 启用
                                    </label>
                                    <label>
                                        <input type="radio" name="status" value="1" > 禁用
                                    </label>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label for="shellScript">Callback Shell Script <a href="###"><i class="fa fa-question" aria-hidden="true"></i></a></label>
                            <textarea name="shell" id="shellScript" class="form-control" style="height: 150px;resize: none">cd /var/www/go-git-webhook-demo &amp;&amp; git pull &amp;&amp; /usr/local/go/bin/go build -v -tags &#34;pam&#34;</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="body-botton text-center">
                <span class="text" style="padding-right: 15px;" id="errorMessage"></span>

                <a href='/' class="btn btn-success btn-sm">Back WebHook List</a>
                <button id="saveWebHookBtn" type="submit" class="btn btn-info btn-sm" data-load-text="saving">Save Changes</button>

            </div>
        </form>
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