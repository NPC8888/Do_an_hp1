<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyNguoiDung.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="css/QuanLy.css">
    <div class="container">
        <h2>Quản Lý Người Dùng</h2>
        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClick="btnThemMoi_Click" CssClass="btn-primary" />
        <asp:GridView ID="gvNguoiDung" runat="server" AutoGenerateColumns="False" DataKeyNames="MaNguoiDung,TenDangNhap,MatKhau,EMai,SDT,VaiTro"
            OnSelectedIndexChanged="gvNguoiDung_SelectedIndexChanged" CssClass="GridViewClass" BackColor="#FF99FF" BorderColor="#3333FF">
            <Columns>
                <asp:BoundField DataField="MaNguoiDung" HeaderText="Mã Người Dùng" ReadOnly="True" SortExpression="MaNguoiDung" />
                <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" SortExpression="HoTen" />
                <asp:BoundField DataField="TenDangNhap" HeaderText="Tên Đăng Nhập(Email)" SortExpression="TenDangNhap"  ReadOnly="True" />
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
            <asp:TextBox ID="txtTenDangNhap" runat="server" CssClass="popup-input"  ReadOnly="True"></asp:TextBox>
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
    <script>
        function showPopup() {
            document.getElementById("popupDiv").style.display = "block";
        }

        function hidePopup() {
            document.getElementById("popupDiv").style.display = "none";
        }

    </script>
</asp:Content>
