<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BtnLogin.ascx.cs" Inherits="xediep.webControl.BtnLogin" %>

    <style>
        .btn {
    background: linear-gradient(to right, #6a11cb, #2575fc);
    color:black;
    border: none;
    width: 100px;
    cursor: pointer;
    font-size: 6px;
    height: 50px;
    border-radius: 30%;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    transition: all 0.3s ease;
}

    .btn:hover {
        background: linear-gradient(to right, #2575fc, #6a11cb);
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        transform: translateY(-2px);
    }

    .btn:active {
        transform: translateY(0);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }
     
        
      
       
    </style>

        <asp:Button ID="profile" CssClass="btn" Font-Size="Small"  runat="server" OnClick= "btnProfile" Text="Đăng Nhập"/>




