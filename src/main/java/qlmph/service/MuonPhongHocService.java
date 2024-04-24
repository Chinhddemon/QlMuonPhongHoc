package qlmph.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.MuonPhongHoc;
import qlmph.model.NguoiMuonPhong;
import qlmph.model.QuanLy;
import qlmph.repository.QLThongTin.MuonPhongHocRepository;
import qlmph.utils.ValidateObject;

@Service
public class MuonPhongHocService {

    @Autowired
    MuonPhongHocRepository muonPhongHocRepository;

    // MARK: SingleBasicTasks

    public MuonPhongHoc layThongTin(int IdLMPH) {
        if (IdLMPH == 0) {
            new Exception("Dữ liệu rỗng.").printStackTrace();
            return null;
        }
        MuonPhongHoc muonPhongHoc = muonPhongHocRepository.getByIdLMPH(IdLMPH);
        if (muonPhongHoc == null) {
            new Exception("Không tìm thấy thông tin mượn phòng học, IdLMPH: " + IdLMPH).printStackTrace();
            return null;
        }
        return muonPhongHoc;
    }

    public MuonPhongHoc luuThongTin(String IdLMPH, NguoiMuonPhong NguoiMuonPhong, QuanLy QuanLyDuyet, String YeuCau) {
        MuonPhongHoc muonPhongHoc = muonPhongHocRepository.save(taoThongTin(NguoiMuonPhong, QuanLyDuyet, IdLMPH, YeuCau));
        if (ValidateObject.isNullOrEmpty(muonPhongHoc)) {
            new Exception("Không thể tạo thông tin mượn phòng học");
            return null;
        }
        return muonPhongHoc;
    }

    public MuonPhongHoc capNhatThongTin(MuonPhongHoc muonPhongHoc) {
        muonPhongHoc = muonPhongHocRepository.update(muonPhongHoc);
        if (ValidateObject.isNullOrEmpty(muonPhongHoc)) {
            new Exception("Không thể cập nhật thông tin mượn phòng học");
            return null;
        }
        return muonPhongHoc;
    }

    // MARK: SingleDynamicTasks

    public MuonPhongHoc capNhatThongTinTraPhong(String IdLMPH) {
        MuonPhongHoc muonPhongHoc = layThongTin(Integer.parseInt(IdLMPH));
        muonPhongHoc.setThoiGian_TPH(new Date());
        return capNhatThongTin(muonPhongHoc);
    }

    // MARK: SingleUtilTasks

    protected MuonPhongHoc taoThongTin(NguoiMuonPhong NguoiMuonPhong, QuanLy QuanLyDuyet, String IdLMPH, String YeuCau) {
        if (ValidateObject.exsistNullOrEmpty(IdLMPH, NguoiMuonPhong, QuanLyDuyet, YeuCau)) {
            new Exception("Dữ liệu không hợp lệ.").printStackTrace();
            return null;
        }
        MuonPhongHoc muonPhongHoc = new MuonPhongHoc(
                Integer.parseInt(IdLMPH),
                NguoiMuonPhong,
                QuanLyDuyet,
                new Date(),
                YeuCau);
        return muonPhongHoc;
    }

    protected MuonPhongHoc taoThongTin(NguoiMuonPhong NguoiMuonPhong, QuanLy QuanLyDuyet, String YeuCau) {
        if (ValidateObject.exsistNullOrEmpty(NguoiMuonPhong, QuanLyDuyet, YeuCau)) {
            new Exception("Dữ liệu không hợp lệ.").printStackTrace();
            return null;
        }
        MuonPhongHoc muonPhongHoc = new MuonPhongHoc(
                NguoiMuonPhong,
                QuanLyDuyet,
                new Date(),
                YeuCau);
        return muonPhongHoc;
    }
}
