package qlmph.service.user;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.TaiKhoan;
import qlmph.repository.user.TaiKhoanRepository;

@Service
public class TaiKhoanService {
    @Autowired
    private TaiKhoanRepository taiKhoanRepository;

    public TaiKhoan dangNhapKhachHang(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByTenDangNhapAndMatKhauAndRolesOfRegular(tenDangNhap, matKhau);
        // if (taiKhoan == null) {
        //     new Exception("Không tìm thấy thông tin tài khoản, username: " + tenDangNhap).printStackTrace();
        //     return null;
        // }
        return taiKhoan;
    }

    public TaiKhoan dangNhapQuanLy(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByTenDangNhapAndMatKhauAndRolesOfManager(tenDangNhap, matKhau);
        // if (taiKhoan == null) {
        //     new Exception("Không tìm thấy thông tin tài khoản, username: " + tenDangNhap).printStackTrace();
        //     return null;
        // }
        return taiKhoan;
    }

    public TaiKhoan dangNhapQuanTriVien(String tenDangNhap, String matKhau) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByTenDangNhapAndMatKhauAndRolesOfAdmin(tenDangNhap, matKhau);
        // if (taiKhoan == null) {
        //     new Exception("Không tìm thấy thông tin tài khoản, username: " + tenDangNhap).printStackTrace();
        //     return null;
        // }
        return taiKhoan;
    }

    public TaiKhoan layThongTinKhachHang(String uid) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByIdTaiKhoanAndRolesOfRegular(UUID.fromString(uid));
        if (taiKhoan == null) {
            new Exception("Không tìm thấy thông tin tài khoản, uid: " + uid).printStackTrace();
            return null;
        }
        return taiKhoan;
    }

    public TaiKhoan layThongTinQuanLy(String uid) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByIdTaiKhoanAndRolesOfManager(UUID.fromString(uid));
        if (taiKhoan == null) {
            new Exception("Không tìm thấy thông tin tài khoản, uid: " + uid).printStackTrace();
            return null;
        }
        return taiKhoan;
    }

    public TaiKhoan layThongTinQuanTriVien(String uid) {
        TaiKhoan taiKhoan = taiKhoanRepository.getByIdTaiKhoanAndRolesOfAdmin(UUID.fromString(uid));
        if (taiKhoan == null) {
            new Exception("Không tìm thấy thông tin tài khoản, uid: " + uid).printStackTrace();
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
        UUID IdTaiKhoan = UUID.fromString(uid);
        if (IdTaiKhoan == null) {
            new Exception("Không thể chuyển đổi chuỗi thành UUID.").printStackTrace();
            return null;
        }
        return IdTaiKhoan;
    }
}