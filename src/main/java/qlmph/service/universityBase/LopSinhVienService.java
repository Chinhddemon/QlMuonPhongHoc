package qlmph.service.universityBase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBase.LopSinhVien;
import qlmph.repository.universityBase.LopSinhVienRepository;

@Service
public class LopSinhVienService {

    @Autowired
    private LopSinhVienRepository lopSVRepository;

    public List<LopSinhVien> layDanhSach() {
        List<LopSinhVien> lopSVs = lopSVRepository.getAll();
        if(lopSVs == null) {
            new Exception("Không tìm thấy danh sách lớp sinh viên.").printStackTrace();
            return null;
        }
        return lopSVs;
    }

    public LopSinhVien layThongTin(String MaLopSinhVien) {
        LopSinhVien lopSV = lopSVRepository.getByMaLopSinhVien(MaLopSinhVien);
        if(lopSV == null) {
            new Exception("Không tìm thấy thông tin lớp sinh viên, MaLopSinhVien: " + MaLopSinhVien).printStackTrace();
            return null;
        }
        return lopSV;
    }
}
