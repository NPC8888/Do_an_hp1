<%@ Page Title="" Language="C#" MasterPageFile="~/TaiXeBackgrod.Master" AutoEventWireup="true" CodeBehind="TQuanLyChuyenDi.aspx.cs" Inherits="QLChuyenXeVaDatVe.TQuanLyChuyenDi" %>

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
            padding: 20px;
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

       

        .info {
            display: flex;
            flex-direction: column;
            gap: 10px;
            text-align: left;
            margin-bottom: 20px;
        }

            .info label {
                font-weight: 600;
                color: #555555;
                width: 120px;
                display: inline-block;
            }

        .value {
            font-weight: bold;
            color: #007BFF;
        }
    </style>
    <div class="containerr">
        <div class="container">
            <div style="display: flex; align-items: center; gap: 10px; margin: 10px">
                <div style="display: flex; align-items: center; gap: 5px;">
                    <div style="background-color: white; width: 15px; height: 15px; border: 1px solid black;"></div>
                    <p style="min-width: 50px">Ghế trống</p>
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
        <div style="max-width: 30%" class="container">
            <div class="tra-cuu-container">
                <asp:TextBox ID="txtTraCuu" runat="server" CssClass="tra-cuu-input" placeholder="Nhập mã hóa đơn..."></asp:TextBox>
                <asp:Button ID="btnTraCuu" runat="server" Text="Tra cứu" CssClass="tra-cuu-btn" OnClick="_btnTraCuu" />
            </div>
            <div id="divTraCuu" visible="false" runat="server" style="display:flex; flex-direction: column; align-items: center; text-align: left; height: auto; border: 1px solid">
                <div style="display: block">
                    <h2>Chi Tiết Hóa Đơn</h2>
                    <div class="info" id="hd">
                        <div>
                            <label>Mã Hóa Đơn:</label>
                            <asp:Label ID="lblMaHD" runat="server" CssClass="value">2</asp:Label>
                        </div>
                        <div>
                            <label>Ngày Lập:</label>
                            <asp:Label ID="lblNgayLap" runat="server" CssClass="value">24/3/2025</asp:Label>
                        </div>
                        <div>
                            <label>Tổng tiền:</label>
                            <asp:Label ID="lblTongTien" runat="server" CssClass="value">18000 VND</asp:Label>
                        </div>
                        <div>
                            <label>Trạng Thái:</label>
                            <asp:Label ID="lblTrangThai" runat="server" CssClass="value">Chưa Thanh toán</asp:Label>
                        </div>
                        <asp:Button ID="btnThanhToan" runat="server" CssClass="tra-cuu-btn" Text="Xác nhận thanh toán" OnClick="btnThanhtoan_click" />
                    </div>


                        
                </div>
               
            </div>
             <asp:Label ID="lblThongBao" runat="server" ForeColor="Red" />
            <style>
                .tra-cuu-container {
                    display: flex;
                    gap: 10px;
                    align-items: center; /* Căn giữa các phần tử con theo chiều dọc */
                    justify-content: center; /* Căn giữa các phần tử con theo chiều ngang */
                    padding: 20px;
                    border-radius: 5px;
                    background: #fff;
                    width: 100%;
                    height: 100%;
                    margin-bottom: 1%;
                }


                .tra-cuu-input {
                    padding: 8px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    outline: none;
                }

                .tra-cuu-btn {
                    background: white;
                    color: black;
                    border: 1px solid black;
                    padding: 8px 15px;
                    border-radius: 4px;
                    cursor: pointer;
                    font-weight: bold;
                    transition: 0.3s;
                }

                    .tra-cuu-btn:hover {
                        background: black;
                        color: white;
                    }
            </style>
            <h3>Danh sánh vé xe</h3>
            <asp:GridView ID="gvVeXe" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                DataKeyNames="MaDatVe">
                <Columns>

                    <asp:BoundField DataField="MaDatVe" HeaderText="Mã Vé" SortExpression="MaDatVe" />
                    <asp:BoundField DataField="soghe" HeaderText="Số Ghế" SortExpression="soghe" />
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
