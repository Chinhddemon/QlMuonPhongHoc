package qlmph.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.TaiKhoan;
import qlmph.repository.QLTaiKhoan.TaiKhoanRepository;
import qlmph.utils.UUIDEncoderDecoder;

@Service
public class TaiKhoanService {
    @Autowired
    TaiKhoanRepository taiKhoanRepository;

    public TaiKhoan dangNhap(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByTenDangNhapAndMatKhau(tenDangNhap, matKhau);
        if (taiKhoan == null) {
            new Exception("Không tìm thấy thông tin tài khoản, username and password: " + tenDangNhap + " " + matKhau)
                    .printStackTrace();
            return null;
        }
        return taiKhoan;
    }

    public TaiKhoan layThongTin(String uid) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByIdTaiKhoan(chuyenDoiUuid(uid));
        if (taiKhoan == null) {
            new Exception("Không tìm thấy thông tin tài khoản, uid: " + uid).printStackTrace();
            return null;
        }
        return taiKhoan;
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

    public UUID chuyenDoiUuid(String uid) {
        UUID IdTaiKhoan = UUID.fromString(UUIDEncoderDecoder.convertUuidString(uid));
        if (IdTaiKhoan == null) {
            new Exception("Không thể chuyển đổi chuỗi thành UUID.").printStackTrace();
            return null;
        }
        return IdTaiKhoan;
    }
}