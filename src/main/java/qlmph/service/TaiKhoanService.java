package qlmph.service;

import qlmph.repository.QLTaiKhoan.TaiKhoanRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.TaiKhoan;

@Service
public class TaiKhoanService {
    @Autowired
    TaiKhoanRepository taiKhoanRepository;

    public TaiKhoan layThongTinTaiKhoan(String tenDangNhap, String matKhau) {
        return taiKhoanRepository.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);

    }

}