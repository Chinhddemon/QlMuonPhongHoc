package qlmph.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.QuanLy;
import qlmph.repository.user.QuanLyRepository;
import qlmph.utils.ValidateObject;

@Service
public class QuanLyService {

    @Autowired
    QuanLyRepository quanLyRepository;

    @Autowired
    TaiKhoanService taiKhoanService;

    public QuanLy layThongTinQuanLyDangTruc(String UIDManager, String uid) {
        if(!kiemTraThongTin(UIDManager, uid)) {
            new Exception("Thông tin quản lý không trùng khớp với hệ thống, uid: " + UIDManager + " - " + uid).printStackTrace();
            return null;
        }
        return layThongTinTaiKhoan(uid);
    }

    public QuanLy layThongTinTaiKhoan(String idTaiKhoan) {
        QuanLy quanLy = quanLyRepository.getByIdTaiKhoan(taiKhoanService.chuyenDoiUuid(idTaiKhoan));
        if (quanLy == null) {
            new Exception("Không tìm thấy thông tin quản lý, uid: " + taiKhoanService.chuyenDoiUuid(idTaiKhoan)).printStackTrace();
            return null;
        }
        return quanLy;
    }

    public boolean kiemTraTaiKhoan(String idTaiKhoan) {
        QuanLy quanLy = quanLyRepository.getByIdTaiKhoan(taiKhoanService.chuyenDoiUuid(idTaiKhoan));
        if (quanLy == null) {
            return false;
        }
        return true;
    }

    public boolean kiemTraThongTin(String UIDManager, String uid) {
        return !ValidateObject.isNullOrEmpty(UIDManager) && UIDManager.equals(uid);
    }

}
