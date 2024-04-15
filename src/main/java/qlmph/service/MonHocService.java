package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.MonHoc;
import qlmph.repository.QLThongTin.MonHocRepository;

@Service
public class MonHocService {
  
  @Autowired
  private MonHocRepository monHocRepository;

  public List<MonHoc> layDanhSach() {
    return monHocRepository.getAll();
  }
}
