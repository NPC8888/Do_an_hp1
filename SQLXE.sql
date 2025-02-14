	-- Bảng NgườiDung: Quản lý thông tin người dùng, bao gồm cả khách hàng và quản trị viên
--USE master;
--ALTER DATABASE QLChuyenXe2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--DROP DATABASE QLChuyenXe2;
Create Database QLChuyenXe
go
use QLChuyenXe;
GO



CREATE TABLE NguoiDung (
    MaNguoiDung INT PRIMARY KEY IDENTITY,
    TenDangNhap NVARCHAR(50) UNIQUE,
    MatKhau NVARCHAR(255),
    HoTen NVARCHAR(100),
    SoDienThoai NVARCHAR(15),
    Email NVARCHAR(100),
    VaiTro NVARCHAR(20), -- "KhachHang" hoặc "QuanTri"
    Token NVARCHAR(255), -- Token đăng nhập
    TokenExpiry DATETIME -- Thời gian hết hạn token
);

-- Bảng ChuyenXe: Quản lý thông tin các chuyến xe
CREATE TABLE XeKhach (
    MaXe INT PRIMARY KEY IDENTITY,
    BienSoXe NVARCHAR(20),
    LoaiXe NVARCHAR(50),
    SoChoNgoi INT
);
CREATE TABLE ChuyenXe (
    MaChuyenXe INT PRIMARY KEY IDENTITY,
    DiemDi NVARCHAR(100),
    DiemDen NVARCHAR(100),
    ThoiGianKhoiHanh DATETIME,
    ThoiGianDen DATETIME,
	price DECIMAL(10, 0),
    MaTaiXe INT, -- Liên kết với bảng NgườiDung
    MaXe INT, -- Liên kết với bảng XeKhach
    TrangThai NVARCHAR(20), -- "ConVe", "HetVe", "HoanThanh", v.v.
    FOREIGN KEY (MaTaiXe) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaXe) REFERENCES XeKhach(MaXe)
	

);
CREATE TABLE DiemDonTraKhach (
    IDDiem INT PRIMARY KEY IDENTITY(1,1),
    MaChuyenXe INT,  -- Mã chuyến xe (khóa ngoại)
    TenDiem NVARCHAR(255),  -- Tên điểm đón/trả khách
    DiaChi NVARCHAR(500),  -- Địa chỉ của điểm đón/trả khách
    LoaiDiem NVARCHAR(50),  -- Loại điểm (Đón hoặc Trả)
    ThoiGian DATETIME,  -- Thời gian đón/trả khách
    FOREIGN KEY (MaChuyenXe) REFERENCES ChuyenXe(MaChuyenXe)
);


-- Bảng XeKhach: Quản lý thông tin các xe khách


-- Bảng GheNgoi: Quản lý thông tin ghế ngồi trên các chuyến xe
CREATE TABLE GheNgoi (
    MaGhe INT PRIMARY KEY IDENTITY,
    MaChuyenXe INT, -- Liên kết với bảng ChuyenXe
    SoGhe INT,
    DaDat BIT, -- 0: Chưa đặt, 1: Đã đặt
    MaKhachHang INT, -- Liên kết với bảng NgườiDung
    ThoiGianDat DATETIME,
    FOREIGN KEY (MaChuyenXe) REFERENCES ChuyenXe(MaChuyenXe),
    FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaNguoiDung)
);

-- Bảng DatVe: Quản lý thông tin đặt vé của khách hàng
CREATE TABLE DatVe (
    MaDatVe INT PRIMARY KEY IDENTITY,
    MaKhachHang INT, -- Liên kết với bảng NgườiDung
    MaChuyenXe INT, -- Liên kết với bảng ChuyenXe
    MaGhe INT, -- Liên kết với bảng GheNgoi
    NgayDatVe DATETIME,
    TrangThai NVARCHAR(20), -- "DaDat", "HuyBo", v.v
	HoTen NVARCHAR(100),
	SoDT NVARCHAR(100),
	DiemDon int,
	DiemTra int,
	FOREIGN KEY (DiemDon) REFERENCES DiemDonTraKhach(IDDiem),
	FOREIGN KEY (DiemTra) REFERENCES DiemDonTraKhach(IDDiem),
    FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaChuyenXe) REFERENCES ChuyenXe(MaChuyenXe),
    FOREIGN KEY (MaGhe) REFERENCES GheNgoi(MaGhe)
);


-- Bảng DanhGia: Quản lý đánh giá của khách hàng về chuyến xe
CREATE TABLE DanhGia (
	MaNguoiDung Int,
    MaDanhGia INT PRIMARY KEY IDENTITY,
    MaCX INT, -- Liên kết với bảng DatVe
    DiemDanhGia INT, -- Thang điểm 1 đến 5
    BinhLuan NVARCHAR(500),
    FOREIGN KEY (MaCX) REFERENCES ChuyenXe(MaChuyenXe),
	FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

-- Bảng BaoCao: Quản lý thông tin thống kê và báo cáo
CREATE TABLE BaoCao (
    MaBaoCao INT PRIMARY KEY IDENTITY,
    LoaiBaoCao NVARCHAR(50), -- "Ngay", "Thang", "Nam", v.v.
    NgayBatDau DATETIME,
    NgayKetThuc DATETIME,
    TongSoVe INT,
    TongDoanhThu DECIMAL(18, 2)
);
go
-- Bảng NgườiDung: Thêm người dùng bao gồm cả khách hàng và quản trị viên
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, SoDienThoai, Email, VaiTro)
VALUES
('admin', 'hashed_password_admin', N'Quản Trị Viên', '0900000001', 'admin@example.com', N'QuanTri'),
('khachhang1', 'hashed_password_kh1', N'Nguyễn Văn A', '0900000002', 'nva@example.com', N'KhachHang'),
('khachhang2', 'hashed_password_kh2', N'Tran Thi B', '0900000003', 'ttb@example.com', N'KhachHang'),
('taixe1', 'hashed_password_tx1', N'Le Van C', '0900000004', 'lvc@example.com', N'TaiXe');

-- Bảng XeKhach: Thêm thông tin các xe khách
INSERT INTO XeKhach (BienSoXe, LoaiXe, SoChoNgoi)
VALUES
('51B-12345', N'Xe Giường Nằm', 40),
('51B-67890', N'Xe Ghế Ngồi', 30);


-- Bảng ChuyenXe: Thêm thông tin các chuyến xe
INSERT INTO ChuyenXe (DiemDi, DiemDen, ThoiGianKhoiHanh, ThoiGianDen, MaTaiXe, MaXe, TrangThai,price)
VALUES
(N'Cần Thơ', N'An Giang', '2025-2-12 08:00:00', '2025/2/12 10:00:00', 4, 1, N'ConVe',100000),
(N'Hà Nội', N'Hải Phòng','2025-2-12 09:00:00', '2025-2-12 11:00:00', 4, 2, N'ConVe',100000);
INSERT INTO DiemDonTraKhach (MaChuyenXe, TenDiem, DiaChi, LoaiDiem, ThoiGian)
VALUES
(8, N'Cần Thơ', N'Số 1 đường Lý Tự Trọng, TP Cần Thơ', N'Don', '2025-02-15 08:00:00'),
(8, N'Vĩnh Long', N'Số 5 đường Nguyễn Huệ, TP Vĩnh Long', N'Don', '2025-02-15 08:30:00'),
(8, N'Trà Vinh', N'Số 10 đường Trần Hưng Đạo, TP Trà Vinh', N'Don', '2025-02-15 09:00:00'),
(8, N'Sóc Trăng', N'Số 15 đường Phạm Ngọc Thạch, TP Sóc Trăng', N'Don', '2025-02-15 09:30:00'),
(8, N'Hà Nội', N'Số 12 đường Nguyễn Thái Học, Quận Ba Đình, Hà Nội', N'Tra', '2025-02-15 19:30:00');
INSERT INTO DiemDonTraKhach (MaChuyenXe, TenDiem, DiaChi, LoaiDiem, ThoiGian)
VALUES
(2, N'Đà Nẵng', N'Số 30 đường Lê Duẩn, TP Đà Nẵng', N'Don', '2025-02-16 08:00:00'),
(2, N'Quảng Nam', N'Số 20 đường Nguyễn Huệ, TP Tam Kỳ, Quảng Nam', N'Don', '2025-02-16 08:45:00'),
(2, N'Quảng Ngãi', N'Số 40 đường Trần Phú, TP Quảng Ngãi', N'Don', '2025-02-16 09:30:00'),
(2, N'Bình Định', N'Số 25 đường Trương Quang Trọng, TP Quy Nhơn, Bình Định', N'Don', '2025-02-16 10:00:00'),
(2, N'Hồ Chí Minh', N'Số 10 đường Nguyễn Văn Cừ, Quận 1, TP Hồ Chí Minh', N'Tra', '2025-02-16 18:00:00');


-- Bảng GheNgoi: Thêm thông tin ghế ngồi cho các chuyến xe
-- Giả sử mỗi xe có 40 ghế, đánh số từ 1 đến 40
-- Chuyến xe 1
INSERT INTO GheNgoi (MaChuyenXe, SoGhe, DaDat, MaKhachHang, ThoiGianDat)
VALUES
(1, 1, 0, NULL, NULL),
(1, 2, 0, NULL, NULL),
-- Thêm các ghế còn lại tương tự
(1, 40, 0, NULL, NULL);

-- Chuyến xe 2
INSERT INTO GheNgoi (MaChuyenXe, SoGhe, DaDat, MaKhachHang, ThoiGianDat)
VALUES
(2, 1, 0, NULL, NULL),
(2, 2, 0, NULL, NULL),
-- Thêm các ghế còn lại tương tự
(2, 30, 0, NULL, NULL);

-- Bảng DatVe: Thêm thông tin đặt vé của khách hàng


-- Cập nhật trạng thái ghế đã được đặt
UPDATE GheNgoi
SET DaDat = 1, MaKhachHang = 2, ThoiGianDat = '2025-01-14 10:00:00'
WHERE MaChuyenXe = 1 AND SoGhe = 1;

UPDATE GheNgoi
SET DaDat = 1, MaKhachHang = 3, ThoiGianDat = '2025-01-14 11:00:00'
WHERE MaChuyenXe = 2 AND SoGhe = 1;

-- Bảng DanhGia: Thêm đánh giá của khách hàng về chuyến xe
INSERT INTO DanhGia (MaDatVe, DiemDanhGia, BinhLuan)
VALUES
(1, 5, N'Dịch vụ tốt, xe sạch sẽ.'),
(2, 4, N'Tài xế thân thiện, nhưng xe hơi chậm.');

-- Bảng BaoCao: Thêm thông tin báo cáo doanh thu
INSERT INTO BaoCao (LoaiBaoCao, NgayBatDau, NgayKetThuc, TongSoVe, TongDoanhThu)
VALUES
(N'Ngay', '2025-01-14', '2025-01-14', 2, 500000),
(N'Thang', '2025-01-01', '2025-01-31', 50, 12500000);

INSERT INTO DanhGia (MaNguoiDung, MaCX, DiemDanhGia, BinhLuan) 
VALUES 
(1, 7, 5, N'Chuyến xe rất tốt, tài xế lái xe an toàn và thoải mái.'),
(1, 7, 4, N'Chuyến xe ok, nhưng cần cải thiện thêm về thời gian đến.'),
(1, 7, 3, N'Xe hơi cũ, có chút mùi nhưng nhìn chung chấp nhận được.'),
(1, 7, 4, N'Dịch vụ tốt, nhưng ghế hơi chật.'),
(1, 7, 5, N'Rất tuyệt vời, chuyến đi rất thoải mái, tôi sẽ đi lại.'),
(1, 8, 3, N'Xe đến trễ, tôi không hài lòng lắm.'),
(1, 8, 4, N'Chuyến xe tương đối tốt, nhưng nên kiểm tra kỹ ghế ngồi.'),
(1, 8, 2, N'Xe có vấn đề về điều hòa, cần sửa chữa.'),
(1, 8, 5, N'Xe rất sạch sẽ, tài xế thân thiện và nhiệt tình.'),
(1, 8, 4, N'Chuyến đi khá tốt, nhưng giá vé hơi cao.');


-- Kiểm tra dữ liệu đã chèn
SELECT * FROM GheNgoi ORDER BY MaChuyenXe, SoGhe;


-- Kiểm tra dữ liệu đã chèn
SELECT * FROM GheNgoi ORDER BY MaChuyenXe, SoGhe;


-- Xem dữ liệu đã chèn
SELECT * FROM DatVe;
SELECT * FROM GheNgoi;
;
select Price from ChuyenXe where MaChuyenXe=8;
-- Xem dữ liệu đã chèn
	
	SELECT 
	dv.MaDatVe,
	dv.MaChuyenXe,
    dv.HoTen, 
    dv.SoDT, 
    ddon.TenDiem AS DD, 
    dtra.TenDiem AS DT, 
    dv.NgayDatVe
FROM DatVe dv
JOIN DiemDonTraKhach ddon ON dv.DiemDon = ddon.IDDiem
JOIN DiemDonTraKhach dtra ON dv.DiemTra = dtra.IDDiem
WHERE dv.MaKhachHang = 1;
