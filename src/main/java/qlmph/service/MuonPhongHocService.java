package qlmph.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.MuonPhongHoc;
import qlmph.repository.QLThongTin.MuonPhongHocRepository;

@Service
public class MuonPhongHocService {

    @Autowired
    MuonPhongHocRepository muonPhongHocRepository;
    
    public boolean luuThongTin(MuonPhongHoc muonPhongHoc) {
        if(!muonPhongHocRepository.existsRecord(muonPhongHoc.getIdLMPH())) {
            return muonPhongHocRepository.post(muonPhongHoc);
        }
        return false;
    }
}
