package qlmph.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.repository.QLTaiKhoan.QuanLyRepository;
import qlmph.utils.UUIDEncoderDecoder;
import qlmph.utils.ValidateObject;

@Service
public class QuanLyService {

    @Autowired
    QuanLyRepository quanLyRepository;

    public QuanLy layThongTinQuanLyDangTruc(String UIDManager, String uid) {
        if(!kiemTraThongTin(UIDManager, uid)) {
            new Exception("Thông tin quản lý không trùng khớp với hệ thống." + UIDManager + " - " + uid).printStackTrace();
            return null;
        }
        return layThongTin(uid);
    }

    public QuanLy layThongTin(String idTaiKhoan) {
        UUID IdTaiKhoan = UUID.fromString(UUIDEncoderDecoder.convertUuidString(idTaiKhoan));
        QuanLy quanLy = quanLyRepository.getByIdTaiKhoan(IdTaiKhoan);
        if (quanLy == null) {
            new Exception("Không tìm thấy thông tin quản lý: " + IdTaiKhoan).printStackTrace();
            return null;
        }
        return quanLy;
    }

    public boolean kiemTraThongTin(String UIDManager, String uid) {
        return !ValidateObject.isNullOrEmpty(UIDManager) && UIDManager.equals(uid);
    }

}
