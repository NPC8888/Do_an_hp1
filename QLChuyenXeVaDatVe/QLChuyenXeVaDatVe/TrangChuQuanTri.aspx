﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="TrangChuQuanTri.aspx.cs" Inherits="xediep.TrangChuQuanTri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
        }

        .dashboard {
            width: 90%;
            margin: 20px auto;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: white;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }

        .card {
            padding: 20px;
            border-radius: 8px;
            color: white;
            text-align: center;
            font-size: 18px;
        }

        .blue {
            background-color: #2d86fa;
        }

        .cyan {
            background-color: #00bcd4;
        }

        .orange {
            background-color: #ff9800;
        }

        .charts {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 15px;
        }

        .chart {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        canvas {
            width: 100% !important;
            height: 250px !important;
        }
    </style>

    <div class="dashboard">
        <header>
            <h1>CRM</h1>
            <input type="text" placeholder="Tìm kiếm tính năng, liên hệ, khách hàng">
        </header>

        <section class="summary">
            <div class="card blue">
                <h2>325</h2>
                <p>Số lượng đơn hàng</p>
            </div>
            <div class="card blue">
                <h2>825 triệu</h2>
                <p>Giá trị đơn hàng</p>
            </div>
            <div class="card cyan">
                <h2>480 triệu</h2>
                <p>Thực thu</p>
            </div>
            <div class="card orange">
                <h2>345 triệu</h2>
                <p>Số còn phải thu</p>
            </div>
        </section>

        <section class="charts">
            <div class="chart">
                <canvas id="barChart"></canvas>
            </div>
            <div class="chart">
                <canvas id="pieChart"></canvas>
            </div>
        </section>
    </div>

    <script>
        // Dữ liệu từ C#
        var doanhThu24h = <%= doanhThu24h %>;
        var thanhToanData = <%= thanhToan %>;

        // Biểu đồ cột - Doanh thu 24h
        const ctxBar = document.getElementById('barChart').getContext('2d');
        new Chart(ctxBar, {
            type: 'bar',
            data: {
                labels: Array.from({ length: 24 }, (_, i) => i + ":00"),
                datasets: [{
                    label: 'Doanh thu theo giờ (triệu)',
                    data: doanhThu24h,
                    backgroundColor: '#2d86fa'
                }]
            }
        });

        // Biểu đồ tròn - Thanh toán Online vs Trực tiếp
        const ctxPie = document.getElementById('pieChart').getContext('2d');
        new Chart(ctxPie, {
            type: 'pie',
            data: {
                labels: ['Thanh toán Online', 'Thanh toán khi lên xe'],
                datasets: [{
                    data: thanhToanData,
                    backgroundColor: ['#2d86fa', '#ff9800']
                }]
            }
        });
    </script>
</asp:Content>
