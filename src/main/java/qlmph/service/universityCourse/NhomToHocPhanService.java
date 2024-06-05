package qlmph.service.universityCourse;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityCourse.NhomToHocPhan;
import qlmph.model.universityCourse.NhomHocPhan;
import qlmph.repository.universityCourse.NhomToHocPhanRepository;
import qlmph.service.user.GiangVienService;
import qlmph.utils.Converter;
import qlmph.utils.ValidateObject;

@Service
public class NhomToHocPhanService {

    @Autowired
    NhomToHocPhanRepository nhomToHocPhanRepository;

    @Autowired
    GiangVienService giangVienService;

    // MARK: MultiBasicTasks

    public List<NhomToHocPhan> layDanhSach() {
        List<NhomToHocPhan> nhomToHocPhans = nhomToHocPhanRepository.getAll();
        if (nhomToHocPhans == null) {
            new Exception("Không tìm thấy danh sách lớp học phần section.").printStackTrace();
            return null;
        }
        return nhomToHocPhans;
    }

    // MARK: SingleBasicTasks

    public NhomToHocPhan layThongTin(int idLHPSection) {
        NhomToHocPhan nhomToHocPhan = nhomToHocPhanRepository.getById(idLHPSection);
        if (nhomToHocPhan == null) {
            new Exception("Không tìm thấy thông tin lớp học phần section, idLHPSection: " + idLHPSection)
                .printStackTrace();
            return null;
        }
        return nhomToHocPhan;
    }

    public boolean luuThongTin(NhomToHocPhan nhomToHocPhan) {
        if (!nhomToHocPhanRepository.save(nhomToHocPhan)) {
            new Exception("Không thể tạo thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    public boolean capNhatThongTin(NhomToHocPhan nhomToHocPhan) {
        if (!nhomToHocPhanRepository.update(nhomToHocPhan)) {
            new Exception("Không thể cập nhật thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    // MARK: SingleUtilTasks

    protected NhomToHocPhan chinhSuaThongTin(NhomToHocPhan nhomToHocPhan,
        String MaGiangVien, String MucDich, String StartDate, String EndDate) {
        Date startDate = Converter.stringToDate(StartDate);
        Date endDate = Converter.stringToDate(EndDate);
        if(ValidateObject.exsistNullOrEmpty(nhomToHocPhan, MaGiangVien, MucDich) || startDate.after(endDate)) {
            if(startDate.after(endDate))
                new Exception("Ngày bắt đầu không thể sau ngày kết thúc!").printStackTrace();
            return null;
        }
        nhomToHocPhan.setGiangVienGiangDay(giangVienService.layThongTin(MaGiangVien));
        nhomToHocPhan.setMucDich(MucDich);
        nhomToHocPhan.setStartDate(startDate);
        nhomToHocPhan.setEndDate(endDate);

        return nhomToHocPhan;
    }

    protected NhomToHocPhan taoThongTin(NhomHocPhan nhomHocPhan, String MaGiangVien, String MucDich, String StartDate, String EndDate) {
        if(ValidateObject.exsistNullOrEmpty(nhomHocPhan, MaGiangVien, MucDich, StartDate, EndDate)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        NhomToHocPhan nhomToHocPhan = new NhomToHocPhan();
        nhomToHocPhan.setNhomHocPhan(nhomHocPhan);
        nhomToHocPhan.setGiangVienGiangDay(giangVienService.layThongTin(MaGiangVien));
        nhomToHocPhan.setMucDich(MucDich);
        nhomToHocPhan.setStartDate(Converter.stringToDate(StartDate));
        nhomToHocPhan.setEndDate(Converter.stringToDate(EndDate));
        return nhomToHocPhan;
    }

    protected NhomToHocPhan taoPlaceHolder() {
        NhomToHocPhan nhomToHocPhan = new NhomToHocPhan();
        nhomToHocPhan.setIdNhomToHocPhan(0);
        nhomToHocPhan.setNhomTo((short) -1);
        return nhomToHocPhan;
    }

    // MARK: ValidateDynamicTasks

    protected boolean checkDuplicateData (NhomToHocPhan nhomToHocPhan, int NhomToHocPhan, String MaGiangVien, String MucDich, String StartDate, String EndDate) {
        return(nhomToHocPhan.getGiangVienGiangDay().getMaGiangVien().equals(MaGiangVien)
            && nhomToHocPhan.getMucDich().equals(MucDich)
            && nhomToHocPhan.getStartDate().equals(Converter.stringToDate(StartDate))
            && nhomToHocPhan.getEndDate().equals(Converter.stringToDate(EndDate)));
    }
    
    protected boolean validateListWithSameIdNhomHocPhan(List<NhomToHocPhan> nhomToHocPhans) {
        boolean hasNhomToHocPhanThuocNhom = false;
        for (NhomToHocPhan nhomToHocPhan : nhomToHocPhans) {
            if (nhomToHocPhan.getNhomTo() == 0) {
                hasNhomToHocPhanThuocNhom = true;
            }
        }
        if (!hasNhomToHocPhanThuocNhom) {
            new Exception("Không tìm thấy nhóm tổ học phần thuộc nhóm học phần.").printStackTrace();
            return false;
        }

        return true;
    }
}
