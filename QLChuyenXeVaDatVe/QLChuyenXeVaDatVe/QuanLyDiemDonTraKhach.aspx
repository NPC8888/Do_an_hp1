<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyDiemDonTraKhach.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyDiemDonTraKhach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>Quản Lý Chuyến Xe </h2>
        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClientClick="showPopup(); return false;" CssClass="btn-primary" />
        <asp:GridView ID="gvDiemDonTraKhach" runat="server" AutoGenerateColumns="False" DataKeyNames="MaDiem,TenDiem,MaTuyenXe,DiaChi,LoaiDiem"
            OnSelectedIndexChanged="gvDiemDon_SelectedIndexChanged" CssClass="table" BorderColor="#3333FF">
            <Columns>
                <asp:BoundField DataField="MaDiem" HeaderText="Mã Điểm" ReadOnly="True" SortExpression="MaDiem" />
                <asp:BoundField DataField="TenDiem" HeaderText="Tên Điểm" SortExpression="TenDiem" />
                <asp:BoundField DataField="MaTuyenXe" HeaderText="Tuyến Xe" SortExpression="MaTuyenXe" />
                <asp:BoundField DataField="DiaChi" HeaderText="Địa Chỉ" SortExpression="DiaChi" />
                <asp:BoundField DataField="LoaiDiem" HeaderText="Loại Điểm" SortExpression="LoaiDiem" />
                <asp:CommandField ShowSelectButton="True" SelectText="Chỉnh sửa" ControlStyle-CssClass="btn-select" />
            </Columns>
        </asp:GridView>
        <br />
        <div id="popupDiv" class="popup" style="display: none;">
            <div class="popup-content">
                <button type="button" onclick="hidePopup()" style="margin-left: 90%; background: none; border: none; outline: none; background-image: url('/jpg/iconX.png'); background-size: contain; background-repeat: no-repeat; width: 70px; height: 70px; border: none; cursor: pointer">
                </button>
                <h3>Thông Tin Điểm Đón/Trả</h3>
                <label>Mã Điểm:</label>
                <asp:TextBox ID="txtMaDiem" runat="server" ReadOnly="True" CssClass="popup-input"></asp:TextBox>
                <br />
                <label>Tên Điểm:</label>
                <asp:TextBox ID="txtTenDiem" runat="server" CssClass="popup-input"></asp:TextBox>
                <br />
                <label>Tuyến Đường:</label>
                <asp:DropDownList ID="ddlTuyenXe" CssClass="date-picker popup-input" runat="server">
                </asp:DropDownList>
                <label>Địa Chỉ:</label>
                <asp:TextBox ID="txtDiaChi" runat="server" CssClass="popup-input"></asp:TextBox>
                <br />
                <label>Loại Điểm:</label>
                <asp:DropDownList ID="ddlLoaiDiem" CssClass="date-picker popup-input" runat="server">
                </asp:DropDownList>
                <br />
                <asp:Button ID="Button1" runat="server" Text="Thêm" OnClick="btnAdd_Click" CssClass="btn-danger" />
                <asp:Button ID="btnFix" runat="server" Text="Cập Nhật" OnClick="btnEdit_Click" Visible="False" CssClass="btn-primary" />
                <asp:Button ID="btnDelete" runat="server" Text="Xóa" OnClick="btnDelete_Click" Visible="False" CssClass="btn-warning" />

            </div>
        </div>
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
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
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

        .selected-row {
            animation: blink 1s infinite alternate; /* Nhấp nháy */
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
