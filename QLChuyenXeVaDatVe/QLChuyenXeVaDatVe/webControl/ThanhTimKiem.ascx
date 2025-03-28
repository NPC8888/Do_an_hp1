﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ThanhTimKiem.ascx.cs" Inherits="xediep.webControl.ThanhTimKiem" %>

<div class="containerr">
    <div class="logo-container">
        <img src="../jpg/logo.png" alt="Logo" class="logo">
    </div>
    <h1>Bến Xe DNC</h1>
    <div class="search-section">
        <asp:DropDownList ID="ddlDiemDI" runat="server" class="dropdown">
        </asp:DropDownList>
        <asp:DropDownList ID="ddlDiemDen" runat="server" class="dropdown">
        </asp:DropDownList>
        <asp:TextBox ID="txtDateTime" runat="server" TextMode="Date" class="date-picker"></asp:TextBox>
        <button class="btn" runat="server" onserverclick="TKChuyenXe">Tìm</button>
    </div>
    <div class="results" id="results">
    </div>
</div>

<style>
    .containerr {
        padding: 20px;
      
        border-radius: 10px;
        text-align: center;
        
    }


    .logo-container {
        text-align: center;
        margin-bottom: 10px;
    }

    .logo {
        max-width: 150px;
        height: auto;
    }

    h1 {
        font-size: 24px;
        margin-bottom: 15px;
        font-family: 'Roboto', sans-serif;
    }

    .search-section {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 15px;
        margin-bottom: 20px;
    }

    .dropdown, .date-picker {
        flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        min-width: 180px;
        max-width: 250px;
  
    }

        .dropdown:focus, .date-picker:focus {
            border-color: none;
            outline: none;
        }

    .btn {
        background-color:white;
        color:black;
        border: none;
        padding: 12px 20px;
        font-size: 16px;
        font-weight: bold;
        border-radius: 3px;
        cursor: pointer;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        min-width: 150px;
    }

    .results {
        margin-top: 20px;
        padding: 10px;
        background: #fff;
        border-radius: 5px;
       
        display: none;
    }

    @media (max-width: 768px) {
        .containerr {
            padding: 15px;
        }

        .search-section {
            flex-direction: column;
            align-items: center;
        }

        .dropdown, .date-picker, .btn {
            max-width: 100%;
        }
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('<%= txtDateTime.ClientID %>').setAttribute("min", today);
    });
</script>
