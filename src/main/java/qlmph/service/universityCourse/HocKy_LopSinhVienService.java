package qlmph.service.universityCourse;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityCourse.HocKy_LopSinhVien;
import qlmph.repository.universityCourse.HocKy_LopSinhVienRepository;

@Service
public class HocKy_LopSinhVienService {
  @Autowired
  private HocKy_LopSinhVienRepository hocKy_LopSinhVienRepository;

  public List<HocKy_LopSinhVien> layDanhSach() {
    List<HocKy_LopSinhVien> hocKy_LopSinhViens = hocKy_LopSinhVienRepository.getAll();
    if(hocKy_LopSinhViens == null) {
      new Exception("Không tìm thấy danh sách học kỳ lớp sinh viên.").printStackTrace();
      return null;
    }
    return hocKy_LopSinhViens;
  }

  public HocKy_LopSinhVien layThongTin(int idHocKy_LopSinhVien) {
    HocKy_LopSinhVien hocKy_LopSinhVien = hocKy_LopSinhVienRepository.getById(idHocKy_LopSinhVien);
    if(hocKy_LopSinhVien == null) {
      new Exception("Không tìm thấy thông tin học kỳ lớp sinh viên, idHocKy_LopSinhVien: " + idHocKy_LopSinhVien).printStackTrace();
      return null;
    }
    return hocKy_LopSinhVien;
  }

}

