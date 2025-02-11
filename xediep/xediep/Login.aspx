<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="xediep.Login" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Login</title>
    <link rel="stylesheet" href="css/styleLogin.css">
</head>
<body>
    <div class="login-container">
      <form id="loginForm" runat="server" method="post">
    <h2>Welcome Bến Xe Điệp</h2>
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
        <a href="#">Quên Mật Khẩu?</a>
        <a href="Register.aspx">Đăng Ký</a>
    </div>
</form>

    </div>
    <script></script>
</body>
</html>

