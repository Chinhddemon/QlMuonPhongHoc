package qlmph.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.repository.QLTaiKhoan.NguoiMuonPhongRepository;

@Service
public class NguoiMuonPhongService {

    @Autowired
    NguoiMuonPhongRepository nguoiMuonPhongRepository;

    @Autowired
    TaiKhoanService taiKhoanService;

    public NguoiMuonPhong layThongTin(String MaNgMPH) {
        NguoiMuonPhong nguoiMuonPhong = nguoiMuonPhongRepository.getByMaNgMPH(MaNgMPH);
        if(nguoiMuonPhong == null) {
            new Exception("Không tìm thấy thông tin người mượn phòng, MaNgMPH: " + MaNgMPH).printStackTrace();
            return null;
        }
        return nguoiMuonPhong;
    }

    public NguoiMuonPhong layThongTinTaiKhoan(String idTaiKhoan) {
        NguoiMuonPhong nguoiMuonPhong = nguoiMuonPhongRepository.getByIdTaiKhoan(taiKhoanService.chuyenDoiUuid(idTaiKhoan));
        if(nguoiMuonPhong == null) {
            new Exception("Không tìm thấy thông tin người mượn phòng, idTaiKhoan: " + taiKhoanService.chuyenDoiUuid(idTaiKhoan)).printStackTrace();
            return null;
        }
        return nguoiMuonPhong;
    }

}
