<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div style="padding: 50px; margin-left: 120px">
    <div class="container-fluid title-underline">
        <span class="font-avant" style="font-size: 15px">Pesan
        </span>
    </div>
    <div style="max-height: 2500px; overflow: auto">
        <%var userLogin = (pickkado.Entities.User)TempData["UserLogin"]; %>
        <%var NotificationList = (List<pickkado.Entities.Notification>)TempData["NotificationList"]; %>
        <%NotificationList = NotificationList.Where(a => a.UserId == userLogin.Id).ToList(); %>
        <%if(NotificationList.Count > 0) { %>
            <%foreach (var m in NotificationList)
              { %>
                <div>
                    <div style="border: 1px solid #363737; height: 120px; padding: 10px; background-color: white">
                        <input type="checkbox" style="float: left;" />
                        <img src="../../images/Shoesjackass.jpg" style="float: left; width: 120px; margin: 10px; border-radius: 50%" />
                        <table>
                            <tr>
                                <td>
                                    <div>
                                        <h4><%:m.SenderName %></h4>
                                    </div>
                                    <%:m.NotificationDate.ToString("dd/MM/yyy") %>
                                </td>
                                <td style="width: 700px; text-align: center">
                                    <h3><%:m.Title %></h3>
                                </td>
                            </tr>
                        </table>

                        <div style="float: right; padding-right: 20px">
                            <a id="show<%:m.Id %>" data-toggle="collapse" data-target="#div<%:m.Id %>" onclick="show_onClick('<%:m.Id %>')">Tampilkan
                            </a>
                        </div>
                    </div>
                    <div id="div<%:m.Id %>" class="collapse">
                        <div>
                            <div style="border: 1px solid #363737; padding: 10px">
                                <p>
                                    <%:m.Description %>
                                </p>
                                <a href="http://<%:m.Link %>" target="_blank">
                                    <%:m.Link %>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        <%} else { %>
            <div style="background-color:#F5F7F6; text-align:center; padding:20px; margin-top:5px" class="font-avant">
                Tidak Ada Pesan
            </div>
        <%} %>
    </div>
</div>

<script type="text/javascript">
    function show_onClick(transId) {
        var btnShow = document.getElementById('show' + transId);

        if ($('#div' + transId).hasClass('collapsing') == false) {
            if ($('#div' + transId).hasClass('in')) {
                btnShow.text = "Tampilkan";
            } else {
                btnShow.text = "Sembunyikan";
            }
        }
    }
</script>