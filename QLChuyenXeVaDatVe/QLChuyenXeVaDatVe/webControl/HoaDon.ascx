<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HoaDon.ascx.cs" Inherits="QLChuyenXeVaDatVe.webControl.HoaDon" %>
<!-- Nút mở popup -->
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Nút mở popup -->
<asp:Button ID="btnShowPopup" runat="server" Text="Xem Hóa Đơn" CssClass="btn btn-primary mt-3" OnClientClick="showModal(); return false;" />

<!-- Popup Bootstrap -->
<div class="modal fade" id="hoaDonModal" tabindex="-1" aria-labelledby="hoaDonLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <!-- Tiêu đề -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="hoaDonLabel">Chi Tiết Hóa Đơn</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <!-- Nội dung -->
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Ngày đặt:</strong>
                            <asp:Label ID="lblNgayDat" runat="server"></asp:Label></p>
                        <p><strong>Trạng thái:</strong>
                            <asp:Label ID="lblTrangThai" runat="server" CssClass="badge bg-success"></asp:Label></p>
                    </div>
                    <div class="col-md-6 text-end">
                        <p><strong>Tổng tiền:</strong>
                            <asp:Label ID="lblTongTien" runat="server" CssClass="fw-bold text-danger"></asp:Label></p>
                    </div>
                </div>
                <hr>
                <!-- Danh sách vé -->
                <h6 class="mb-3">Danh Sách Vé Xe</h6>
                <asp:GridView ID="gvDanhSachVe" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="MaVe" HeaderText="Mã Vé" />
                        <asp:BoundField DataField="TenXe" HeaderText="Tên Xe" />
                        <asp:BoundField DataField="Gia" HeaderText="Giá Vé" />
                    </Columns>
                </asp:GridView>
            </div>
            <!-- Footer -->
            <div class="modal-footer">
                <asp:Button ID="btnDanhGia" runat="server" Text="Đánh Giá Xe" CssClass="btn btn-outline-primary" OnClick="btnDanhGia_Click" />
                <asp:Button ID="btnNhanHoaDon" runat="server" Text="Nhận Hóa Đơn Điện Tử" CssClass="btn btn-outline-success" OnClick="btnNhanHoaDon_Click" />
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript mở popup -->
<script>
    function showModal() {
        var modal = new bootstrap.Modal(document.getElementById('hoaDonModal'));
        modal.show();
    }
</script>
