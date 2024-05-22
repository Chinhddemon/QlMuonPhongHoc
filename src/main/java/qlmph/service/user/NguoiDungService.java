package qlmph.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.NguoiDung;
import qlmph.repository.user.NguoiDungRepository;

@Service
public class NguoiDungService {

    @Autowired
    NguoiDungRepository nguoiMuonPhongRepository;

    @Autowired
    TaiKhoanService taiKhoanService;

    public NguoiDung layThongTin(String idNguoiDung) {
        NguoiDung nguoiMuonPhong = nguoiMuonPhongRepository.getByIdNguoiDung(Integer.parseInt(idNguoiDung));
        if(nguoiMuonPhong == null) {
            new Exception("Không tìm thấy thông tin người mượn phòng, idNguoiDung: " + idNguoiDung).printStackTrace();
            return null;
        }
        return nguoiMuonPhong;
    }

    public NguoiDung layThongTinTaiKhoan(String uid) {
        NguoiDung nguoiMuonPhong = nguoiMuonPhongRepository.getByIdTaiKhoan(taiKhoanService.chuyenDoiUuid(uid));
        if(nguoiMuonPhong == null) {
            new Exception("Không tìm thấy thông tin người mượn phòng, uid: " + uid).printStackTrace();
            return null;
        }
        return nguoiMuonPhong;
    }
}
