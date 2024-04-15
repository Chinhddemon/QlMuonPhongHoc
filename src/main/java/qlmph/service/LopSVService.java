package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LopSV;
import qlmph.repository.QLThongTin.LopSVRepository;

@Service
public class LopSVService {

    @Autowired
    private LopSVRepository lopSVRepository;

    public List<LopSV> layDanhSach() {
        return lopSVRepository.getAll();
    }
}
