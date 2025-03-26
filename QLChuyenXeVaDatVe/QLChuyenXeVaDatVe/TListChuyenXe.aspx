<%@ Page Title="" Language="C#" MasterPageFile="~/TaiXeBackgrod.Master" AutoEventWireup="true" CodeBehind="TListChuyenXe.aspx.cs" Inherits="QLChuyenXeVaDatVe.TListChuyenXe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .trip-list {
            padding: 0;
            border: 1px solid;
            background: #6aa8ec
        }

        .trip-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            color: black;
            font-weight: lighter;
           
        }



        .upcoming {
            background: yellow;
            cursor: pointer;
        }

            .upcoming:hover {
                color: white;
            }
        /* Chưa chạy - Xanh dương */
        .running {
            background: #f1c40f;
            color: black;
        }
        /* Đang chạy - Vàng */
        .completed {
            background: #95a5a6;
        }
        /* Đã chạy - Xám */
    </style>

    <div class="container">
        <h2>Danh Sách Chuyến Xe</h2>
        <div style="display: flex">
            <asp:TextBox ID="txtS" runat="server" TextMode="Date" Width="300px"></asp:TextBox>-
            <asp:TextBox ID="txtE" runat="server" TextMode="Date" Width="300px"></asp:TextBox>
            <asp:Button ID="btnTK" runat="server" Text="Thống kê" BackColor="#FF9999" BorderColor="White" OnClick="ThongKe" CssClass="upcoming" />

        </div>
        <div style="display: flex; gap: 10px; align-items: center;">
            <asp:CheckBoxList ID="cblFilters" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="slectSapXep">
                <asp:ListItem Text="Chưa chạy" Value="CC" />
                <asp:ListItem Text="Đã chạy" Value="DC" />
            </asp:CheckBoxList>

        </div>

        <div style="display: flex; gap: 20px; margin-left: 30%;">
            <div class="legend">
                <span class="color-box done"></span>Đã chạy
            </div>
            <div class="legend">
                <span class="color-box not-started"></span>Chưa chạy
            </div>
            <div class="legend">
                <span class="color-box running"></span>Đang chạy
            </div>
        </div>

        <style>
            .status {
                padding: 5px 10px;
                border-radius: 5px;
                color: white;
                font-weight: bold;
            }

            .done {
                background-color: gray;
            }

            .not-started {
                background-color: green;
            }

            .running {
                background-color: yellow;
                color: black;
            }

            /* Chú thích */
            .legend {
                display: flex;
                align-items: center;
                gap: 5px;
                font-weight: bold;
            }

            .color-box {
                width: 20px;
                height: 20px;
                border-radius: 5px;
                display: inline-block;
            }
        </style>
        <ul class="trip-list">
            <%foreach (var cx in lcx)
                {

            %>
            <li <%if (cx.TrangThai == "DangChay") {%>onclick="click_CX(<%=cx.MaCx.ToString() %>)"<%} %> class="trip-item <%if (cx.TrangThai == "DaChay")
                {  %>completed <% } %>
                <%else if (cx.TrangThai == "ChuaChay")
                { %>running
                <%}%>
                <%else
                { %> upcoming <%} %>" ><%=xediep.BLL.TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(cx.MaTuyenXe).DiemDi+"-"+xediep.BLL.TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(cx.MaTuyenXe).DiemDen %>(<%=cx.TgKhoiHanh.ToString("HH:mm-dd/MM/yyyy") %>) <span><%=cx.TrangThai %></span></li>

            <% }  %>
        </ul>
    </div>
    <script>
        function click_CX(id) {

            window.location.href = "TQuanLyChuyenDi.aspx?id=" + id;
        }
    </script>

</asp:Content>
