<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyNguoiDung.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>Quản Lý Người Dùng</h2>
        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClick="btnThemMoi_Click" CssClass="btn-primary" />
        <asp:TextBox ID="txtTim" runat="server" Width="20%" BorderStyle="Solid" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="btnTK" runat="server" Text="Tìm kiếm" CssClass="btn-primary" BackColor="#FF9999" OnClick="btnTimKiem" />
        <asp:GridView ID="gvNguoiDung" runat="server" AutoGenerateColumns="False" DataKeyNames="MaNguoiDung,TenDangNhap,MatKhau,EMai,SDT,VaiTro"
            OnSelectedIndexChanged="gvNguoiDung_SelectedIndexChanged" CssClass="GridViewClass" BorderColor="#0066FF">
            <Columns>
                <asp:BoundField DataField="MaNguoiDung" HeaderText="Mã Người Dùng" ReadOnly="True" SortExpression="MaNguoiDung" />
                <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" SortExpression="HoTen" />
                <asp:BoundField DataField="TenDangNhap" HeaderText="Tên Đăng Nhập(Email)" SortExpression="TenDangNhap" ReadOnly="True" />
                <asp:BoundField DataField="MatKhau" HeaderText="Mật Khẩu" SortExpression="MatKhau" />
                <asp:BoundField DataField="EMai" HeaderText="Email" SortExpression="EMai" />
                <asp:BoundField DataField="SDT" HeaderText="Số Điện Thoại" SortExpression="SDT" />
                <asp:BoundField DataField="VaiTro" HeaderText="Quyền" SortExpression="VaiTro" />
                <asp:CommandField ShowSelectButton="True" SelectText="Chỉnh sửa" ControlStyle-CssClass="btn-select" />
            </Columns>
        </asp:GridView>
    </div>

    <div id="popupDiv" class="popup" style="display: none;">
        <div class="popup-content">
            <button type="button" onclick="hidePopup()" style="margin-left: 90%; background: none; border: none; outline: none; background-image: url('/jpg/iconX.png'); background-size: contain; background-repeat: no-repeat; width: 70px; height: 70px; border: none; cursor: pointer">
            </button>
            <h3>Thông Tin Xe Khách</h3>
            <label>Mã người dùng:</label>
            <asp:TextBox ID="txtMaNguoiDung" runat="server" CssClass="popup-input" ReadOnly="true"></asp:TextBox>
            <label>Họ Tên:</label>
            <asp:TextBox ID="txtHoTen" runat="server" CssClass="popup-input"></asp:TextBox>
            <label>Tên đăng nhập:</label>
            <asp:TextBox ID="txtTenDangNhap" runat="server" CssClass="popup-input" ReadOnly="True"></asp:TextBox>
            <label>Mật Khẩu:</label>
            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="popup-input"></asp:TextBox>
            <label>Gmail:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="popup-input"></asp:TextBox>
            <label>Số điện thoai:</label>
            <asp:TextBox ID="txtSDT" runat="server" CssClass="popup-input"></asp:TextBox>
            <label>Quyền Người dùng</label>
            <asp:DropDownList ID="ddlQuyen" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>
            <asp:Button ID="btnAd" runat="server" Text="Thêm Xe Khách" OnClick="btnAdd_Click" CssClass="btn-primary" />
            <asp:Button ID="btnSave" runat="server" Text="Lưu" OnClick="btnEdit_Click" CssClass="btn-warning" />
            <asp:Button ID="btnDelete" runat="server" Text="Xóa" OnClick="btnDelete_Click" CssClass="btn-danger" />
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
            min-width: 30%;
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
