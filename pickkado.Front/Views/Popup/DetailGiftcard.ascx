<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<pickkado.Entities.TransactionGiftcardMessage>>" %>

<div class="modal-dialog" style="width: 820px; max-height: 560px;">
    <div class="modal-content" style="border-radius:0;">
        <img src="../../Images/icon/close.png" class="bounce animated" style="position: absolute; top: -14px; right: -14px; cursor: pointer" id="btn-close" data-dismiss="modal" />

        <div style="width: auto; height: auto; padding: 20px">
            <div class="container-fluid title-underline" style="margin-bottom:40px">
                <span class="font-avant" style="font-size: 15px">
                    Detail Giftcard
                </span>
            </div>
            <div class="container-fluid">
                <div class="font-avant" style="font-size: 18px; padding-left:10px; margin-bottom:10px">
                    Status Ucapan
                </div>
                <div style="max-height:250px; overflow:auto">
                    <table class="table tableBrownNavy">
                    <tbody>
                        <% foreach(var m in Model)
			            {%>
			                <tr>
                                <td>
                                    <%:m.Name %>
                                </td>
                                <td>
                                    <%if(string.IsNullOrEmpty(m.Message)) { %>
                                    Belum menulis
                                    <%} else {%>
                                    Sudah menulis
                                    <%} %>
                                </td>
                                <td style="float:right">
                                    <%if(string.IsNullOrEmpty(m.Message)) { %>
                                    <button  type="button" class="btn btn-default btn-sm btn-login" disabled="disabled" value="<%:m.Message %>" onclick="ShowMessage('<%:m.Name %>',this.value);">Lihat Ucapan</button> 
                                    <%} else {%>
                                    
                                    <button  type="button" class="btn btn-default btn-sm btn-login" value="<%:m.Message %>" onclick="ShowMessage('<%:m.Name %>',this.value);">Lihat Ucapan</button> 
                                    <%} %>
                                </td>
                            </tr>    
			          <%} %>
                        <%--<%for (int i = 0; i < 10; i++)
			            {%>
			                <tr>
                                <td>
                                    Name
                                </td>
                                <td>
                                    Status
                                </td>
                            </tr>    
			          <%} %>--%>
                    </tbody>
                </table>
                </div>
                <div>
                    
                        <label id="giftcardName" class="font-avant" style="font-size: 18px"></label>
                    
                    <textarea id="giftcardMessage" class="form-control" disabled="disabled" ></textarea>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    //$('#btn-close').click(function () {
    //    $("#popup").html('');
    //});
    function ShowMessage(name,msg){
        $('#giftcardName').text(name);
        $('#giftcardMessage').val(msg);
    };
</script>