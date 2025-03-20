<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="QLChuyenXeVaDatVe.DangKy" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Đăng Ký Tài Khoản</h2>

            <asp:Label runat="server" AssociatedControlID="txtHoTen" Text="Họ và Tên:" />
            <asp:TextBox ID="txtHoTen" runat="server" CssClass="input-box" placeholder="Nhập họ tên..." />

            <asp:Label runat="server" AssociatedControlID="txtEmail" Text="Email:" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" placeholder="Nhập email..." TextMode="Email" />

            <asp:Label runat="server" AssociatedControlID="txtSDT" Text="Số điện thoại:" />
            <asp:TextBox ID="txtSDT" runat="server" CssClass="input-box" placeholder="Nhập số điện thoại..." TextMode="Phone" />

            <asp:Label runat="server" AssociatedControlID="txtPassword" Text="Mật khẩu:" />
            <asp:TextBox ID="txtPassword" runat="server" CssClass="input-box" placeholder="Nhập mật khẩu..." TextMode="Password" />

            <asp:Label runat="server" AssociatedControlID="txtConfirmPassword" Text="Nhập lại mật khẩu:" />
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-box" placeholder="Nhập lại mật khẩu..." TextMode="Password" />

            <asp:Button ID="btnRegister" runat="server" CssClass="btn" Text="Đăng Ký" OnClick="btnRegister_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" ForeColor="Red" />
        </div>
    </form>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            width: 350px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .input-box {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn {
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

            .btn:hover {
                background-color: #218838;
            }

        .message-label {
            display: block;
            margin-top: 10px;
        }
    </style>
</body>
</html>
