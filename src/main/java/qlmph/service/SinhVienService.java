package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.SinhVien;
import qlmph.repository.QLTaiKhoan.SinhVienRepository;

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

  public SinhVien layThongTin(String MaSV) {
    SinhVien sinhVien = sinhVienRepository.getByMaSV(MaSV);
    if (sinhVien == null) {
      new Exception("Không tìm thấy thông tin sinh viên, MaSV: " + MaSV).printStackTrace();
      return null;
    }
    return sinhVien;
  }
  
}