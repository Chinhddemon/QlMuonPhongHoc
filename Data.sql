
GO
SET IDENTITY_INSERT [dbo].[DoiTuongNgMPH] ON 

INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [MaDoiTuongNgMPH]) VALUES (1, N'GV')
INSERT [dbo].[DoiTuongNgMPH] ([IdDoiTuongNgMPH], [MaDoiTuongNgMPH]) VALUES (2, N'SV')
SET IDENTITY_INSERT [dbo].[DoiTuongNgMPH] OFF
GO
INSERT [dbo].[DsMPH_LopHoc] ([IdLHP], [MaNgMPH], [_UpdateAt]) VALUES (2, N'GV002', CAST(N'2024-04-08T12:31:06.553' AS DateTime))
GO
INSERT [dbo].[GiangVien] ([MaGV], [ChucDanh]) VALUES (N'GV002', N'Giảng viên')
GO
SET IDENTITY_INSERT [dbo].[LichMuonPhong] ON 

INSERT [dbo].[LichMuonPhong] ([IdLMPH], [IdPH], [IdLHP], [MaQLKhoiTao], [ThoiGian_BD], [ThoiGian_KT], [MucDich], [LyDo], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (6, 1, 2, N'QL001', CAST(N'2024-04-09T10:00:00.000' AS DateTime), CAST(N'2024-04-09T12:00:00.000' AS DateTime), N'TH', N'Th?c hành', CAST(N'2024-04-08T12:25:58.670' AS DateTime), CAST(N'2024-04-08T12:25:58.670' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LichMuonPhong] OFF
GO
SET IDENTITY_INSERT [dbo].[LopHocPhan] ON 

INSERT [dbo].[LopHocPhan] ([IdLHP], [MaGVGiangDay], [MaMH], [MaLopSV], [Ngay_BD], [Ngay_KT], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (2, N'GV002', N'MH001', N'LSV002', CAST(N'2024-04-09' AS Date), CAST(N'2024-07-09' AS Date), CAST(N'2024-04-08T12:18:00.397' AS DateTime), CAST(N'2024-04-08T12:18:00.397' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[LopHocPhan] OFF
GO
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'LSV001', 2020, 2024, 1, N'Công nghệ thông tin', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'LSV002', 2019, 2023, 2, N'Kinh tế', N'CQ')
INSERT [dbo].[LopSV] ([MaLopSV], [NienKhoa_BD], [NienKhoa_KT], [MaNganh], [Khoa], [HeDaoTao]) VALUES (N'LSV003', 2018, 2022, 3, N'Toán học', N'TX')
GO
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'MH001', N'Toán', CAST(N'2024-04-07T16:26:01.740' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'MH002', N'Văn', CAST(N'2024-04-07T16:26:01.740' AS DateTime))
INSERT [dbo].[MonHoc] ([MaMH], [TenMH], [_ActiveAt]) VALUES (N'MH003', N'Lịch sử', CAST(N'2024-04-07T16:26:01.740' AS DateTime))
GO
INSERT [dbo].[MuonPhongHoc] ([IdLMPH], [MaNgMPH], [MaQLDuyet], [ThoiGian_MPH], [ThoiGian_TPH], [YeuCau]) VALUES (6, N'GV002', N'QL001', CAST(N'2024-04-08T12:27:11.520' AS DateTime), CAST(N'2024-04-08T15:00:00.000' AS DateTime), N' tổ chức buổi họp.')
GO
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'GV002', N'5c339353-434a-4cb0-8980-f6554f7009c5', 2, N'Nguyễn Thị B', N'nguyenthib@example.com', N'0123456789      ', CAST(N'1995-10-20' AS Date), 0, N'Hồ Chí Minh, Việt Nam')
INSERT [dbo].[NguoiMuonPhong] ([MaNgMPH], [IdTaiKhoan], [IdDoiTuongNgMPH], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'SV001', N'4be7a04a-4ab6-4b54-ad08-32c77698d9be', 1, N'Trần Văn A', N'tranvana@example.com', N'0987654321      ', CAST(N'1990-05-15' AS Date), 1, N'Hà Nội, Việt Nam')
GO
SET IDENTITY_INSERT [dbo].[PhongHoc] ON 

INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (1, N'PH001', 50, N'A', CAST(N'2024-04-07T16:26:01.743' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (2, N'PH002', 30, N'A', CAST(N'2024-04-07T16:26:01.743' AS DateTime))
INSERT [dbo].[PhongHoc] ([IdPH], [MaPH], [SucChua], [TinhTrang], [_ActiveAt]) VALUES (3, N'PH003', 40, N'U', CAST(N'2024-04-07T16:26:01.743' AS DateTime))
SET IDENTITY_INSERT [dbo].[PhongHoc] OFF
GO
INSERT [dbo].[QuanLy] ([MaQL], [IdTaiKhoan], [HoTen], [Email], [SDT], [NgaySinh], [GioiTinh], [DiaChi]) VALUES (N'QL001', N'08ea16ce-9257-43bc-a9a5-f66ab477b1aa', N'Nguyễn Văn A', N'nguyenvana@example.com', N'0987654321      ', CAST(N'1990-05-15' AS Date), 1, N'Hà Nội, Việt Nam')
GO
INSERT [dbo].[SinhVien] ([MaSV], [MaLopSV], [ChucVu]) VALUES (N'SV001', N'LSV001', N'LT')
GO
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'4be7a04a-4ab6-4b54-ad08-32c77698d9be', 2, N'manager4569', N'hashedpassword2                                             ', CAST(N'2024-04-07T17:05:42.753' AS DateTime), CAST(N'2024-04-07T17:05:42.753' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'5c339353-434a-4cb0-8980-f6554f7009c5', 1, N'user1237', N'hashedpassword1                                             ', CAST(N'2024-04-07T17:05:42.753' AS DateTime), CAST(N'2024-04-07T17:05:42.753' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([IdTaiKhoan], [IdVaiTro], [TenDangNhap], [MatKhau], [_CreateAt], [_UpdateAt], [_DeleteAt]) VALUES (N'08ea16ce-9257-43bc-a9a5-f66ab477b1aa', 3, N'admin7899', N'hashedpassword3                                             ', CAST(N'2024-04-07T17:05:42.753' AS DateTime), CAST(N'2024-04-07T17:05:42.753' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (3, N'Admin')
INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (2, N'Manager')
INSERT [dbo].[VaiTro] ([IdVaiTro], [MaVaiTro]) VALUES (1, N'User')
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO