package qlmph.services;

import java.util.List;
import java.util.UUID;

import qlmph.DAO.QLTaiKhoan.GiangVienDAO;
import qlmph.models.QLTaiKhoan.GiangVien;

public class GiangVienService {

	public static List<GiangVien> getAll() {

		// Danh sách để lưu trữ các thông tin chi tiết về các giảng viên
		List<GiangVien> dsGiangVien = GiangVienDAO.getAll();
		
		return dsGiangVien;
	}
	public static GiangVien getByIdGV(UUID idGV) {
		return GiangVienDAO.getByIdGV(idGV);
	}
}