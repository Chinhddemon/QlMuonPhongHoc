package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.LopHocPhanSection;
import qlmph.repository.QLThongTin.LopHocPhanSectionRepository;
import qlmph.utils.Converter;
import qlmph.utils.ValidateObject;

@Service
public class LopHocPhanSectionService {

    @Autowired
    LopHocPhanSectionRepository lopHocPhanSectionRepository;

    @Autowired
    GiangVienService giangVienService;

    // MARK: MultiBasicTasks

    public List<LopHocPhanSection> layDanhSach() {
        List<LopHocPhanSection> lopHocPhanSections = lopHocPhanSectionRepository.getAll();
        if (lopHocPhanSections == null) {
            new Exception("Không tìm thấy danh sách lớp học phần section.").printStackTrace();
            return null;
        }
        return lopHocPhanSections;
    }

    // MARK: SingleBasicTasks

    public LopHocPhanSection layThongTin(int idLHPSection) {
        LopHocPhanSection lopHocPhanSection = lopHocPhanSectionRepository.getById(idLHPSection);
        if (lopHocPhanSection == null) {
            new Exception("Không tìm thấy thông tin lớp học phần section, idLHPSection: " + idLHPSection)
                .printStackTrace();
            return null;
        }
        return lopHocPhanSection;
    }

    public boolean luuThongTin(LopHocPhanSection lopHocPhanSection) {
        if (!lopHocPhanSectionRepository.save(lopHocPhanSection)) {
            new Exception("Không thể tạo thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    public boolean capNhatThongTin(LopHocPhanSection lopHocPhanSection) {
        if (!lopHocPhanSectionRepository.update(lopHocPhanSection)) {
            new Exception("Không thể cập nhật thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    // MARK: SingleUtilTasks

    protected LopHocPhanSection chinhSuaThongTin(LopHocPhanSection lopHocPhanSection,
        String MaGV, String To, String MucDich, String Ngay_BD, String Ngay_KT) {
        if(!ValidateObject.allNullOrEmpty(MaGV, MucDich, Ngay_BD, Ngay_KT)
            && !ValidateObject.allNotNullOrEmpty(MaGV, MucDich, Ngay_BD, Ngay_KT)) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        lopHocPhanSection.setGiangVien(giangVienService.layThongTin(MaGV));
        if(To != null) {
            lopHocPhanSection.setNhomTo(Short.parseShort(To));
        }
        lopHocPhanSection.setMucDich(MucDich);
        lopHocPhanSection.setNgay_BD(Converter.stringToDate(Ngay_BD));
        lopHocPhanSection.setNgay_KT(Converter.stringToDate(Ngay_KT));
        return lopHocPhanSection;
    }

    protected LopHocPhanSection taoThongTin(String MaGV, String To, String MucDich, String Ngay_BD, String Ngay_KT) {
        if(ValidateObject.allNullOrEmpty(MaGV, To, MucDich, Ngay_BD, Ngay_KT) == false) {
            new Exception("Dữ liệu không hợp lệ!").printStackTrace();
            return null;
        }
        LopHocPhanSection lopHocPhanSection = new LopHocPhanSection();
        lopHocPhanSection.setGiangVien(giangVienService.layThongTin(MaGV));
        lopHocPhanSection.setNhomTo(Short.parseShort(To));
        lopHocPhanSection.setMucDich(MucDich);
        lopHocPhanSection.setNgay_BD(Converter.stringToDate(Ngay_BD));
        lopHocPhanSection.setNgay_KT(Converter.stringToDate(Ngay_KT));
        return lopHocPhanSection;
    }

    protected LopHocPhanSection taoPlaceHolder() {
        LopHocPhanSection lopHocPhanSection = new LopHocPhanSection();
        lopHocPhanSection.setIdLHPSection(0);
        lopHocPhanSection.setNhomTo((short) -1);
        return lopHocPhanSection;
    }

    // MARK: ValidateDynamicTasks
    
    protected boolean validateListWithSameIdNHP(List<LopHocPhanSection> lopHocPhanSections) {
        boolean hasSectionWithNhom = false;
        boolean hasSectionWithNhomTo = false;
        boolean hasSectionWithoutNhomTo = false;
        for (LopHocPhanSection lopHocPhanSection : lopHocPhanSections) {
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
