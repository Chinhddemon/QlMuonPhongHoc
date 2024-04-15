package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LopHocPhanSection;
import qlmph.repository.QLThongTin.LopHocPhanSectionRepository;

@Service
public class LopHocPhanSectionService {

    @Autowired
    LopHocPhanSectionRepository lopHocPhanSectionRepository;

    public List<LopHocPhanSection> layDanhSach() {
        return lopHocPhanSectionRepository.getAll();
    }

    public LopHocPhanSection layThongTin(int idLHPSection) {
        return lopHocPhanSectionRepository.getById(idLHPSection);
    }

    public boolean capNhatThongTin(LopHocPhanSection lopHocPhanSection) {
        return lopHocPhanSectionRepository.update(lopHocPhanSection);
    }
}
