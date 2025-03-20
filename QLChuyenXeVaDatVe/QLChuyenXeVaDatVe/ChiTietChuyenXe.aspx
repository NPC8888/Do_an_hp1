<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="ChiTietChuyenXe.aspx.cs" Inherits="QLChuyenXeVaDatVe.ChiTietChuyenXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .container {
            max-width: 50%;
            margin: auto;
            text-align: center;
        }

        .containerr {
            display: flex;
            max-width: 100%;
            padding:20px;
            margin: auto;
            text-align: center;
        }
        /* Cấu trúc ghế: driver, tầng 1 & tầng 2 */
        .seat-grid {
            display: grid;
            grid-template-columns: repeat( 60px);
            gap: 10px;
            justify-content: center;
            margin-bottom: 20px;
        }

        .seat-row {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }

        .seat {
            width: 40px;
            height: 40px;
            margin: 5px;
            text-align: center;
            line-height: 40px;
            background-color: #fff;
            border-radius: 5px;
            border: 2px solid;
            cursor: pointer;
        }

        .taken {
            width: 40px;
            height: 40px;
            margin: 5px;
            text-align: center;
            line-height: 40px;
            border-radius: 5px;
            cursor: pointer;
            background-color: #a59f9f;
            cursor: not-allowed;
        }


        .seat.selected {
            background-color: #3498db; /* Chỗ đang chọn */
        }
        /* Các tầng ghế có thể có khoảng cách riêng */
        .form-group label {
            font-size: 1rem;
            color: black;
            margin-bottom: 5px;
            display: block;
        }

        .form-group {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
        }
    </style>
    <div class="containerr">
        <div class="container">
            <div style="display: flex; align-items: center; gap: 30px; margin: 10px 30%">
                <div style="display: flex; align-items: center; gap: 5px;">
                    <div style="background-color: white; width: 15px; height: 15px; border: 1px solid black;"></div>
                    <p style="margin: 0;">Ghế trống</p>
                </div>

                <div style="display: flex; align-items: center; gap: 5px;">
                    <div style="background-color: gray; width: 15px; height: 15px; border: 1px solid black;"></div>
                    <p style="margin: 0;">Đã đặt</p>
                </div>
            </div>
            <div class="containerr">

                <% int soghe = 1; for (int i = 1; i <= tang; i++)
                    { %>
                <div class="container">

                    <p>Tầng<%=i %></p>
                    <div class="containerr">

                        <div class="seat-grid floor-<%=i %>">
                            <% for (int j = 1; j <= day; j++)
                                { %>
                            <div class="seat-row">
                                <% for (int k = 1; k <= ghe; k++)
                                    {
                                        if (trangThaiGhe[soghe] == "0")
                                        {  %>
                                <div class="seat" id="seat<%=i %><%=j %><%=k %>">
                                    <%=soghe %>
                                </div>
                                <% }
                                    else
                                    {  %>
                                <div class="taken">
                                    <%=soghe %>
                                </div>
                                <%} %>
                                <% soghe++;
                                    } %>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <div style="max-width: 40%" class="container">
            <asp:GridView ID="gvVeXe" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                DataKeyNames="MaDatVe">
                <Columns>
                    <asp:BoundField DataField="MaDatVe" HeaderText="Mã Vé" SortExpression="MaDatVe" />
                    <asp:BoundField DataField="MaGhe" HeaderText="Số Ghế" SortExpression="soghe" />
                    <asp:BoundField DataField="MaChuyenXe" HeaderText="Mã Chuyến Xe" SortExpression="MaChuyenXe" />
                    <asp:BoundField DataField="HoTen" HeaderText="Họ Tên" SortExpression="HoTen" />
                    <asp:BoundField DataField="SoDT" HeaderText="Số Điện Thoại" SortExpression="SoDT" />
                    <asp:BoundField DataField="NgayDat" HeaderText="Ngày Đặt Vé" SortExpression="NgayDat" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="TrangThai" HeaderText="Trạng Thái" SortExpression="TrangThai" />

                </Columns>
            </asp:GridView>
        </div>

    </div>
</asp:Content>
