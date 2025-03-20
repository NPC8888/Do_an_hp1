<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BtnLogin.ascx.cs" Inherits="xediep.webControl.BtnLogin" %>

<style>
    .imglogin {
        background-image: url('<%= ResolveUrl("~/jpg/user.png") %>'); /* Chỉnh đường dẫn */
        background-size: contain; /* Giúp ảnh vừa vặn */
        background-repeat: no-repeat; /* Không lặp ảnh */
        background-position: center; /* Căn giữa ảnh */
    }

    .btnlogin {
        border: none;
        background: none;
        color: black;
        border: none;
        max-width: 200px;
        cursor: pointer;
        font-size: 6px;
        height: 50px;
    }


        .btnlogin:hover {
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
            transform: translateY(-2px);
        }

        .btnlogin:active {
            transform: translateY(0);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
</style>
<div style="display: block; text-align: center;">
    <img style="height: 20px" src="../jpg/user.png" />
    <br />
    <button style="border:none;background:none;padding:0; color:black;font-weight: bold; font-size: 16px;" runat="server" id="name" onserverclick="btnProfile" >Đăng nhập</button>
</div>




<script>
    function canhan() {
        function callServer() {
            __doPostBack('btnProfile', '');
        }
    }
</script>