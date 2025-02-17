<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="xediep.DatVe" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chat với OpenAI</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:TextBox ID="txtInput" runat="server" Width="300px"></asp:TextBox>
        <asp:Button ID="btnSend" runat="server" Text="Gửi" OnClick="btnSend_Click" />
        <br /><br />
        <asp:Label ID="lblResponse" runat="server" ForeColor="Blue"></asp:Label>
    </form>
</body>
</html>
