package qlmph.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.model.QLThongTin.MuonPhongHoc;
import qlmph.repository.QLTaiKhoan.QuanLyRepository;
import qlmph.repository.QLThongTin.MuonPhongHocRepository;

@Service
public class MuonPhongHocService {

    @Autowired
    MuonPhongHocRepository muonPhongHocRepository;

    @Autowired 
    QuanLyRepository quanLyRepository;

    
    public boolean taoThongTin(LichMuonPhong lichMuonPhong, NguoiMuonPhong nguoiMuonPhong, QuanLy quanLy, String yeuCau) {
        return muonPhongHocRepository
            .post(new MuonPhongHoc(
            lichMuonPhong.getIdLMPH(),
            lichMuonPhong,
            nguoiMuonPhong.getMaNgMPH(),
            quanLy.getMaQL(),
            new Date(),
            yeuCau));
    }
}
