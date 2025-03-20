<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangKyTaiKhoan.aspx.cs" Inherits="QLChuyenXeVaDatVe.DangKyTaiKhoan" %>


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
            <asp:TextBox ID="txtHoTen" runat="server" CssClass="input-box" placeholder="Nhập họ tên..." ValidateRequestMode="Enabled" />

            <asp:Label runat="server" AssociatedControlID="txtEmail" Text="Email (cũng là tên đăng nhập):" />
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
            background: url(https://vexeonline.com/wp-content/uploads/2022/12/slider-2-1.png);
            background-size: cover; /* Hình nền phủ đầy phần tử */
            background-position: center; /* Canh giữa hình nền */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            width: 500px;
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
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById('<%= btnRegister.ClientID %>').addEventListener("click", function (event) {
               let email = document.getElementById('<%= txtEmail.ClientID %>').value.trim();
               let phone = document.getElementById('<%= txtSDT.ClientID %>').value.trim();
               let password = document.getElementById('<%= txtPassword.ClientID %>').value;
               let confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;
               let messageLabel = document.getElementById('<%= lblMessage.ClientID %>');

               let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
               let phonePattern = /^(0[2-9]{1}[0-9]{8,9})$/; // SĐT Việt Nam (10-11 số)

               if (!emailPattern.test(email)) {
                   messageLabel.innerText = "❌ Email không hợp lệ!";
                   event.preventDefault(); // Ngăn gửi form
                   return;
               }

               if (!phonePattern.test(phone)) {
                   messageLabel.innerText = "❌ Số điện thoại không hợp lệ!";
                   event.preventDefault();
                   return;
               }

               if (password.length < 8) {
                   messageLabel.innerText = "❌ Mật khẩu phải có ít nhất 8 ký tự!";
                   event.preventDefault();
                   return;
               }

               if (password !== confirmPassword) {
                   messageLabel.innerText = "❌ Mật khẩu nhập lại không khớp!";
                   event.preventDefault();
                   return;
               }

               messageLabel.innerText = ""; // Nếu hợp lệ, xóa thông báo lỗi
           });
       });
    </script>

</body>
</html>
