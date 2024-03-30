package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LopHoc;
import qlmph.repository.QLThongTin.LopHocRepository;

@Service
public class LopHocService {
    @Autowired
    LopHocRepository lopHocRepository;

    public List<LopHoc> xemDanhSach() {
        return lopHocRepository.getAll();
    }
}
