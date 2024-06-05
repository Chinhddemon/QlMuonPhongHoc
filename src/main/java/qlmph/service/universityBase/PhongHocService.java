package qlmph.service.universityBase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBase.PhongHoc;
import qlmph.repository.universityBase.PhongHocRepository;

@Service
public class PhongHocService {

    @Autowired
    PhongHocRepository phongHocRepository;

    // MARK: BasicTasks

    public List<PhongHoc> layDanhSachPhongKhaDung() {
        List<PhongHoc> phongHocs = phongHocRepository.getAllAvailable();
        if(phongHocs == null) {
            new Exception("Không tìm thấy danh sách phòng học.").printStackTrace();
            return null;
        }
        return phongHocs;
    }
    
    public List<PhongHoc> layDanhSach() {
        List<PhongHoc> phongHocs = phongHocRepository.getAll();
        if(phongHocs == null) {
            new Exception("Không tìm thấy danh sách phòng học.").printStackTrace();
            return null;
        }
        return phongHocs;
    }

    public PhongHoc layThongTin(int IdPhongHoc) {
        PhongHoc phongHoc = phongHocRepository.getByIdPhongHoc(IdPhongHoc);
        if(phongHoc == null) {
            new Exception("Không tìm thấy thông tin phòng học, IdPhongHoc: " + IdPhongHoc).printStackTrace();
            return null;
        }
        return phongHoc;
    }

    // MARK: DynamicTasks

}
