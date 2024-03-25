package qlmph.services;

import qlmph.DAO.QLTaiKhoan.TaiKhoanDAO;
import qlmph.models.QLTaiKhoan.TaiKhoan;
import qlmph.utils.Converter;
import qlmph.utils.UUIDEncoderDecoder;

public class TaiKhoanService {

    public static TaiKhoan getByTenDangNhapAndMatKhau(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = TaiKhoanDAO.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);
        return taiKhoan;

    }
    public static String getUID(TaiKhoan taiKhoan) {
        return Converter.toString8Char(UUIDEncoderDecoder.encode(taiKhoan.getIdTaiKhoan().toString()));

    }
    

}