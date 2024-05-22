package qlmph.service.universityCourse;

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
    NhomToHocPhanRepository lopHocPhanSectionRepository;

    @Autowired
    GiangVienService giangVienService;

    // MARK: MultiBasicTasks

    public List<NhomToHocPhan> layDanhSach() {
        List<NhomToHocPhan> lopHocPhanSections = lopHocPhanSectionRepository.getAll();
        if (lopHocPhanSections == null) {
            new Exception("Không tìm thấy danh sách lớp học phần section.").printStackTrace();
            return null;
        }
        return lopHocPhanSections;
    }

    // MARK: SingleBasicTasks

    public NhomToHocPhan layThongTin(int idLHPSection) {
        NhomToHocPhan lopHocPhanSection = lopHocPhanSectionRepository.getById(idLHPSection);
        if (lopHocPhanSection == null) {
            new Exception("Không tìm thấy thông tin lớp học phần section, idLHPSection: " + idLHPSection)
                .printStackTrace();
            return null;
        }
        return lopHocPhanSection;
    }

    public boolean luuThongTin(NhomToHocPhan lopHocPhanSection) {
        if (!lopHocPhanSectionRepository.save(lopHocPhanSection)) {
            new Exception("Không thể tạo thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    public boolean capNhatThongTin(NhomToHocPhan lopHocPhanSection) {
        if (!lopHocPhanSectionRepository.update(lopHocPhanSection)) {
            new Exception("Không thể cập nhật thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    // MARK: SingleUtilTasks

    protected NhomToHocPhan chinhSuaThongTin(NhomToHocPhan lopHocPhanSection,
        String MaGV, String To, String MucDich, String Ngay_BD, String Ngay_KT) {
        if(!ValidateObject.exsistNullOrEmpty(MaGV, MucDich, Ngay_BD, Ngay_KT)
            && !ValidateObject.exsistNullOrEmpty(MaGV, MucDich, Ngay_BD, Ngay_KT)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        lopHocPhanSection.setGiangVienGiangDay(giangVienService.layThongTin(MaGV));
        if(To != null) {
            lopHocPhanSection.setNhomTo(Short.parseShort(To));
        }
        lopHocPhanSection.setMucDich(MucDich);
        lopHocPhanSection.setStartAt(Converter.stringToDate(Ngay_BD));
        lopHocPhanSection.setEndAt(Converter.stringToDate(Ngay_KT));
        return lopHocPhanSection;
    }

    protected NhomToHocPhan taoThongTin(NhomHocPhan nhomHocPhan, String MaGV, String To, String MucDich, String Ngay_BD, String Ngay_KT) {
        if(ValidateObject.exsistNullOrEmpty(nhomHocPhan, MaGV, To, MucDich, Ngay_BD, Ngay_KT)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        NhomToHocPhan lopHocPhanSection = new NhomToHocPhan();
        lopHocPhanSection.setNhomHocPhan(nhomHocPhan);
        lopHocPhanSection.setGiangVienGiangDay(giangVienService.layThongTin(MaGV));
        lopHocPhanSection.setNhomTo(Short.parseShort(To));
        lopHocPhanSection.setMucDich(MucDich);
        lopHocPhanSection.setStartAt(Converter.stringToDate(Ngay_BD));
        lopHocPhanSection.setEndAt(Converter.stringToDate(Ngay_KT));
        return lopHocPhanSection;
    }

    protected NhomToHocPhan taoPlaceHolder() {
        NhomToHocPhan lopHocPhanSection = new NhomToHocPhan();
        lopHocPhanSection.setIdNhomToHocPhan(0);
        lopHocPhanSection.setNhomTo((short) -1);
        return lopHocPhanSection;
    }

    // MARK: ValidateDynamicTasks
    
    protected boolean validateListWithSameIdNhomHocPhan(List<NhomToHocPhan> lopHocPhanSections) {
        boolean hasSectionWithNhom = false;
        boolean hasSectionWithNhomTo = false;
        boolean hasSectionWithoutNhomTo = false;
        for (NhomToHocPhan lopHocPhanSection : lopHocPhanSections) {
            if (lopHocPhanSection.getNhomTo() == 255) {
                if (hasSectionWithNhom) {
                    new Exception("Không được phép tồn tại nhiều hơn 2 section thuộc nhóm").printStackTrace();
                    return false;
                }
                hasSectionWithNhom = true;
            } else if (lopHocPhanSection.getNhomTo() == 0) {
                if (hasSectionWithoutNhomTo) {
                    new Exception("Không được phép tồn tại nhiều hơn 2 section không thuộc nhóm tổ").printStackTrace();
                    return false;
                } else if (hasSectionWithNhomTo) {
                    new Exception("Không được phép tồn tại section phân nhóm tổ khi tồn tại section không thuộc nhóm tổ")
                            .printStackTrace();
                    return false;
                }
                hasSectionWithoutNhomTo = true;
            } else {
                if (hasSectionWithoutNhomTo) {
                    new Exception("Không được phép tồn tại section phân nhóm tổ khi tồn tại section không thuộc nhóm tổ")
                            .printStackTrace();
                    return false;
                }
                hasSectionWithNhomTo = true;
            }
        }

        return true;
    }
}
