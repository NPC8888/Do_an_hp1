<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoiMatKhau.aspx.cs" Inherits="QLChuyenXeVaDatVe.DoiMatKhau" %>

<!DOCTYPE html>
<html lang="vi">
<head runat="server">
    <meta charset="UTF-8">
    <title>Đổi Mật Khẩu</title>
    <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Đổi Mật Khẩu</h2>
            <asp:Label runat="server" AssociatedControlID="txtOldPassword" Text="Tên Đăng Nhập:" />
            <asp:TextBox ID="txtName" runat="server" CssClass="input-box" placeholder="Tên Đăng Nhập" />
            <asp:Label runat="server" AssociatedControlID="txtOldPassword" Text="Mật khẩu cũ:" />
            <asp:TextBox ID="txtOldPassword" runat="server" CssClass="input-box" placeholder="Nhập mật khẩu cũ..." TextMode="Password" />

            <asp:Label runat="server" AssociatedControlID="txtNewPassword" Text="Mật khẩu mới:" />
            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="input-box" placeholder="Nhập mật khẩu mới..." TextMode="Password" />

            <asp:Label runat="server" AssociatedControlID="txtConfirmPassword" Text="Nhập lại mật khẩu mới:" />
            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-box" placeholder="Nhập lại mật khẩu mới..." TextMode="Password" />

            <asp:Button ID="btnChangePassword" runat="server" CssClass="btn" Text="Đổi Mật Khẩu" OnClick="btnChangePassword_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" ForeColor="Red" />
        </div>
    </form>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: url(https://vexeonline.com/wp-content/uploads/2022/12/slider-2-1.png);
            background-size: cover;
            background-position: center;
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
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

            .btn:hover {
                background-color: #0056b3;
            }

        .message-label {
            display: block;
            margin-top: 10px;
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById('<%= btnChangePassword.ClientID %>').addEventListener("click", function (event) {
                let oldPassword = document.getElementById('<%= txtOldPassword.ClientID %>').value.trim();
                let newPassword = document.getElementById('<%= txtNewPassword.ClientID %>').value;
                let confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>').value;
                let Name = document.getElementById('<%= txtName.ClientID %>').value;
                let messageLabel = document.getElementById('<%= lblMessage.ClientID %>');


                if (Name === "") {
                    messageLabel.innerText = "❌ Vui lòng nhập tên đăng nhập!";
                    event.preventDefault();
                    return;
                }
                if (oldPassword === "") {
                    messageLabel.innerText = "❌ Vui lòng nhập mật khẩu cũ!";
                    event.preventDefault();
                    return;
                }

                if (newPassword.length < 8) {
                    messageLabel.innerText = "❌ Mật khẩu mới phải có ít nhất 8 ký tự!";
                    event.preventDefault();
                    return;
                }

                if (newPassword !== confirmPassword) {
                    messageLabel.innerText = "❌ Mật khẩu nhập lại không khớp!";
                    event.preventDefault();
                    return;
                }

                messageLabel.innerText = "";
            });
        });
    </script>
</body>
</html>
