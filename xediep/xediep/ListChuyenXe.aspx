<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="ListChuyenXe.aspx.cs" Inherits="xediep.WebForm1" EnableEventValidation="false" %>

<%@ Register Src="~/webControl/ListChuyenXe.ascx" TagPrefix="uc1" TagName="ListChuyenXe" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
   
   
    <link rel="stylesheet" href="css/styleListCX.css">


   <div class="container">
    <asp:Repeater ID="rptChuyenXe" runat="server">
        <ItemTemplate>
            <div class="trip">
                <div class="trip-info">
                    <div class="route"><%# Eval("DDi") %> - <%# Eval("DDen") %></div>
                    <div class="details">Giờ Đi-Giờ Đến: <%# Eval("TgKhoiHanh") %> - <%# Eval("TgDen") %></div>
                </div>
                <div class="trip-price"><%# string.Format("{0:N0} VND", Eval("Price")) %></div>
               <asp:Button runat="server" CssClass="trip-btn" Text="Đặt Vé" CommandName="DatVe" CommandArgument='<%# Eval("MaCx") %>' OnClick="btnDatVe_Click" />

            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
    <uc1:ListChuyenXe runat="server" ID="ListChuyenXe" />

    
  

</asp:Content>
