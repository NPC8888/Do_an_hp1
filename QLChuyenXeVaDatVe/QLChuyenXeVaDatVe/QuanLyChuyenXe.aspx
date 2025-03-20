<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyChuyenXe.aspx.cs" Inherits="xediep.QuanLyChuyenXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>Quản Lý Chuyến Xe </h2>

        <!-- Form to add or edit XeKhach -->



        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClick="ThemMoi" CssClass="btn-primary" />
        <asp:TextBox ID="txtS" runat="server" TextMode="Date" class="date-picker"></asp:TextBox>
        <asp:TextBox ID="txtE" runat="server" TextMode="Date" class="date-picker"></asp:TextBox>
        <asp:Button ID="btnTK" runat="server" Text="Thống kê" CssClass="btn-primary" BackColor="#FF9999" />
        <!-- GridView to display Xe Khach List -->
        <asp:GridView ID="gvXeKhach" runat="server" AutoGenerateColumns="False" CssClass="GridViewClass"
            DataKeyNames="MaCX,MaTuyenXe,TgKhoiHanh,TgDen,Price,MaTaiXe,MaXe,TrangThai"
            OnSelectedIndexChanged="gvXeKhach_SelectedIndexChanged" OnRowCommand="gvHoaDon_RowCommand" BackColor="#FF99FF" BorderColor="#3333FF">
            <Columns>
                <asp:BoundField DataField="MaCX" HeaderText="Mã Chuyến xe" SortExpression="MaCX" />
                <asp:BoundField DataField="MaTuyenXe" HeaderText="Mã Tuyến" SortExpression="MaTuyenXe" />
                <asp:BoundField DataField="TgKhoiHanh" HeaderText="Thời Gian Khởi Hành" SortExpression="TgKhoiHanh" />
                <asp:BoundField DataField="TgDen" HeaderText="Thời Gian Đến" SortExpression="TgDen" />
                <asp:BoundField DataField="Price" HeaderText="Giá Vé" SortExpression="Price" />
                <asp:BoundField DataField="MaTaiXe" HeaderText="Mã Tài Xế" SortExpression="MaTaiXe" />
                <asp:BoundField DataField="MaXe" HeaderText="Mã Xe" SortExpression="MaXe" />
                <asp:BoundField DataField="TrangThai" HeaderText="Trạng Thái" SortExpression="TrangThai" />
                <asp:CommandField
                    ShowSelectButton="True"
                    SelectText="Chỉnh sửa"
                    HeaderText="Chỉnh sửa"
                    ControlStyle-CssClass="btn-select" />
                <asp:ButtonField ButtonType="Button" CommandName="ChiTiet" Text="Xem" ControlStyle-BorderColor="White" FooterStyle-Width="100%" />
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
                <button type="button" onclick="hidePopup()"
                    style="margin-left: 90%; background: none; border: none; outline: none; background-image: url('/jpg/iconX.png'); background-size: contain; background-repeat: no-repeat; width: 70px; height: 70px; border: none; cursor: pointer">
                </button>
                <h3>Thông Tin Chuyến Xe</h3>
            </div>

            <label for="txtMaCX">Mã Chuyến Xe:</label>
            <asp:TextBox ID="txtMaCX" runat="server" CssClass="popup-input" ReadOnly="true"></asp:TextBox>

            <label for="txtMaTuyenXe">Mã Tuyến Xe:</label>
            <asp:DropDownList ID="ddlTuyenXe" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>


            <label for="txtTgKhoiHanh">Thời Gian Khởi Hành:</label>
            <asp:TextBox ID="txtTgKhoiHanh" runat="server" CssClass="popup-input"></asp:TextBox>


            <label for="txtTgDen">Thời Gian Đến:</label>
            <asp:TextBox ID="txtTgDen" runat="server" CssClass="popup-input"></asp:TextBox>


            <label for="txtPrice">Giá Vé:</label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="popup-input"></asp:TextBox>

            <label for="txtMaTaiXe">Tài Xế:</label>
            <asp:DropDownList ID="ddlTaiXe" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>
            <label for="txtMaTaiXe">Mã Xe:</label>
            <asp:DropDownList ID="ddlXe" CssClass="date-picker popup-input" runat="server"></asp:DropDownList>
            <label for="txtTrangThai">Trạng Thái:</label>
            <asp:TextBox ID="txtTrangThai" runat="server" CssClass="popup-input"></asp:TextBox>
            <asp:Button ID="btnAddd" runat="server" Text="Thêm Chuyến Xe" OnClick="btnAdd_Click" CssClass="btn-primary" />
            <asp:Button ID="btnFix" runat="server" Text="Lưu Thay Đổi" OnClick="btnEdit_Click" CssClass="btn-warning" />
            <asp:Button ID="btnDelete" runat="server" Text="Xóa Chuyến Xe" OnClick="btnDelete_Click" CssClass="btn-danger" />



        </div>
    </div>


    <link rel="stylesheet" href="css/QuanLy.css">


    <script>
        function showPopup() {
            document.getElementById("popupDiv").style.display = "block";
        }

        function hidePopup() {
            document.getElementById("popupDiv").style.display = "none";
        }
        //cho phep gui khi co su thay doi
        document.getElementById('<%= txtTgDen.ClientID %>').setAttribute("type", "datetime-local");
        document.getElementById('<%= txtTgKhoiHanh.ClientID %>').setAttribute("type", "datetime-local");

    </script>
</asp:Content>
