﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyTuyenXe.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyTuyenXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Quản Lý Tuyến Đường</h2>

        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClick="ThemMoi" CssClass="btn-primary" />
        <asp:TextBox ID="txtTim" runat="server" Width="20%" BorderStyle="Solid" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="btnTK" runat="server" Text="Tìm kiếm" CssClass="btn-primary" BackColor="#FF9999" OnClick="btnTim_Click" />
        <asp:GridView ID="gvTuyenXe" runat="server" AutoGenerateColumns="False" CssClass="table"
            DataKeyNames="MaTuyenXe,DiemDi,DiemDen,TrangThai"
            OnSelectedIndexChanged="gvXeKhach_SelectedIndexChanged" BorderColor="Black">
            <Columns>
                <asp:BoundField DataField="MaTuyenXe" HeaderText="Mã Tuyến Xe" SortExpression="MaTuyenXe" />
                <asp:BoundField DataField="DiemDi" HeaderText="Điểm đi" SortExpression="DiemDi" />
                <asp:BoundField DataField="DiemDen" HeaderText="Điểm đến" SortExpression="DiemDen" />
                <asp:BoundField DataField="TrangThai" HeaderText="Trạng thái" SortExpression="TrangThai" />

                <asp:CommandField
                    ShowSelectButton="True"
                    SelectText="Xem"
                    ControlStyle-CssClass="btn-select" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:ScriptManager runat="server" />

    <!-- Popup Panel -->


    <!-- Nút mở popup -->


    <!-- Popup (ẩn mặc định) -->
    <div id="popupDiv" class="popup">
        <div class="popup-content">
            <div>
                <button type="button" onclick="hidePopup()" style="margin-left: 90%; background: none; border: none; outline: none; background-image: url('/jpg/iconX.png'); background-size: contain; background-repeat: no-repeat; width: 70px; height: 70px; border: none; cursor: pointer">
                </button>
                <h3>Thông Tin Tuyến Xe Xe</h3>
            </div>


            <label for="txtMaTuyenXe">Mã Tuyến Xe:</label>
            <asp:TextBox ID="txtMaTuyenXe" runat="server" CssClass="popup-input" ReadOnly="true"></asp:TextBox>
            <label for="txtDiemDi">Điểm đi:</label>
            <asp:DropDownList ID="ddlDiemDi" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>
            <label for="txtMaTaiXe">Điểm đến:</label>
            <asp:DropDownList ID="ddlDiemDen" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>
            <label for="txtTrangThai">Trạng Thái:</label>
           <asp:DropDownList ID="ddlTrangThai" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>
            <asp:Button ID="btnAddd" runat="server" Text="Thêm Chuyến Xe" OnClick="btnAdd_Click" CssClass="btn-primary" />
            <asp:Button ID="btnFix" runat="server" Text="Lưu Thay Đổi" OnClick="btnEdit_Click" CssClass="btn-warning" />
            <asp:Button ID="btnDelete" runat="server" Text="Xóa Chuyến Xe" OnClick="btnDelete_Click" CssClass="btn-danger" />
        </div>
    </div>
    <div class="XacNhan" id="divxacnhan" runat="server">
        !Lưu ý 
        <br />
       Tuyến này có nhiều liên kết không thể xóa<br /> bạn có muốn đổi trạng thái không hoạt động không ?
        <br />
        <asp:Button ID="btnXacNhan" runat="server" Text="Xác nhận" OnClick="btnXacNhan_Click" CssClass="btn-primary" />
        <asp:Button ID="btnHuy" runat="server" Text="Hủy" OnClick="btnHuy_Click" CssClass="btn-danger" />
    </div>



    <style>
        /* CSS to style the page */
        .XacNhan {
            display: none; /* Ẩn mặc định */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
           
           border:2px solid;
            border-radius: 10px;
            z-index: 1000;
            width: 30%;
        }

        .popup {
            display: none; /* Ẩn mặc định */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            z-index: 1000;
            width: 60%;
        }

        .popup-content {
            text-align: center;
        }

        .popup-input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
        }


        .dropdown, .date-picker {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            min-width: 100%;
            transition: border-color 0.3s ease;
        }

        .btn-select {
            color: #28a745 !important;
            background-color: khaki;
            font-weight: bold;
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 4px;
            transition: 0.3s;
        }

            .btn-select:hover {
                color: #218838 !important;
            }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #ffffff;
            vertical-align: middle; /* Căn giữa nội dung theo chiều dọc */
        }

        h2 {
            color: #333;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            padding: 10px 15px;
            margin-right: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Thay đổi từ 'button' thành 'input' */
        input.btn-primary {
            background-color: #007bff;
            color: white;
        }

        input.btn-warning {
            background-color: #ffc107;
            color: white;
        }

        input.btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        table {
            width: 90%;
            margin-top: 20px;
            border-collapse: collapse;
            text-align: center; /* Căn giữa nội dung theo chiều ngang */
            vertical-align: middle; /* Căn giữa nội dung theo chiều dọc */
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f8f9fa;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        button, .table {
            margin-bottom: 20px;
        }
    </style>


    <script>
        function showPopup() {
            document.getElementById("popupDiv").style.display = "block";
        }

        function hidePopup() {
            document.getElementById("popupDiv").style.display = "none";
        }





    </script>
</asp:Content>
