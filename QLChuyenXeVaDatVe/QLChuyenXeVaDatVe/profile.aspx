<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="xediep.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" EnablePageMethods="true" />
    <boby>
        <div class="container">

            <!-- Thông tin cá nhân -->
            <div class="profile-card">
                <div style="width: 100%; display: flex; justify-content: flex-end;">
                    <button id="editButton"><i>Chỉnh Sửa</i></button>

                </div>
                <h2>Thông tin cá nhân</h2>
                <div>
                    <p>
                        <strong>ID:</strong>
                        <asp:Label ID="lblId" runat="server" />
                    </p>
                    <p>
                        <strong>Họ tên:</strong>
                        <asp:Label ID="lblFullName" runat="server" />
                    </p>
                    <p>
                        <strong>Số điện thoại:</strong>
                        <asp:Label ID="lblPhone" runat="server" />
                    </p>
                </div>
                <div>
                    <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" CssClass="logout-btn"
                        OnClick="btnLogout_Click" />
                    <asp:Button ID="Button1" runat="server" Text="Đổi mật khẩu" CssClass="logout-btn"
                        OnClick="doimatkhau" />
                </div>
            </div>



            <!-- Vé xe đã đặt -->
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

            <!-- Nút Đăng xuất -->

        </div>

        <div id="editModal" class="modal">
            <div class="modal-content">
                
                <button type="button" onclick="hidePopup()"
                    style="margin-left: 90%; background: none; border: none; outline: none; background-image: url('/jpg/iconX.png'); background-size: contain; background-repeat: no-repeat; width: 50px; height: 50px; border: none; cursor: pointer">
                </button>

                <div class="form-group">
                    <label for="editFullName">Họ và Tên:</label>
                    <input type="text" id="editFullName" name="editFullName" runat="server" required>
                </div>
                <div class="form-group">
                    <label for="editPhone">Số Điện Thoại:</label>
                    <input type="tel" id="editPhone" name="editPhone" runat="server" required>
                </div>

                <asp:Button ID="btnfix" CssClass="modern-button" runat="server" OnClick="btnFix" Text="Lưu thay đổi" />


            </div>
        </div>
        <!-- Modal đánh giá -->


        <style>
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

            .container {
                display: block;
                align-items: center;
                background: #80b682;
                box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
            }

            .profile-card {
                /* Hoặc kích thước phù hợp */
                border-radius: 12px;
                background-color: none;
                padding-bottom: 20px;
                display: flex;
                flex-direction: column;
                margin: 0 30% 0 30%;
                align-items: center; /* Căn giữa các phần tử con */
            }

                .profile-card p {
                    align-self: flex-start; /* Chỉ áp dụng căn trái cho chữ */
                }

            button#editButton {
                margin-top: 10px;
                align-self: flex-end; /* Đưa nút về góc phải */
                background: white;
                border: 1px solid;
                cursor: pointer;
                font-size: 18px;
            }


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

            .logout-btn {
                background: white;
                color: black;
                border: 2px solid;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 20px;
                font-size: 16px;
            }

                .logout-btn:hover {
                    background: #c0392b;
                }




            /* Nút hiện đại */
            .modern-button {
                background-color: mediumspringgreen;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
            }

            /* Modal */

            .modal {
                position: fixed;
                visibility: hidden;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(5px); /* Hiệu ứng mờ nền */
                display: flex;
                align-items: center; /* Căn giữa theo chiều dọc */
                justify-content: center; /* Căn giữa theo chiều ngang */
            }

            .modal-content {
                background: white;
                padding-bottom: 10px;
                width: 30%;
                max-width: 30%;
                display: flex;
                gap: 50px;
                flex-direction: column; /* Sắp xếp các phần tử theo cột */
                align-items: center; /* Căn giữa theo chiều ngang */
                justify-content: center; /* Căn giữa theo chiều dọc */
                text-align: center; /* Canh giữa nội dung văn bản */
            }




            @keyframes slideIn {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }

                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }


            /* Form */
            h2 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
                font-weight: 600;
            }



            label {
                display: block;
                margin-bottom: 5px;
                color: #555;
                font-weight: 500;
            }

            input[type="text"],
            input[type="tel"],
            input[type="email"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                transition: border-color 0.2s, box-shadow 0.2s;
            }

                input[type="text"]:focus,
                input[type="tel"]:focus,
                input[type="email"]:focus {
                    border-color: #6a11cb;
                    box-shadow: 0 0 8px rgba(106, 17, 203, 0.3);
                    outline: none;
                }
        </style>
        <script>

            // Lấy các phần tử DOM
            const editButton = document.getElementById('editButton');
            const modal = document.getElementById('editModal');
            const closeButton = document.querySelector('.close');
            const editForm = document.getElementById('editForm');

            function Chitiet(id) {
                window.location.href = `TrangChiTietHoaDon.aspx?id=${id}`;

            }
            // Hiển thị modal khi nhấn nút chỉnh sửa
            editButton.addEventListener('click', (event) => {
                event.preventDefault();
                modal.style.visibility = 'visible';

            });

            // Ẩn modal khi nhấn nút đóng (x)
            function hidePopup(){
                modal.style.visibility = 'hidden';
            };

            // Ẩn modal khi nhấn bên ngoài modal
            window.addEventListener('click', (event) => {
                if (event.target === modal) {
                    modal.style.visibility = 'hidden';
                }
            });

            // Xử lý khi form chỉnh sửa được gửi

            function iconlgclik() {
                window.location.href = "TrangChu.aspx"
            }


        </script>

    </boby>
</asp:Content>
