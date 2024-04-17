package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.MonHoc;
import qlmph.repository.QLThongTin.MonHocRepository;

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

    public MonHoc layThongTin(String MaMH) {
        MonHoc monHoc = monHocRepository.getByMaMH(MaMH);
        if(monHoc == null) {
            new Exception("Không tìm thấy thông tin môn học, MaMH: " + MaMH).printStackTrace();
            return null;
        }
        return monHoc;
    }
}
