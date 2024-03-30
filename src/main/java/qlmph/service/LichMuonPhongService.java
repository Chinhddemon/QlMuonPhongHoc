package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.repository.QLThongTin.LichMuonPhongRepository;

@Service
public class LichMuonPhongService {
    
    @Autowired
    LichMuonPhongRepository lichMuonPhongRepository;

    public List<LichMuonPhong> layDanhSach() {
        return lichMuonPhongRepository.getAll();
    }

    public LichMuonPhong layThongTin(int IdLichMPH) {
        return lichMuonPhongRepository.getByIdLMPH(IdLichMPH);
    }
}
