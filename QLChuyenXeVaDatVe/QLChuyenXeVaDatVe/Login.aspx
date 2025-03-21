<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="xediep.Login" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Login</title>

</head>
<body>
    <video class="video-bg" autoplay loop muted>
        <source src="Asscet/MP4/BG2.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>

    <div class="container">
        <div class="login-container" style="background:none;box-shadow:none; border:none; margin-bottom:30%; color:orange; font-size:15px"><h1>Welcome Bến Xe DNC</h1></div>
        <div class="login-container">
            <form id="loginForm" runat="server" method="post" style="margin-right:5px;">
                
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
    </div>


    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .video-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.5); /* Làm mờ nền */
            color: #333;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 2rem;
            width: 100%;
            max-width: 400px;
            text-align: center;
            position: relative;
            
        }

            .login-container h2 {
                margin-bottom: 1.5rem;
                font-size: 24px;
            }

        .input-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }

            .input-group label {
                display: block;
                margin-bottom: 0.5rem;
            }

            .input-group input {
                width: 100%;
                padding: 0.5rem;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

        .btn {
            width: 100%;
            background-color: white;
            color: black;
            border: 2px solid;
            padding: 10px;
            margin-top: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

            .btn:hover {
                background-color: black;
                color: white;
            }
    </style>
</body>
</html>
