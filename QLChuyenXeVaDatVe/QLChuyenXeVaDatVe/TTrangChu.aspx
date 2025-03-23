<%@ Page Title="" Language="C#" MasterPageFile="~/TaiXeBackgrod.Master" AutoEventWireup="true" CodeBehind="TTrangChu.aspx.cs" Inherits="QLChuyenXeVaDatVe.TTrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .timeline-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin: 20px auto;
           
            border: 2px solid;
        }

        .timeline {
            width: 45%;
            border-left: 4px solid #007bff;
            padding-left: 20px;
        }

        .timeline-item {
            position: relative;
            margin: 10px 0;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 5px;
            border: 1px solid;
        }

            .timeline-item::before {
                content: "";
                position: absolute;
                left: -25px;
                top: 50%;
                transform: translateY(-50%);
                width: 15px;
                height: 15px;
                background: #007bff;
                border-radius: 50%;
            }

        .event-bar {
            display: block;
            height: 25px;
         
            text-align: center;
            padding: 3px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: bold;
            margin: 3px 0;
            color: white;
        }

        .event1 {
            background-color: #28a745;
        }
        /* Xanh lá */
        .event2 {
            background-color: #dc3545;
        }
        /* Đỏ */
        .event3 {
            background-color: #ffc107;
        }
        /* Vàng */
        .event4 {
            background-color: #17a2b8;
        }

        .btnlcx {
        }

            .btnlcx:hover {
                background-color: black;
                color: white;
            }

        .btnl {
            background: none;
            cursor: pointer;
            border: none;
            border: 2px solid;
            height: 40px;
        }

            .btnl:hover {
                background-color: black;
                color: white;
            }
    </style>
    <div style="display: flex;">
        <div style="display: block; margin-top: 1%; margin-left: 2%; width: 45%; justify-content: left; border: 1px solid; padding: 0 20px 20px 20px">
            <div id="TTcanhan" style="font-family: 'Times New Roman', Times, serif; font-size: 20px; max-width: 50%">
                <p style="display: flex; height: 50px; width: 200%; align-items: center; border-block-end: 1px solid">Thông tin tài xế</p>

            </div>
            <div style="display: flex; justify-items: center; align-items: center; gap: 20px">
                <img src="jpg/user.png" style="height: 20%; width: 20%" />
                <div style="display: block; margin-left: 5%">
                    <p>Mã tài xế : <%=ng.MaNguoiDung.ToString() %></p>
                    <p>Họ tên :<%=ng.HoTen %></p>
                    <p>Gmail : <%=ng.EMai %></p>
                </div>
                <div style="display: block; margin-left: 5%">
                    <p>Vai trò : Tài xế</p>
                    <p>Số điện thoại : <%=ng.SDT %></p>
                    <p>
                </div>
            </div>
        </div>
        <div style="display: block; margin-top: 1%; margin-left: 1%; width: 45%; justify-content: left; border: 1px solid; padding: 0 20px 20px 20px">
            <div style="font-family: 'Times New Roman', Times, serif; font-size: 20px; max-width: 50%">
                <p style="display: flex; height: 50px; width: 200%; align-items: center; border-block-end: 1px solid">Tiện ích</p>

            </div>
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; height: 150px;">
                <!-- Ô 1: Hiển thị chuyến xe trong tuần -->

                <button class="btnlcx" style="background: #f1c40f; display: flex; justify-content: center; align-items: center; padding: 20px; border-radius: 10px; cursor: pointer;" runat="server" onserverclick="divTuan_click">
                    <h3>
                        <asp:Label runat="server" ID="lblTuan"></asp:Label>
                        Chuyến xe trong tuần</h3>
                </button>

                <!-- Ô 2: Hiển thị số chuyến xe đã chạy -->
                <button class="btnlcx" style="background: #38c232; display: flex; justify-content: center; align-items: center; padding: 20px; border-radius: 10px; cursor: pointer;" runat="server" onserverclick="divDaChay_click">
                    <h3>
                        <asp:Label runat="server" ID="lblThang"></asp:Label>
                        Số chuyến xe đã chạy</h3>
                </button>
            </div>
        </div>
    </div>
    <div >
        <div style="display: flex; margin-top: 1%; justify-content: center;">
            <h2>Lịch trình của bạn</h2>

        </div>
        <div style="display: flex; margin-top: 1%; justify-content: center; /* căn giữa theo chiều ngang */
    align-items: center;">
            <asp:Button runat="server" ID="btnleft" Text=" < " Font-Size="25" OnClick="btnleft_click" CssClass="btnl" />
            <asp:Label runat="server" ID="lblDate" Font-Size="XX-Large">22/2/2024</asp:Label>
            <asp:Button runat="server" ID="btnRight" Text=" > " Font-Size="25" OnClick="btnRight_click" CssClass="btnl" />
        </div>
        <div class="timeline-container">

            <!-- Cột 0h - 11h -->
            <div class="timeline">
                <h3 style="text-align: center;">⏳ 00:00 - 11:59</h3>
                <asp:Literal ID="litTimelineLeft" runat="server"></asp:Literal>
            </div>

            <!-- Cột 12h - 23h -->
            <div class="timeline">
                <h3 style="text-align: center;">⏳ 12:00 - 23:59</h3>
                <asp:Literal ID="litTimelineRight" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
    <script>
        function btnCxinTuan() {

        }
        function btnCxDaChay() {

        }
    </script>
</asp:Content>
