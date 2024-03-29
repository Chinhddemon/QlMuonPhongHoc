package qlmph.service;

import qlmph.repository.QLTaiKhoan.TaiKhoanRepository;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.TaiKhoan;

@Service
public class TaiKhoanService {
    @Autowired
    TaiKhoanRepository taiKhoanRepository;


    public TaiKhoan dangNhap(String tenDangNhap, String matKhau) {
        return taiKhoanRepository.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);

    }

    public TaiKhoan xemThongTin(UUID IdTaiKhoan) {
        return taiKhoanRepository.getByIdTaiKhoan(IdTaiKhoan);
    }

    public List<TaiKhoan> xemDsThongTin(List<UUID> IdTaiKhoan) {
        return taiKhoanRepository.getByListIdTaiKhoan(IdTaiKhoan);
    }

    public List<TaiKhoan> xemDsThongTin() {
        return taiKhoanRepository.getAll();
    }

    public void themThongTin( TaiKhoan taiKhoan) {
        taiKhoanRepository.post(taiKhoan);
    }

    public void themDsThongTin(List<TaiKhoan> dsTaiKhoan) {
        taiKhoanRepository.postAll(dsTaiKhoan);
    }

    public void suaThongTin(TaiKhoan taiKhoan) {
        taiKhoanRepository.put(taiKhoan);
    }

    public void suaDsThongTin(List<TaiKhoan> dsTaiKhoan) {
        taiKhoanRepository.putList(dsTaiKhoan);
    }

    public void xoaThongTin(TaiKhoan taiKhoan) {
        taiKhoanRepository.put(taiKhoan);
    }

    public void xoaDsThongTin(List<TaiKhoan> dsTaiKhoan) {
        taiKhoanRepository.putList(dsTaiKhoan);
    }
}