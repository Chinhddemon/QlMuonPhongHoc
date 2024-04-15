package qlmph.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.repository.QLTaiKhoan.TaiKhoanRepository;
import qlmph.model.QLTaiKhoan.TaiKhoan;
import qlmph.utils.UUIDEncoderDecoder;

@Service
public class TaiKhoanService {
    @Autowired
    TaiKhoanRepository taiKhoanRepository;

    public TaiKhoan dangNhap(String tenDangNhap, String matKhau) {
        return taiKhoanRepository.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);
    }

    public TaiKhoan layThongTin(String uid) {
        UUID IdTaiKhoan = UUID.fromString(UUIDEncoderDecoder.convertUuidString(uid));
        return taiKhoanRepository.getByIdTaiKhoan(IdTaiKhoan);
    }

    public List<TaiKhoan> xemDsThongTin(List<UUID> IdTaiKhoan) {
        return taiKhoanRepository.getListByIdTaiKhoan(IdTaiKhoan);
    }

    public List<TaiKhoan> xemDsThongTin() {
        return taiKhoanRepository.getAll();
    }

    public void themThongTin(TaiKhoan taiKhoan) {
        taiKhoanRepository.save(taiKhoan);
    }

    public void themDsThongTin(List<TaiKhoan> dsTaiKhoan) {
        taiKhoanRepository.saveAll(dsTaiKhoan);
    }

    public void suaThongTin(TaiKhoan taiKhoan) {
        taiKhoanRepository.update(taiKhoan);
    }

    public void suaDsThongTin(List<TaiKhoan> dsTaiKhoan) {
        taiKhoanRepository.updateList(dsTaiKhoan);
    }

    public void xoaThongTin(UUID taiKhoan) {
        taiKhoanRepository.delete(taiKhoan);
    }

    public void xoaDsThongTin(List<UUID> dsTaiKhoan) {
        taiKhoanRepository.deleteList(dsTaiKhoan);
    }
}