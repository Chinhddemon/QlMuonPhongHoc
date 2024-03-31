package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LopHocPhan;
import qlmph.repository.QLThongTin.LopHocPhanRepository;

@Service
public class LopHocPhanService {
    @Autowired
    LopHocPhanRepository lopHocPhanRepository;

    public List<LopHocPhan> layDanhSach() {
        return lopHocPhanRepository.getAll();
    }

    public LopHocPhan layThongTin(int IdLHP) {
        return lopHocPhanRepository.getByIdLHP(IdLHP);
    }
}
