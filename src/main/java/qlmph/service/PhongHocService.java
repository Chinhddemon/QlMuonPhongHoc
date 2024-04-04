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

    public PhongHoc layThongTin(String MaPH) {
        return phongHocRepository.getByMaPH(MaPH);
    }

    public List<PhongHoc> layDanhSach() {
        return phongHocRepository.getAll();
    }
    
}
