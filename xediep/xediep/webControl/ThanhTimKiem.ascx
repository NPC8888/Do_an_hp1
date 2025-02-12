<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ThanhTimKiem.ascx.cs" Inherits="xediep.webControl.ThanhTimKiem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus Ticket Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9;
            color: #333;
        }

        .containerr {
            max-width: 1200px;
            margin: 50px auto;
            padding: 20px;
            background: #df7a23;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .btn {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }                        
        h1 {
            text-align: center;
           
            color: #fff;
        }

        .search-section {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }

        .search-section select {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

   

        .search-section button:hover {
            background: #45a049;
        }

        .results {
            margin-top: 30px;
        }

        .results p {
            padding: 10px;
            background: #f1f1f1;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
        }

    </style>
</head>
<body>
    <div class="containerr">
        <!-- Adding logo -->
        <div style="text-align: center;">
            <img src="Asscet/Icon/LgWeb.png" alt="Logo" style="max-width: 200px; height: auto;">
        </div>
        <h1>Bến Xe DNC</h1>
        
        <div class="search-section">
            
            <!-- Departure DropDownList -->
            <asp:DropDownList ID="ddlDiemDI" runat="server" style="flex: 1;">
               
            </asp:DropDownList>

            <!-- Destination DropDownList -->
            <asp:DropDownList ID="ddlDiemDen" runat="server" style="flex: 1;">
               
            </asp:DropDownList>
           <asp:TextBox ID="txtDateTime" runat="server" TextMode="Date"></asp:TextBox>
            


            <button class="btn" runat="server" onserverclick="TKChuyenXe">Tìm</button>
        </div>
        <div class="results" id="results">
            <!-- Search results will be displayed here -->
        </div>
    </div>

    <script>
      
    </script>
</body>
</html>
