<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="QuanLyDiemDonTraKhach.aspx.cs" Inherits="QLChuyenXeVaDatVe.QuanLyDiemDonTraKhach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h2>Quản Lý Chuyến Xe </h2>
        <asp:Button ID="btnAdd" runat="server" Text="Thêm Mới" OnClientClick="showPopup(); return false;" CssClass="btn-primary" />
        <asp:GridView ID="gvDiemDonTraKhach" runat="server" AutoGenerateColumns="False" DataKeyNames="MaDiem,TenDiem,MaTuyenXe,DiaChi,LoaiDiem"
            OnSelectedIndexChanged="gvDiemDon_SelectedIndexChanged" CssClass="table table-striped" BackColor="#FF99FF" BorderColor="#3333FF">
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
    <link rel="stylesheet" href="css/QuanLy.css">
    <script>
        function showPopup() {
            document.getElementById("popupDiv").style.display = "block";
        }

        function hidePopup() {
            document.getElementById("popupDiv").style.display = "none";
        }





    </script>

</asp:Content>
