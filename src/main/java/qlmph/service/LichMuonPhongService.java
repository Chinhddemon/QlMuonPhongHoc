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

    public LichMuonPhong layThongTinTheoDieuKien(int IdLichMPH, List<String> Commands, String ThoiGian_BD,String ThoiGian_KT,String MucDich) {
        if(Commands.contains("TheoThoiGian")) {
            if(Commands.contains("ChuaTraPhong"))
            {
                lichMuonPhongRepository.getByIdLMPHAndCondition(ThoiGian_BD,ThoiGian_KT,"ChuaTraPhong",null);
            } else if(Commands.contains("DaTraPhong")) {
                lichMuonPhongRepository.getByIdLMPHAndCondition(ThoiGian_BD,ThoiGian_KT,"ChuaTraPhong",null);
            } else if(Commands.contains("ChuaMuonPhong")) {
                lichMuonPhongRepository.getByIdLMPHAndCondition(ThoiGian_BD,ThoiGian_KT,"ChuaTraPhong",null);
            } else if(Commands.contains("DaHuy")) {
                lichMuonPhongRepository.getByIdLMPHAndCondition(ThoiGian_BD,ThoiGian_KT,"ChuaTraPhong",null);
            }
        }
        else{
            if(Commands.contains("ChuaTraPhong"))
            {
                lichMuonPhongRepository.getByIdLMPHAndCondition(null,null,"TrangThai",null);
            } else if(Commands.contains("DaTraPhong")) {
                lichMuonPhongRepository.getByIdLMPHAndCondition(null,null,"TrangThai",null);
            } else if(Commands.contains("ChuaMuonPhong")) {
                lichMuonPhongRepository.getByIdLMPHAndCondition(null,null,"TrangThai",null);
            } else if(Commands.contains("DaHuy")) {
                
            }
        }
    }
}
