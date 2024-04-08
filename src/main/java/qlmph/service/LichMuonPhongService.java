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

    // public List<LichMuonPhong> layDanhSachTheoDieuKien(List<String> Commands, String ThoiGian_BD,String ThoiGian_KT,String TrangThai,String MucDich) {
    //     String thoiGian_BD = null;
    //     String thoiGian_KT = null;
    //     String trangThai = null;
    //     String mucDich = null;

    //     if(Commands.contains("TheoThoiGian")) {
    //         thoiGian_BD = ThoiGian_BD; // Theo thời gian bắt đầu
    //         thoiGian_KT = ThoiGian_KT; // Theo thời gian kết thúc
    //     }
    //     if(Commands.contains("TheoTrangThai"))
    //         trangThai = TrangThai;     // Theo trạng thái

    //     if(Commands.contains("TheoMucDich"))
    //         mucDich = MucDich;         // Theo mục đích

    //     return lichMuonPhongRepository.getListByCondition(thoiGian_BD,thoiGian_KT,trangThai,mucDich);
    // }

    public LichMuonPhong layThongTin(int IdLichMPH) {
        return lichMuonPhongRepository.getByIdLMPH(IdLichMPH);
    }

    public LichMuonPhong luuThongTin(LichMuonPhong lichMuonPhong) {
        if(!lichMuonPhongRepository.existsRecord(lichMuonPhong.getIdLMPH())
            && lichMuonPhongRepository.post(lichMuonPhong)) {
            return lichMuonPhong;
        }
        return null;
    }
}
