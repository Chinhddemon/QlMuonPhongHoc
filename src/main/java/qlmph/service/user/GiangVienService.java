package qlmph.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.GiangVien;
import qlmph.repository.user.GiangVienRepository;
import qlmph.utils.ValidateObject;

@Service
public class GiangVienService {

    @Autowired
    GiangVienRepository giangVienRepository;

    @Autowired
    TaiKhoanService taiKhoanService;

    public List<GiangVien> layDanhSach() {
        List<GiangVien> giangViens = giangVienRepository.getAll();
        if(giangViens == null) {
            new Exception("Không tìm thấy thông tin.").printStackTrace();
            return null;
        }
        return giangViens;
    }

    public GiangVien layThongTin(String maGiangVien) {
        if(ValidateObject.isNullOrEmpty(maGiangVien)) {
            new Exception("Dữ liệu rỗng.").printStackTrace();
            return null;
        }
        GiangVien giangVien = giangVienRepository.getByMaGiangVien(maGiangVien);
        if(giangVien == null) {
            new Exception("Không tìm thấy thông tin giảng viên, maGiangVien: " + maGiangVien).printStackTrace();
            return null;
        }
        return giangVien;
    }

    public boolean kiemTraTaiKhoan(String idTaiKhoan) {
        GiangVien giangVien = giangVienRepository.getByIdTaiKhoan(taiKhoanService.chuyenDoiUuid(idTaiKhoan));
        if(giangVien == null) {
            return false;
        }
        return true;
    }

}