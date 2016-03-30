<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <link href="<%: Url.Content("~/favicon.ico") %>" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" href="/Content/bootstrap/css/bootstrap.css" />
    <title>Un Authorized</title>
</head>
<body>
    <div class="container-fluid" style="background-color:#5db194;height:100vh; width:100vw;">
        <div class="container" style="height:100%;">
            <div style="margin:auto; width:750px; position:relative; top:50%; transform:translateY(-50%); color:white;">
                
                <div>
                  <a href="/"><img src="../../Images/brand.png" /></a>                  
                  <h2 class="text-danger"> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                  <u>Unauthorized</u> </h2>
                  <h3 class="text-danger">It appears that you dont have permission to access this page. Please make sure you're authorized to view this content.</h3>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
