<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="xediep.TrangChu" %>

<%@ Register Src="~/webControl/ListChuyenXe.ascx" TagPrefix="uc1" TagName="ListChuyenXe" %>
<%@ Register Src="~/webControl/ThanhTimKiem.ascx" TagPrefix="uc1" TagName="ThanhTimKiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
     
        
        .header {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }
        .search-section, .list-section {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .list-section h2 {
            text-align: center;
            color: #007bff;
        }
        .clock-container {
            text-align: center;
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
            background-color: #ffcc00;
            padding: 10px;
            border-radius: 5px;
        }
        footer {
            text-align: center;
            padding: 15px;
            margin-top: 20px;
            background-color: #343a40;
            color: #ffffff;
            border-radius: 5px;
        }
        footer a {
            color: #ffcc00;
            text-decoration: none;
        }
    </style>

   
        <header class="header">
            <h1>Chào mừng đến với Hệ Thống Bán Vé Xe</h1>
        </header>
        <div class="search-section">
            <uc1:ThanhTimKiem runat="server" ID="ThanhTimKiem" />
        </div>
        <div class="list-section">
            <h2>Danh sách chuyến xe</h2>
            <uc1:ListChuyenXe runat="server" ID="ListChuyenXe" />
        </div>
    
        <div class="clock-container">
            <div id="clock"></div>
        </div>
    
    <footer>
        <p>&copy; 2025 Website Bán Vé Xe. All rights reserved.</p>
        <p>Liên hệ: <a href="mailto:support@banvexe.com">support@banvexe.com</a></p>
        <p>Hotline: 1900 1234</p>
    </footer>

    <script>
        function updateClock() {
            var now = new Date();
            var hours = now.getHours().toString().padStart(2, '0');
            var minutes = now.getMinutes().toString().padStart(2, '0');
            var seconds = now.getSeconds().toString().padStart(2, '0');
            document.getElementById('clock').innerText = hours + ':' + minutes + ':' + seconds;
        }
        setInterval(updateClock, 1000);
        updateClock();
    </script>
</asp:Content>
