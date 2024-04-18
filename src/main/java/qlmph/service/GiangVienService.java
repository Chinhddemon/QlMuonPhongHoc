package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.GiangVien;
import qlmph.repository.QLTaiKhoan.GiangVienRepository;
import qlmph.utils.ValidateObject;

@Service
public class GiangVienService {

    @Autowired
    GiangVienRepository giangVienRepository;

    public List<GiangVien> layDanhSach() {
        List<GiangVien> giangViens = giangVienRepository.getAll();
        if(giangViens == null) {
            new Exception("Không tìm thấy thông tin.").printStackTrace();
            return null;
        }
        return giangViens;
    }

    public GiangVien layThongTin(String MaGV) {
        if(ValidateObject.isNullOrEmpty(MaGV)) {
            new Exception("Dữ liệu rỗng.").printStackTrace();
            return null;
        }
        GiangVien giangVien = giangVienRepository.getByMaGV(MaGV);
        if(giangVien == null) {
            new Exception("Không tìm thấy thông tin giảng viên, MaGV: " + MaGV).printStackTrace();
            return null;
        }
        return giangVien;
    }

}