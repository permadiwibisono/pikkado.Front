<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<List<pickkado.Entities.TransactionGiftcardMessage>>" %>

<div style="position: fixed; background-color: rgba(10,10,10,0.6); top: 0; bottom: 0; width: 100%; height: 100%; left: 0; right: 0; z-index: 1100;">
    <div style="position: relative; width: 820px; height: 560px; background-color: white; margin: auto; transform: translateY(-50%); top: 50%;">
        <img src="../../Images/icon/close.png" style="position: absolute; top: -14px; right: -14px; cursor: pointer" id="btn-close" />

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
                                    <button id="Button1" type="button" class="btn btn-default btn-sm btn-login" disabled="disabled" onclick="setMessage('<%:m.Message %>')">Lihat Ucapan</button> 
                                    <%} else {%>
                                    <button id="btn-lihat-ucapan" type="button" class="btn btn-default btn-sm btn-login" onclick="setMessage('<%:m.Name %>', '<%:m.Message %>')">Lihat Ucapan</button> 
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
    $('#btn-close').click(function () {
        $("#popup").html('');
    });
    function setMessage(name, message){
        //alert(message);
        $('#giftcardName').text(name);
        $('#giftcardMessage').val(message);
    };
</script>