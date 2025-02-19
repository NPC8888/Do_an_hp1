<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyXeKhach.aspx.cs" Inherits="xediep.QuanLyXeKhach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <body>

        <div class="container">
            <h2>Manage Xe Khach</h2>

            <!-- Form to add or edit XeKhach -->
            <div class="form-group">
                <label for="txtBienSoXe">Biển Số Xe:</label>
                <asp:TextBox ID="txtBienSoXe" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtLoaiXe">Loại Xe:</label>
                <asp:TextBox ID="txtLoaiXe" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtSoChoNgoi">Số Chỗ Ngồi:</label>
                <asp:TextBox ID="txtSoChoNgoi" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

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
                    <asp:CommandField ShowSelectButton="True" SelectText="Edit" />
                </Columns>
            </asp:GridView>
        </div>
        <style>
            /* CSS to style the page */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
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

            button {
                padding: 10px 15px;
                margin-right: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

                button.btn-primary {
                    background-color: #007bff;
                    color: white;
                }

                button.btn-warning {
                    background-color: #ffc107;
                    color: white;
                }

                button.btn-danger {
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
        </style>
    </body>

</asp:Content>
