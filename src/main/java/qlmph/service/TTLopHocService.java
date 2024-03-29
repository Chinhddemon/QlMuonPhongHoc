package qlmph.service;

import java.util.ArrayList;
import java.util.List;

import qlmph.DAO.QLTaiKhoan.GiangVienDAO;
import qlmph.DAO.QLThongTin.LopHocDAO;
import qlmph.DAO.QLThongTin.MonHocDAO;
import qlmph.bean.TTLopHocBean;
import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.model.QLThongTin.LopHoc;
import qlmph.model.QLThongTin.MonHoc;

public class TTLopHocService {

	public static List<TTLopHocBean> getAll() {

		// Danh sách để lưu trữ các thông tin chi tiết về các lớp học
		List<TTLopHocBean> DsTTLopHoc = new ArrayList<>();
		
		// Danh sách lớp học được lấy từ cơ sở dữ liệu
		List<LopHoc> DsLopHoc = LopHocDAO.getAll();
		
		// Xử lý lần lượt dữ liệu của model LopHoc
		for (int i = 0; i < DsLopHoc.size(); ++i) {
			LopHoc lopHoc = DsLopHoc.get(i);
			
			// Lấy thông tin giảng viên dựa trên id giảng viên của lớp học
			GiangVien giangVien = GiangVienDAO.getByIdGV(lopHoc.getIdGVGiangDay());
			
			// Lấy thông tin môn học dựa trên mã môn học của lớp học
			MonHoc monHoc = MonHocDAO.getByMaMH(lopHoc.getMaMH());
	
			// Tạo đối tượng lớp chứa thông tin lớp học, giảng viên và môn học
			TTLopHocBean tTLopHoc = new TTLopHocBean(lopHoc, giangVien, monHoc, null);
			
			// Thêm đối tượng TTLopHoc vào danh sách
			DsTTLopHoc.add(tTLopHoc);
		}
	
		return DsTTLopHoc;
	}

	public static TTLopHocBean getIdLH(int idLH) {
		// Lấy thông tin lớp học từ mã lớp học
		LopHoc lopHoc = LopHocDAO.getByIdLH(idLH);
		
		// Lấy thông tin giảng viên dựa trên ID giảng viên của lớp học
		GiangVien giangVien = GiangVienDAO.getByIdGV(lopHoc.getIdGVGiangDay());
		
		// Lấy thông tin môn học dựa trên mã môn học của lớp học
		MonHoc monHoc = MonHocDAO.getByMaMH(lopHoc.getMaMH());
		
		// Tạo đối tượng lớp chứa thông tin lớp học, giảng viên và môn học
		TTLopHocBean tTLopHoc = new TTLopHocBean(lopHoc, giangVien, monHoc, null);
	
		// Trả về thông tin tổng hợp của lớp học
		return tTLopHoc;
	}
}