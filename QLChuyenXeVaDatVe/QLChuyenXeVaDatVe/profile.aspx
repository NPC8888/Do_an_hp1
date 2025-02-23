<%@ Page Title="" Language="C#" MasterPageFile="~/Backgroud.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="xediep.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server" EnablePageMethods="true" />
    <boby>
        <div class="container">

            <!-- Thông tin cá nhân -->
            <div class="profile-card">
                <button id="editButton" style="margin-left: 90%">🖊️</button>
                <h2>Thông tin cá nhân</h2>
                <p>
                    <strong>Họ tên:</strong>
                    <asp:Label ID="lblFullName" runat="server" />
                </p>
                <p>
                    <strong>Email:</strong>
                    <asp:Label ID="lblEmail" runat="server" />
                </p>
                <p>
                    <strong>Số điện thoại:</strong>
                    <asp:Label ID="lblPhone" runat="server" />
                </p>
            </div>

            <!-- Vé xe đã đặt -->
            <div class="ticket-history">
                <h2>Vé xe đã đặt</h2>
                <asp:Repeater ID="rptTickets" runat="server">
                    <HeaderTemplate>
                        <table class="ticket-table" border="0" cellspacing="0" cellpadding="0">
                            <thead>
                                <tr>
                                    <th>Họ Tên</th>
                                    <th>Số Điện Thoại</th>
                                    <th>Điểm đi</th>
                                    <th>Điểm đến</th>
                                    <th>Ngày đi</th>
                                    <th>Hành động</th>
                                    <th>Trạng Thái</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr data-key='<%# Eval("MaChuyenXe") %>'>
                            <td><%# Eval("HoTen") %></td>
                            <td><%# Eval("soDT") %></td>
                            <td><%# Eval("TenDiemDon") %></td>
                            <td><%# Eval("TenDiemTra") %></td>
                            <td><%# Eval("ThoiGianKhoiHanh", "{0:dd/MM/yyyy}") %></td>
                            <td>
                                <!-- Nút Hủy vé: Cho phép nếu ngày đi chưa qua và trang thái khác hủy -->
                                <button type="button"
                                    onclick='<%# Convert.ToDateTime(Eval("ThoiGianKhoiHanh")) >= DateTime.Now ? "cancelTicket(\"" + HttpUtility.JavaScriptStringEncode(Eval("MaVeXe").ToString()) + "\")" : "" %>'
                                    <%# Convert.ToDateTime(Eval("ThoiGianKhoiHanh")) >= DateTime.Now &&  Eval("TrangThai").ToString()!="Huy" ? "" : "disabled='disabled'" %>>
                                    Hủy vé
                                </button>


                                <!-- Nút Đánh giá: Cho phép nếu ngày đi đã qua -->
                                <button type="button"
                                    onclick='<%# Convert.ToDateTime(Eval("ThoiGianKhoiHanh")) < DateTime.Now  
                                              ? "evaluateTicket(\"" + HttpUtility.JavaScriptStringEncode(Eval("MaChuyenXe").ToString()) + "\", \"" 
                                              + HttpUtility.JavaScriptStringEncode(Eval("MaVeXe").ToString()) + "\")"  
                                              : "" %>'
                                    <%# Convert.ToDateTime(Eval("ThoiGianKhoiHanh")) < DateTime.Now && Eval("TrangThai").ToString()!="DDG" ? "" : "disabled='disabled'" %>>
                                    Đánh giá
                                </button>
                            </td>
                            <td><%# Eval("TrangThai").ToString()!="Huy" ? Eval("TrangThai").ToString()!= "DDG" ? "Đã Đặt" : "Đã Đánh Giá":"Đã Hủy" %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                    </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <!-- Nút Đăng xuất -->
            <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" CssClass="logout-btn"
                OnClick="btnLogout_Click" />
        </div>

        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Chỉnh sửa thông tin cá nhân</h2>

                <div class="form-group">
                    <label for="editFullName">Họ và Tên:</label>
                    <input type="text" id="editFullName" name="editFullName" runat="server" required>
                </div>
                <div class="form-group">
                    <label for="editPhone">Số Điện Thoại:</label>
                    <input type="tel" id="editPhone" name="editPhone" runat="server" required>
                </div>
                <div class="form-group">
                    <label for="editEmail">Email:</label>
                    <input type="email" id="editEmail" name="editEmail" runat="server" required>
                </div>

                <asp:Button ID="btnfix" CssClass="modern-button" runat="server" OnClick="btnFix" Text="Lưu thay đổi" />

            </div>
        </div>
        <!-- Modal đánh giá -->
        <div id="reviewModal" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4);">
            <div class="modal-content" style="background-color: #fff; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 400px; position: relative;">
                <span class="close" style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;">&times;</span>
                <h2>Đánh giá chuyến xe</h2>
                <div class="star-rating" style="font-size: 25px; margin-bottom: 10px;">
                    <span class="star" data-value="1" style="cursor: pointer;">&#9733;</span>
                    <span class="star" data-value="2" style="cursor: pointer;">&#9733;</span>
                    <span class="star" data-value="3" style="cursor: pointer;">&#9733;</span>
                    <span class="star" data-value="4" style="cursor: pointer;">&#9733;</span>
                    <span class="star" data-value="5" style="cursor: pointer;">&#9733;</span>
                </div>
                <textarea id="reviewContent" rows="4" placeholder="Nhập nội dung đánh giá..." style="width: 100%;"></textarea>
                <button type="button" id="btnSubmitReview" style="margin-top: 10px;">Gửi đánh giá</button>
            </div>
        </div>

        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f4f4;
                text-align: center;
                padding: 20px;
            }

            .container {
                width: 65%;
                margin: auto;
                background: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
            }

            .profile-card {
                padding: 20px;
                background: #3498db;
                color: white;
                border-radius: 10px;
                margin-bottom: 20px;
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
            }

                .ticket-table th, .ticket-table td {
                    padding: 10px;
                    border-bottom: 1px solid #ddd;
                }

                .ticket-table th {
                    background: #2ecc71;
                    color: white;
                }

            .logout-btn {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 20px;
                font-size: 16px;
            }

                .logout-btn:hover {
                    background: #c0392b;
                }
            /* Reset CSS */



            /* Nút hiện đại */
            .modern-button {
                background: linear-gradient(135deg, #6a11cb, #2575fc);
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

                .modern-button:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
                }

            /* Modal */

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(5px); /* Hiệu ứng mờ nền */
            }

            .modal-content {
                background: white;
                margin: 10% auto;
                padding: 25px;
                border-radius: 15px;
                width: 90%;
                max-width: 400px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                animation: slideIn 0.3s ease-out;
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

            /* Nút đóng modal */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
                transition: color 0.2s;
            }

                .close:hover {
                    color: #333;
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
            var reviewModal = document.getElementById("reviewModal");
            var closeBtn = reviewModal.querySelector(".close");
            var btnSubmitReview = document.getElementById("btnSubmitReview");
            var stars = reviewModal.querySelectorAll(".star");
            var selectedRating = 0;
            let currentTicketId = null;
            let DanhGiaId = null;// lưu mã vé hiện tại được đánh giá
            //Hàm Đánh giá
            function evaluateTicket(ma, madg) { currentTicketId = ma; DanhGiaId = madg; }
            // Hàm mở modal đánh giá
            function evaluateTicket(ma,madg) {
                currentTicketId = ma;; DanhGiaId = madg;
                var reviewModal = document.getElementById("reviewModal");
                if (!reviewModal) {
                    alert("Không tìm thấy phần tử reviewModal!");
                    return;
                }

                reviewModal.style.display = "block";

            }


            // Hàm đóng modal và reset form đánh giá
            function closeReviewModal() {
                reviewModal.style.display = "none";
                resetReviewForm();
            }

            // Hàm reset form đánh giá
            function resetReviewForm() {
                selectedRating = 0;
                stars.forEach(function (star) {
                    star.classList.remove("selected");
                    star.style.color = "#000"; // màu mặc định
                });
                document.getElementById("reviewContent").value = "";
                currentTicketId = null;
            }

            // Gán sự kiện click cho các sao để chọn số sao
            stars.forEach(function (star) {
                star.addEventListener("click", function () {
                    selectedRating = parseInt(this.getAttribute("data-value"));
                    stars.forEach(function (s) {
                        var starValue = parseInt(s.getAttribute("data-value"));
                        if (starValue <= selectedRating) {
                            s.classList.add("selected");
                            s.style.color = "gold";
                        } else {
                            s.classList.remove("selected");
                            s.style.color = "#000";
                        }
                    });
                });
            });

            // Đóng modal khi click vào dấu "x"
            closeBtn.addEventListener("click", closeReviewModal);

            // Đóng modal khi click ra ngoài khung modal
            window.addEventListener("click", function (event) {
                if (event.target == reviewModal) {
                    closeReviewModal();
                }
            });


            // Xử lý nút Gửi đánh giá
            btnSubmitReview.addEventListener("click", function () {
                var reviewContent = document.getElementById("reviewContent").value;
                if (selectedRating === 0) {
                    alert("Vui lòng chọn số sao đánh giá!");
                    return;
                }
                if (reviewContent.trim() === "") {
                    alert("Vui lòng nhập nội dung đánh giá!");
                    return;
                }
                // Xử lý gửi đánh giá (ví dụ: gọi AJAX để lưu đánh giá)
                PageMethods.DanhGiaCX(currentTicketId, selectedRating, reviewContent,DanhGiaId, function (response) {
                    alert(response);

                }, function (error) {
                    console.error(error);
                });
                location.reload(); // Reload lại trang hiện tại

                // Sau khi gửi, đóng modal
                closeReviewModal();
            });



            // Hàm được gọi khi click vào nút "Hủy vé"
            function cancelTicket(MaVe) {

                PageMethods.HuyVeById(MaVe, function (response) {
                    alert(response);
                }, function (error) {
                    alert(error)
                })
                
            }

            // Lấy các phần tử DOM
            const editButton = document.getElementById('editButton');
            const modal = document.getElementById('editModal');
            const closeButton = document.querySelector('.close');
            const editForm = document.getElementById('editForm');

            // Hiển thị modal khi nhấn nút chỉnh sửa
            editButton.addEventListener('click', (event) => {
                event.preventDefault();
                modal.style.display = 'block';
            });

            // Ẩn modal khi nhấn nút đóng (x)
            closeButton.addEventListener('click', () => {
                modal.style.display = 'none';
            });

            // Ẩn modal khi nhấn bên ngoài modal
            window.addEventListener('click', (event) => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });

            // Xử lý khi form chỉnh sửa được gửi

            function iconlgclik() {
                window.location.href = "TrangChu.aspx"
            }
         

        </script>

    </boby>
</asp:Content>
