<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="xediep.Login" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Login</title>
    <link rel="stylesheet" href="css/styleLogin.css">
</head>
<body class="obody">

    <div class="login-container">
        <form id="loginForm" runat="server" method="post">
            <h2>Welcome Bến Xe DNC</h2>
            <div class="input-group">
                <label for="username">Tên Đăng Nhập</label>
                <input type="text" id="username" name="username" runat="server" required>
            </div>
            <div class="input-group">
                <label for="password">Mật Khẩu</label>
                <input type="password" id="password" name="password" runat="server" required>
            </div>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
            <asp:Label runat="server" ID="lblMessage"></asp:Label>
            <div class="extra-links">
                <a href="DangKyTaiKhoan.aspx">Đăng Ký</a>
            </div>
        </form>

    </div>
    <style>
        .obody {
            background: url(https://vexeonline.com/wp-content/uploads/2022/12/slider-2-1.png);
            background-size: cover; /* Hình nền phủ đầy phần tử */
            background-position: center; /* Canh giữa hình nền */
            font-family: Arial, sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff;
        }
    </style>
</body>
</html>

