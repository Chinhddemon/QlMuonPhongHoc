package qlmph.service.universityBorrowRoom;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBorrowRoom.MuonPhongHoc;
import qlmph.model.user.NguoiDung;
import qlmph.model.user.QuanLy;
import qlmph.repository.universityBorrowRoom.MuonPhongHocRepository;
import qlmph.utils.ValidateObject;

@Service
public class MuonPhongHocService {

    @Autowired
    MuonPhongHocRepository muonPhongHocRepository;

    // MARK: SingleBasicTasks

    public MuonPhongHoc layThongTin(int IdLichMuonPhong) {
        if (IdLichMuonPhong == 0) {
            new Exception("Dữ liệu rỗng.").printStackTrace();
            return null;
        }
        MuonPhongHoc muonPhongHoc = muonPhongHocRepository.getByIdLichMuonPhong(IdLichMuonPhong);
        if (muonPhongHoc == null) {
            new Exception("Không tìm thấy thông tin mượn phòng học, IdLichMuonPhong: " + IdLichMuonPhong).printStackTrace();
            return null;
        }
        return muonPhongHoc;
    }

    public MuonPhongHoc luuThongTin(String IdLichMuonPhong, NguoiDung NguoiDung, QuanLy QuanLyDuyet, String YeuCau) {
        MuonPhongHoc muonPhongHoc = muonPhongHocRepository.save(taoThongTin(NguoiDung, QuanLyDuyet, IdLichMuonPhong, YeuCau));
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

    public MuonPhongHoc capNhatThongTinTraPhong(String IdLichMuonPhong) {
        MuonPhongHoc muonPhongHoc = layThongTin(Integer.parseInt(IdLichMuonPhong));
        muonPhongHoc.set_ReturnAt(new Date());
        return capNhatThongTin(muonPhongHoc);
    }

    // MARK: SingleUtilTasks

    protected MuonPhongHoc taoThongTin(NguoiDung NguoiDung, QuanLy QuanLyDuyet, String IdLichMuonPhong, String YeuCau) {
        if (ValidateObject.exsistNullOrEmpty(IdLichMuonPhong, NguoiDung, QuanLyDuyet, YeuCau)) {
            new Exception("Dữ liệu không hợp lệ.").printStackTrace();
            return null;
        }
        MuonPhongHoc muonPhongHoc = new MuonPhongHoc(
                Integer.parseInt(IdLichMuonPhong),
                NguoiDung,
                QuanLyDuyet,
                new Date(),
                YeuCau);
        return muonPhongHoc;
    }

    protected MuonPhongHoc taoThongTin(NguoiDung NguoiDung, QuanLy QuanLyDuyet, String YeuCau) {
        if (ValidateObject.exsistNullOrEmpty(NguoiDung, QuanLyDuyet, YeuCau)) {
            new Exception("Dữ liệu không hợp lệ.").printStackTrace();
            return null;
        }
        MuonPhongHoc muonPhongHoc = new MuonPhongHoc(
                NguoiDung,
                QuanLyDuyet,
                new Date(),
                YeuCau);
        return muonPhongHoc;
    }

}
