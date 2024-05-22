package qlmph.service.universityBase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBase.MonHoc;
import qlmph.repository.universityBase.MonHocRepository;

@Service
public class MonHocService {

    @Autowired
    private MonHocRepository monHocRepository;

    public List<MonHoc> layDanhSach() {
        List<MonHoc> monHocs = monHocRepository.getAll();
        if(monHocs == null) {
            new Exception("Không tìm thấy danh sách môn học.").printStackTrace();
            return null;
        }
        return monHocs;
    }

    public MonHoc layThongTin(String MaMonHoc) {
        MonHoc monHoc = monHocRepository.getByMaMonHoc(MaMonHoc);
        if(monHoc == null) {
            new Exception("Không tìm thấy thông tin môn học, MaMonHoc: " + MaMonHoc).printStackTrace();
            return null;
        }
        return monHoc;
    }
}
