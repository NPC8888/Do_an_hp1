<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="TraCuu.aspx.cs" Inherits="QLChuyenXeVaDatVe.TraCuu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="tra-cuu-container">
        <asp:TextBox ID="txtTraCuu" runat="server" CssClass="tra-cuu-input" placeholder="Nhập mã hóa đơn..."></asp:TextBox>
        <asp:Button ID="btnTraCuu" runat="server" Text="Tra cứu" CssClass="tra-cuu-btn" OnClick="btnTraCuu_Click" />

    </div>
    <div class="tra-cuu-container">
        <asp:Label ID="lblThongBao" runat="server" ForeColor="Red"></asp:Label></div>

    <div style="display: flex; flex-direction: column; align-items: center; text-align: center; height: auto">
        <img src="jpg/HuongDan.jpeg" />

    </div>
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
            margin-bottom: 10%;
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

</asp:Content>
