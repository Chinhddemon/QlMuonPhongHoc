package qlmph.service;

import qlmph.DAO.QLTaiKhoan.VaiTroDAO;
import qlmph.model.QLTaiKhoan.TaiKhoan;
import qlmph.model.QLTaiKhoan.VaiTro;

public class VaiTroService {
	public static String checkVaiTroInTaiKhoan(TaiKhoan taiKhoan) {
		
		VaiTro vaiTro = VaiTroDAO.getByIdVaiTro(taiKhoan.getIdVaiTro());
		String tenVaiTro = vaiTro.getTenVaitro();
		if(tenVaiTro.equals("Giảng viên") 
		|| tenVaiTro.equals("Sinh viên")) return "Regular";

		else if(tenVaiTro.equals("Quản lý")) return "Manager";

		else if(tenVaiTro.equals("Admin")) return "Admin";

		return "none";
	}

}
