<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyChuyenXe.aspx.cs" Inherits="xediep.QuanLyChuyenXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>Quản Lý Chuyến Xe </h2>

        <!-- Form to add or edit XeKhach -->



        <asp:Button ID="btnAdd" runat="server" Text="Add Xe Khach" OnClick="btnAdd_Click" CssClass="btn-primary" />
        <asp:Button ID="btnEdit" runat="server" Text="Edit Xe Khach" OnClick="btnEdit_Click" CssClass="btn-warning" />
        <asp:Button ID="btnDelete" runat="server" Text="Delete Xe Khach" OnClick="btnDelete_Click" CssClass="btn-danger" />

        <!-- GridView to display Xe Khach List -->
        <asp:GridView ID="gvXeKhach" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
            OnSelectedIndexChanged="gvXeKhach_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="MaXe" HeaderText="Mã Xe" SortExpression="MaXe" />
                <asp:BoundField DataField="BienSoXe" HeaderText="Biển Số Xe" SortExpression="BienSoXe" />
                <asp:BoundField DataField="LoaiXe" HeaderText="Loại Xe" SortExpression="LoaiXe" />
                <asp:BoundField DataField="SoChoNgoi" HeaderText="Số Chỗ Ngồi" SortExpression="SoChoNgoi" />
                <asp:CommandField ShowSelectButton="True" SelectText="Chọn" ControlStyle-ForeColor="Green" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:ScriptManager runat="server" />

    <!-- Popup Panel -->


    <!-- Nút mở popup -->
    <asp:Button ID="Button1" runat="server" Text="Nhập Dữ Liệu" OnClientClick="showPopup(); return false;" />

    <!-- Popup (ẩn mặc định) -->
    <div id="popupDiv" class="popup">
        <div class="popup-content">
            <h3>Nhập Thông Tin</h3>

            <label for="txtName">Tên:</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="popup-input"></asp:TextBox>

            <label for="txtEmail">Email:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="popup-input"></asp:TextBox>

            <asp:Button CssClass="btn-primary" ID="btnSubmit" runat="server" Text="Gửi" OnClick="btnSubmit_Click" />
            <button type="button" onclick="hidePopup()">Đóng</button>
        </div>
    </div>


    <style>
        /* CSS to style the page */
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
            width: 300px;
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
            font-size: 16px;
            min-width: 180px;
            max-width: 250px;
            transition: border-color 0.3s ease;
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
            background-color: #ffcc00 !important; /* Màu vàng */
            color: black !important;
            font-weight: bold;
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
