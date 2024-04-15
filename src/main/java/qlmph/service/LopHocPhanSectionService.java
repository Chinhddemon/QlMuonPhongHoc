package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.repository.QLThongTin.LopHocPhanSectionRepository;
import qlmph.utils.Converter;

@Service
public class LopHocPhanSectionService {

    @Autowired
    LopHocPhanSectionRepository lopHocPhanSectionRepository;

    @Autowired
    GiangVienService giangVienService;

    public List<LopHocPhanSection> layDanhSach() {
        List<LopHocPhanSection> lopHocPhanSections = lopHocPhanSectionRepository.getAll();
        if (lopHocPhanSections == null) {
            new Exception("Không tìm thấy danh sách lớp học phần section.").printStackTrace();
            return null;
        }
        return lopHocPhanSections;
    }

    public LopHocPhanSection layThongTin(int idLHPSection) {
        LopHocPhanSection lopHocPhanSection = lopHocPhanSectionRepository.getById(idLHPSection);
        if (lopHocPhanSection == null) {
            new Exception("Không tìm thấy thông tin lớp học phần section, idLHPSection: " + idLHPSection)
                .printStackTrace();
            return null;
        }
        return lopHocPhanSection;
    }

    public boolean capNhatThongTin(LopHocPhanSection lopHocPhanSection,
        String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot) {
        lopHocPhanSection.setGiangVien(giangVienService.layThongTin(MaGVRoot));
        lopHocPhanSection.setMucDich(MucDichRoot);
        lopHocPhanSection.setNgay_BD(Converter.stringToDate(Ngay_BDRoot));
        lopHocPhanSection.setNgay_KT(Converter.stringToDate(Ngay_KTRoot));
        return capNhatThongTin(lopHocPhanSection);
    }

    public boolean capNhatThongTin(LopHocPhanSection lopHocPhanSection) {
        if (!lopHocPhanSectionRepository.update(lopHocPhanSection)) {
            new Exception("Không thể cập nhật thông tin lớp học phần section.").printStackTrace();
            return false;
        }
        return true;
    }

    public LopHocPhanSection taoPlaceHolder() {
        LopHocPhanSection lopHocPhanSection = new LopHocPhanSection();
        lopHocPhanSection.setIdLHPSection(0);
        lopHocPhanSection.setNhomTo((short) 255);
        return lopHocPhanSection;
    }
    
    public boolean validateListWithSameIdNHP(List<LopHocPhanSection> lopHocPhanSections) {
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
