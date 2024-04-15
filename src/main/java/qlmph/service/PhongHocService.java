package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.PhongHoc;
import qlmph.repository.QLThongTin.PhongHocRepository;

@Service
public class PhongHocService {

    @Autowired
    PhongHocRepository phongHocRepository;

    public PhongHoc layThongTin(int IdPH) {
        PhongHoc phongHoc = phongHocRepository.getByMaPH(IdPH);
        if(phongHoc == null) {
            new Exception("Không tìm thấy thông tin phòng học, IdPH: " + IdPH).printStackTrace();
            return null;
        }
        return phongHoc;
    }

    public List<PhongHoc> layDanhSach() {
        List<PhongHoc> phongHocs = phongHocRepository.getAll();
        if(phongHocs == null) {
            new Exception("Không tìm thấy danh sách phòng học.").printStackTrace();
            return null;
        }
        return phongHocs;
    }

}
