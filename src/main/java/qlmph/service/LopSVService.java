package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.LopSV;
import qlmph.repository.QLThongTin.LopSVRepository;

@Service
public class LopSVService {

    @Autowired
    private LopSVRepository lopSVRepository;

    public List<LopSV> layDanhSach() {
        List<LopSV> lopSVs = lopSVRepository.getAll();
        if(lopSVs == null) {
            new Exception("Không tìm thấy danh sách lớp sinh viên.").printStackTrace();
            return null;
        }
        return lopSVs;
    }

    public LopSV layThongTin(String MaLopSV) {
        LopSV lopSV = lopSVRepository.getByMaLopSV(MaLopSV);
        if(lopSV == null) {
            new Exception("Không tìm thấy thông tin lớp sinh viên, MaLopSV: " + MaLopSV).printStackTrace();
            return null;
        }
        return lopSV;
    }
}
