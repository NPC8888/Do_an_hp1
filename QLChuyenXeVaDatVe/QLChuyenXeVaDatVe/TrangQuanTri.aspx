<%@ Page Title="" Language="C#" MasterPageFile="~/MQuanTri.Master" AutoEventWireup="true" CodeBehind="TrangQuanTri.aspx.cs" Inherits="QLChuyenXeVaDatVe.TrangQuanTri" %>

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
            width: 70%;
            max-height: 50%;
            margin: 2px auto;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(50px, 1fr));
            gap: 15px;
            margin: 5px 0;
        }

        .card {
           
            padding: 2px;
            border-radius: 8px;
            color: white;
            text-align: center;
            font-size: 13px;

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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 10px;
        }

        .chart {
            background: white;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        canvas {
            width: 100% !important;
            height: 90% !important;
        }
    </style>

    <div class="dashboard">
        <header>
            <h2>Doanh thu hôm nay:<%=DateTime.Now.Day%>/<%=DateTime.Now.Month %></h2>

        </header>

        <section class="summary">
            <div class="card blue">
                <h2><%=doanhthutheoloai[3]%> Vé</h2>
                <p>Số lượng vé</p>
            </div>
            <div class="card blue">
                <h2><%=doanhthutheoloai[2].ToString("0.##")%> VND</h2>
                <p>Tổng giá trị đơn hàng</p>
            </div>
            <div class="card cyan">
                <h2><%=doanhthutheoloai[0].ToString("0.##")%> VND</h2>
                <p>Đã thanh toán</p>
            </div>
            <div class="card orange">
                <h2><%=doanhthutheoloai[1].ToString("0.##") %> VND</h2>
                <p>Số chưa thanh toán</p>
            </div>
        </section>
        <div style="max-height:200px;">
            <section class="charts">
                <div class="chart">
                    <canvas id="barChart"></canvas>
                </div>

            </section>
        </div>
    </div>

    <script>
        // Dữ liệu từ C#
        var doanhThu24h = <%=doanhThu24h %>;



        // Biểu đồ cột - Doanh thu 24h
        // Lấy đối tượng canvas và khởi tạo biểu đồ dạng cột (bar chart)
        const ctxBar = document.getElementById('barChart').getContext('2d');

        new Chart(ctxBar, {
            type: 'bar', // Loại biểu đồ là biểu đồ cột
            data: {
                labels: Array.from({ length: 24 }, (_, i) => i + ":00"), // Nhãn trục X: 24 giờ trong ngày (00:00 - 23:00)
                datasets: [{
                    label: 'Doanh thu theo giờ (VND)', // Chú thích của dataset
                    data: doanhThu24h, // Mảng dữ liệu doanh thu theo từng giờ, đơn vị là VND
                    backgroundColor: '#2d86fa' // Màu nền của các cột
                }]
            },
            options: {
                scales: {
                    y: {
                        ticks: {
                            // Tùy chỉnh cách hiển thị giá trị trên trục Y (định dạng số tiền VND)
                            callback: function (value) {
                                return value.toLocaleString('vi-VN') + " VND";
                                // toLocaleString('vi-VN') giúp định dạng số có dấu phân cách hàng nghìn
                                // Ví dụ: 5000000 -> "5.000.000 VND"
                            }
                        }
                    }
                }
            }
        });


        // Biểu đồ tròn - Thanh toán Online vs Trực tiếp

    </script>
</asp:Content>
