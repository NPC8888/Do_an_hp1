<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="xediep.TrangChu" %>

<%@ Register Src="~/webControl/ListChuyenXe.ascx" TagPrefix="uc1" TagName="ListChuyenXe" %>
<%@ Register Src="~/webControl/ThanhTimKiem.ascx" TagPrefix="uc1" TagName="ThanhTimKiem" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ThanhTimKiem runat="server" ID="ThanhTimKiem" />
    <uc1:ListChuyenXe runat="server" id="ListChuyenXe" />
   
        
           
   
</asp:Content>


