package qlmph.services;

import qlmph.DAO.QLTaiKhoan.VaiTroDAO;
import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.models.QLTaiKhoan.VaiTro;

public class VaiTroService {
    public static String checkVaiTro(TaiKhoan taiKhoan) {
        VaiTro vaiTro = VaiTroDAO.getByIdVaiTro(taiKhoan.getIdVaiTro());
        String tenVaiTro = vaiTro.getTenVaitro();
        if(tenVaiTro.equals("Giảng viên") 
        || tenVaiTro.equals("Sinh viên")) return "Regular";

        else if(tenVaiTro.equals("Quản lý")) return "Manager";

        else if(tenVaiTro.equals("Admin")) return "Admin";

        return "none";
    }
}
