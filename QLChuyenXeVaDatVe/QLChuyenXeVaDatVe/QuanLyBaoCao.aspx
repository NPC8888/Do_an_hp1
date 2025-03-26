<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyBaoCao.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyBaoCao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <div class="container">
        <h2>Quản Lý Báo Cáo</h2>

        <asp:TextBox ID="txtTim" runat="server" Width="20%" BorderStyle="Solid" BorderWidth="3px"></asp:TextBox>
        <asp:Button ID="btnTK" runat="server" Text="Tìm kiếm" CssClass="btn-primary" BackColor="#FF9999" OnClick="btnTim_Click" />
        <asp:GridView ID="gvBaoCao" runat="server" AutoGenerateColumns="False" DataKeyNames="MaBaoCao,LoaiBaoCao,NgayBatDau,NgayKetThuc,TongDoanhThu,TongSoVe"
            CssClass="GridViewClass" BorderColor="#0066FF" OnSelectedIndexChanged="inbaocao">
            <columns>
                <asp:BoundField DataField="MaBaoCao" HeaderText="Mã Báo Cáo" ReadOnly="True" SortExpression="MaBaoCao" />
                <asp:BoundField DataField="LoaiBaoCao" HeaderText="Loại Báo Cáo" ReadOnly="True" SortExpression="LoaiBaoCao" />
                <asp:BoundField DataField="NgayBatDau" HeaderText="Ngày Bắt đầu" SortExpression="NgayBatDau" />
                <asp:BoundField DataField="NgayKetThuc" HeaderText="Ngày kết thúc" SortExpression="NgayKetThuc" />
                <asp:BoundField DataField="TongSoVe" HeaderText="Số Vé Bán Được" SortExpression="TongSoVe" />
                <asp:BoundField DataField="TongDoanhThu" HeaderText="Doanh Thu" SortExpression="TongDoanhThu" />
                <asp:CommandField ShowSelectButton="True" SelectText="📥Tải báo cáo" ControlStyle-CssClass="btn-select" />


            </columns>

        </asp:GridView>
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

</asp:Content>
