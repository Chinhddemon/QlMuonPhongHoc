package qlmph.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.MuonPhongHoc;
import qlmph.repository.QLThongTin.MuonPhongHocRepository;

@Service
public class MuonPhongHocService {

    @Autowired
    MuonPhongHocRepository muonPhongHocRepository;

    @Autowired
    private NguoiMuonPhongService nguoiMuonPhongService;

    public MuonPhongHoc layThongTin(int IdLMPH) {
        return muonPhongHocRepository.getByIdLMPH(IdLMPH);
    }

    public boolean taoThongTin(String uid, QuanLy QuanLyDuyet, String IdLMPH, String YeuCau) {
        MuonPhongHoc muonPhongHoc = new MuonPhongHoc(
                Integer.parseInt(IdLMPH),
                nguoiMuonPhongService.layThongTinTaiKhoan(uid),
                QuanLyDuyet,
                new Date(),
                null,
                YeuCau);
        if (!muonPhongHocRepository.save(muonPhongHoc)) {
            new Exception("Không thể tạo thông tin mượn phòng học");
            return false;
        }
        return true;
    }

    public boolean capNhatThongTinTraPhong(String IdLMPH) {
        MuonPhongHoc muonPhongHoc = layThongTin(Integer.parseInt(IdLMPH));
        muonPhongHoc.setThoiGian_TPH(new Date());
        if (!muonPhongHocRepository.update(muonPhongHoc)) {
            new Exception("Không thể cập nhật thông tin lịch mượn phòng.").printStackTrace();
            return false;
        }
        return true;
    }
}
