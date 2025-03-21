<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyDanhGia.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyDanhGia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>Quản Lý Đánh Giá</h2>
        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" CssClass="btn-primary" OnClick="ThemMoi" />

        <asp:GridView ID="gvDanhGia" runat="server" AutoGenerateColumns="False" CssClass="GridViewClass"
            DataKeyNames="MaDanhGia,MaXe,MaNguoiDung,DiemDanhGia,BinhLuan"
            OnSelectedIndexChanged="gvDanhGia_SelectedIndexChanged"  BackColor="White" BorderColor="Black">
            <Columns>
                <asp:BoundField DataField="MaDanhGia" HeaderText="Mã Đánh Giá" SortExpression="MaDanhGia" />
                <asp:BoundField DataField="MaXe" HeaderText="Mã Xe" SortExpression="MaXe" />
                <asp:BoundField DataField="MaNguoiDung" HeaderText="Mã Người Dùng" SortExpression="MaNguoiDung" />
                <asp:BoundField DataField="DiemDanhGia" HeaderText="Điểm Đánh Giá" SortExpression="DiemDanhGia" />
                <asp:BoundField DataField="BinhLuan" HeaderText="Bình Luận" SortExpression="BinhLuan" />
                <asp:CommandField ShowSelectButton="True" SelectText="Chỉnh Sửa" ControlStyle-CssClass="btn-select" />
            </Columns>
        </asp:GridView>
    </div>

    <div id="popupDiv" class="popup">
        <div class="popup-content">
            <button type="button" onclick="hidePopup()" class="close-button">X</button>
            <h3>Thông Tin Đánh Giá</h3>

            <label for="txtMaDanhGia">Mã Đánh Giá:</label>
            <asp:TextBox ID="txtMaDanhGia" runat="server" CssClass="popup-input" ReadOnly="true"></asp:TextBox>

            <label for="ddlMaXe">Mã Xe:</label>
            <asp:DropDownList ID="ddlMaXe" runat="server" CssClass="popup-input"></asp:DropDownList>

            <label for="ddlMaNguoiDung">Mã Người Dùng:</label>
            <asp:DropDownList ID="ddlMaNguoiDung" runat="server" CssClass="popup-input"></asp:DropDownList>

            <label for="txtDiemDanhGia">Điểm Đánh Giá:</label>
            <asp:TextBox ID="txtDiemDanhGia" runat="server" CssClass="popup-input"></asp:TextBox>

            <label for="txtBinhLuan">Bình Luận:</label>
            <asp:TextBox ID="txtBinhLuan" runat="server" CssClass="popup-input"></asp:TextBox>

            <asp:Button ID="btnAddd" runat="server" Text="Thêm Đánh Giá" CssClass="btn-primary" OnClick="btnAdd_Click" />
            <asp:Button ID="btnFix" runat="server" Text="Lưu Thay Đổi" CssClass="btn-warning" OnClick="btnSave_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="Xóa Đánh Giá" CssClass="btn-danger" OnClick="btnDelete_Click" />
        </div>
    </div>

    <script>
        function showPopup() {
            document.getElementById("popupDiv").style.display = "block";
        }
        function hidePopup() {
            document.getElementById("popupDiv").style.display = "none";
        }
    </script>
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
</asp:Content>
