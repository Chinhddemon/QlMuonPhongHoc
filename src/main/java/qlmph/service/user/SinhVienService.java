package qlmph.service.user;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.SinhVien;
import qlmph.repository.user.SinhVienRepository;

@Service
public class SinhVienService {

  @Autowired
  SinhVienRepository sinhVienRepository;

  public List<SinhVien> layDanhSach() {
    List<SinhVien> sinhViens = sinhVienRepository.getAll();
    if (sinhViens == null) {
      new Exception("Không tìm thấy thông tin.").printStackTrace();
      return null;
    }
    return sinhViens;
  }

  public SinhVien layThongTin(String maSinhVien) {
    SinhVien sinhVien = sinhVienRepository.getByMaSinhVien(maSinhVien);
    if (sinhVien == null) {
      new Exception("Không tìm thấy thông tin sinh viên, maSinhVien: " + maSinhVien).printStackTrace();
      return null;
    }
    return sinhVien;
  }

  public boolean kiemTraTaiKhoan(String idTaiKhoan) {
    SinhVien sinhVien = sinhVienRepository.getByIdTaiKhoan(UUID.fromString(idTaiKhoan));
    if (sinhVien == null) {
      return false;
    }
    return true;
  }
  
}