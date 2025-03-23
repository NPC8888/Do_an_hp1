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
            list-style: none;
            padding: 0;
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
            cursor:pointer;
        }
        .trip-item:hover{
            color:white;
        }

        .upcoming {
            background: #58cb25;
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
        <ul class="trip-list">
            <%foreach (var cx in lcx)
                {

            %>
            <li class="trip-item <%if (cx.TrangThai == "DaChay")
                {  %>completed <% } %>
                <%else if (cx.TrangThai == "DangChay")
                { %>running<%}%> <%else
                { %> upcoming <%} %> "><%=xediep.BLL.TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(cx.MaTuyenXe).DiemDi+"-"+xediep.BLL.TuyenXeBLL.Instance.GetDiemDiDiemDenFromMaTuyenXe(cx.MaTuyenXe).DiemDen %> <span><%=cx.TrangThai %></span></li>

            <% }  %>
          
        </ul>
    </div>
</asp:Content>
