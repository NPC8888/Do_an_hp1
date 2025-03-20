<%@ Page Title="danhsach" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="ListChuyenXe.aspx.cs" Inherits="xediep.WebForm1" EnableEventValidation="false" %>

<%@ Register Src="~/webControl/ListChuyenXe.ascx" TagPrefix="uc1" TagName="ListChuyenXe" %>
<%@ Register Src="~/webControl/ThanhTimKiem.ascx" TagPrefix="uc1" TagName="ThanhTimKiem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bodye">
        <uc1:ThanhTimKiem runat="server" ID="ThanhTimKiem" />
    </div>
    <link rel="stylesheet" href="css/styleListCX.css">
    <div style="display: flex">
        <asp:Panel ID="pnlFilter" runat="server" CssClass="filter-panel">
            <table>
                <tr>

                    <td>
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="vd:2000 8/3..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Tìm kiếm" OnClick="btnSearch_Click" />
                        <asp:CheckBoxList ID="cblFilters" runat="server">
                            <asp:ListItem Text="Giá cao đến thấp" Value="giuongnam" />
                            <asp:ListItem Text="Giá thấp đến cao" Value="ghengo" />
                            <asp:ListItem Text="Thời gian a-z" Value="100" />
                            <asp:ListItem Text="Thời gian z-a" Value="300" />
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnApplyFilter" runat="server" OnClick="slectSapXep" Text="Áp dụng" CssClass="btn-apply" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <div style="padding: 20px; width: 100%">
            <strong><%=diemdi %></strong> <strong style="font-size: 20px">➜</strong> <strong><%=diemden %></strong>(có <strong><%=lChuyenXe.Count() %></strong> chuyến xe)
        <uc1:ListChuyenXe runat="server" ID="ListChuyenXe" />
        </div>

    </div>
    <style>
        .bodye {
            background-image: url(https://carshop.vn/wp-content/uploads/2022/07/hyundai-universe-4-15466488907371579447485.jpg);
            background-size: cover; /* Hình nền phủ đầy phần tử */
            background-position: center;
        }

        .filter-panel {
            width: 30%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }

            .filter-panel table {
                width: 100%;
            }

            .filter-panel td {
                padding: 5px 0;
            }

        .btn-apply {
            width: 100%;
            padding: 8px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</asp:Content>
