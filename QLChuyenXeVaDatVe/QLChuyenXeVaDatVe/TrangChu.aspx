<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="xediep.TrangChu" %>

<%@ Register Src="~/webControl/ListChuyenXe.ascx" TagPrefix="uc1" TagName="ListChuyenXe" %>
<%@ Register Src="~/webControl/ThanhTimKiem.ascx" TagPrefix="uc1" TagName="ThanhTimKiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .a {
            color: black;
            text-decoration: none;
            background-color: none;
        }


        .search-section {

            padding: 15px;
            background-color: none;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .list-section {
            background-color:none;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

            .list-section h2 {
                text-align: center;
                color: black;
            }



        footer {
            text-align: center;
            padding: 15px;
            margin-top: 20px;
            background-color: lightslategray;
            color: #ffffff;
            border-radius: 5px;
        }

            footer a {
                color: #ffcc00;
                text-decoration: none;
            }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: aliceblue;
            color: #333;
        }

        td {
            background-color: aliceblue;
            color: #555;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        button {
            background-color: #ff7f50;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }

            button:hover {
                background-color: #ff5733;
            }

        .bodye {
            background-image: url(https://carshop.vn/wp-content/uploads/2022/07/hyundai-universe-4-15466488907371579447485.jpg);
            background-size: cover; /* Hình nền phủ đầy phần tử */
            background-position: center;
        }
    </style>

    <div class="bodye">
        <div class="search-section">
            <uc1:ThanhTimKiem runat="server" ID="ThanhTimKiem" />
        </div>
    </div>
    <div class="list-section">
        <uc1:ListChuyenXe runat="server" ID="ListChuyenXe" />
    </div>
  


    <footer>
        <p>&copy; 2025 Website Bán Vé Xe. All rights reserved.</p>
        <p>Liên hệ: <a href="mailto:support@banvexe.com">support@banvexe.com</a></p>
        <p>Hotline: 1900 1234</p>
    </footer>

    <script>

</script>
</asp:Content>
