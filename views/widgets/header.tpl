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
                <li{{if .TaskActive}} class="active"{{end}}><a href="/" title="任务列表">任务列表</a> </li>
                <li{{if .MemberActive}} class="active"{{end}}><a href="/server">用户列表</a> </li>
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