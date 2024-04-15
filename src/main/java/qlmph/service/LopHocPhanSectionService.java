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
        return lopHocPhanSectionRepository.getAll();
    }

    public LopHocPhanSection layThongTin(int idLHPSection) {
        return lopHocPhanSectionRepository.getById(idLHPSection);
    }

    public boolean capNhatThongTin(LopHocPhanSection lopHocPhanSection) {
        return lopHocPhanSectionRepository.update(lopHocPhanSection);
    }

    public boolean capNhatThongTin(LopHocPhanSection lopHocPhanSection,
        String MaGVRoot, String MucDichRoot, String Ngay_BDRoot, String Ngay_KTRoot) {
        lopHocPhanSection.setGiangVien(giangVienService.layThongTin(MaGVRoot));
        lopHocPhanSection.setMucDich(MucDichRoot);
        lopHocPhanSection.setNgay_BD(Converter.stringToDate(Ngay_BDRoot));
        lopHocPhanSection.setNgay_KT(Converter.stringToDate(Ngay_KTRoot));
        if (!lopHocPhanSectionRepository.update(lopHocPhanSection)) {
            new Exception("Không thể cập nhật thông tin lịch mượn phòng.").printStackTrace();
            return false;
        }
        return true;
    }
}
