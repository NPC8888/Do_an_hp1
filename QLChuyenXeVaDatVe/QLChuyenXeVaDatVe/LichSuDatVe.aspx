<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="LichSuDatVe.aspx.cs" Inherits="QLChuyenXeVaDatVe.LichSuDatVe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="ticket-history">
        <h2>Lịch sử giao dịch</h2>
        <asp:Repeater ID="rptTickets" runat="server">
            <HeaderTemplate>
                <table class="ticket-table">
                    <thead>
                        <tr>
                            <th>Hóa đơn số</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Ngày lập</th>
                            <th>Chi tiết     </th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr data-key='<%# Eval("MaHoaDon") %>'>
                    <td><%# Eval("MaHoaDon") %></td>
                    <td><%# Eval("TongTien") %></td>
                    <td><%# Eval("TrangThai") %></td>
                    <td><%# Eval("ThoiGianThanhToan") %></td>
                    <td>
                        <button class="btn-view" type="button" onclick="Chitiet(<%# Eval("MaHoaDon")%>)">
                            Xem
                        </button>
                    </td>
                </tr>
            </ItemTemplate>

            <FooterTemplate>
                </tbody>
            </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>
    <style>
        .ticket-history {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .ticket-table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

            .ticket-table th, .ticket-table td {
                padding: 10px;
                border-bottom: 2px solid #ddd;
            }

            .ticket-table th {
                background: #c4c1c1;
                color: black;
            }

        .btn-view {
            background-color: white; /* Màu xanh */
            color: black;
            border: 2px solid;
            padding: 8px 12px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
            display: flex;
            margin: 0px 40% 0px;
            gap: 5px;
        }

            .btn-view:hover {
                background-color: gainsboro; /* Màu xanh đậm hơn khi hover */
            }
    </style>
    <script>
        function Chitiet(id) {
            window.location.href = `TrangChiTietHoaDon.aspx?id=${id}`;

        }
    </script>
</asp:Content>
