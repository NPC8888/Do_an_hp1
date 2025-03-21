<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyChuyenXe.aspx.cs" Inherits="xediep.QuanLyChuyenXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>Quản Lý Chuyến Xe </h2>
        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClick="ThemMoi" CssClass="btn-primary" />
        <asp:TextBox ID="txtS" runat="server" TextMode="Date"  CssClass="date-picker" ></asp:TextBox>
        <asp:TextBox ID="txtE" runat="server" TextMode="Date" CssClass="date-picker" ></asp:TextBox>
        <asp:Button ID="btnTK" runat="server" Text="Thống kê" CssClass="btn-primary" BackColor="#FF9999" OnClick="ThongKe" />
        <!-- GridView to display Xe Khach List -->
        <asp:GridView ID="gvXeKhach" runat="server" AutoGenerateColumns="False" CssClass="GridViewClass"
            DataKeyNames="MaCX,MaTuyenXe,TgKhoiHanh,TgDen,Price,MaTaiXe,MaXe,TrangThai"
            OnSelectedIndexChanged="gvXeKhach_SelectedIndexChanged" OnRowCommand="gvHoaDon_RowCommand" BackColor="White" BorderColor="Black">
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
                <asp:TemplateField HeaderText="Xem chi tiết">
                    <ItemTemplate>
                        <asp:Button ID="btnChiTiet" runat="server" Text="Xem"
                            CommandName="ChiTiet" CommandArgument='<%# Container.DataItemIndex %>'
                            CssClass="custom-button" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>




    </div>
    <asp:ScriptManager runat="server" />
    <style>
        .custom-button {
            border: none;
            background: none;
            font-size: 20px;
            color: black;
            cursor: pointer;
        }
    </style>

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
        //cho phep gui khi co su thay doi
        document.getElementById('<%= txtTgDen.ClientID %>').setAttribute("type", "datetime-local");
        document.getElementById('<%= txtTgKhoiHanh.ClientID %>').setAttribute("type", "datetime-local");

    </script>
</asp:Content>
