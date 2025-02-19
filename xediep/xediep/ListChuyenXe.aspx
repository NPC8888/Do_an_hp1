<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="ListChuyenXe.aspx.cs" Inherits="xediep.WebForm1" EnableEventValidation="false" %>

<%@ Register Src="~/webControl/ListChuyenXe.ascx" TagPrefix="uc1" TagName="ListChuyenXe" %>
<%@ Register Src="~/webControl/ThanhTimKiem.ascx" TagPrefix="uc1" TagName="ThanhTimKiem" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <uc1:ThanhTimKiem runat="server" ID="ThanhTimKiem" />
   
    <link rel="stylesheet" href="css/styleListCX.css">



    <uc1:ListChuyenXe runat="server" ID="ListChuyenXe" />

    <script>

    </script>
  
    
</asp:Content>
