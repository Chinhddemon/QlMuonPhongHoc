package qlmph.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.repository.QLTaiKhoan.QuanLyRepository;
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
        return layThongTin(uid);
    }

    public QuanLy layThongTin(String idTaiKhoan) {
        QuanLy quanLy = quanLyRepository.getByIdTaiKhoan(taiKhoanService.chuyenDoiUuid(idTaiKhoan));
        if (quanLy == null) {
            new Exception("Không tìm thấy thông tin quản lý, uid: " + taiKhoanService.chuyenDoiUuid(idTaiKhoan)).printStackTrace();
            return null;
        }
        return quanLy;
    }

    public boolean kiemTraThongTin(String UIDManager, String uid) {
        return !ValidateObject.isNullOrEmpty(UIDManager) && UIDManager.equals(uid);
    }

}
