<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Transaction Detail</h4>
    </div>
    <div class="modal-body">        
        <div role="tabpanel">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#header" aria-controls="list" role="tab" data-toggle="tab">Header</a></li>
                <li role="presentation" ><a href="#userinfo" aria-controls="list" role="tab" data-toggle="tab">User info</a></li>
                <li role="presentation"><a href="#product" aria-controls="product" role="tab" data-toggle="tab">Product info</a></li>
                <li role="presentation"><a href="#package" aria-controls="package" role="tab" data-toggle="tab">Package info</a></li>
                <li role="presentation"><a href="#group" aria-controls="group" role="tab" data-toggle="tab">Member List</a></li>
                <li role="presentation"><a href="#payment" aria-controls="payment" role="tab" data-toggle="tab">Payment List</a></li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="header">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                            <div class="title">Header</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="container-fluid form-horizontal">
                                <%if (ViewBag.Transaction != null)
                                { %>                                            
                                    <%Html.RenderPartial("header", (pickkado.Entities.Transaction)ViewBag.Transaction); %>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="userinfo">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                            <div class="title">User info</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="container-fluid form-horizontal">
                                <%if (ViewBag.Transaction != null)
                                { %>                                            
                                    <%Html.RenderPartial("user", (pickkado.Entities.Transaction)ViewBag.Transaction); %>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="product">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                            <div class="title">Product info</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="container-fluid form-horizontal">
                                <%if (ViewBag.Transaction != null)
                                { %>                                            
                                    <%Html.RenderPartial("product", (pickkado.Entities.Transaction)ViewBag.Transaction); %>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="package">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                            <div class="title">Package & Giftcard info</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="container-fluid form-horizontal">
                                <%if (ViewBag.Transaction != null)
                                { %>                                            
                                    <%Html.RenderPartial("package", (pickkado.Entities.Transaction)ViewBag.Transaction); %>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="group">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                            <div class="title">Member list</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="container-fluid form-horizontal">
                                <%if (ViewBag.Transaction != null)
                                { %>                                            
                                    <%Html.RenderPartial("transaction_group", (pickkado.Entities.Transaction)ViewBag.Transaction); %>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
                <div role="tabpanel" class="tab-pane" id="payment">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                            <div class="title">Payment list</div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="container-fluid form-horizontal">
                                <%if (ViewBag.Transaction != null)
                                { %>                                            
                                    <%Html.RenderPartial("payment_list", (pickkado.Entities.Transaction)ViewBag.Transaction); %>
                                <%} %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                                                   
    </div>
    <div class="modal-footer">
    </div>
</div>