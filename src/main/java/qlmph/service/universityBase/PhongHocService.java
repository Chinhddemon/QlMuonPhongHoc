package qlmph.service.universityBase;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.universityBorrowRoom.LichMuonPhong;
import qlmph.model.universityBase.PhongHoc;
import qlmph.repository.universityBase.PhongHocRepository;
import qlmph.service.universityBorrowRoom.LichMuonPhongService;

@Service
public class PhongHocService {

    @Autowired
    PhongHocRepository phongHocRepository;

    // MARK: BasicTasks
    
    public List<PhongHoc> layDanhSach() {
        List<PhongHoc> phongHocs = phongHocRepository.getAll();
        if(phongHocs == null) {
            new Exception("Không tìm thấy danh sách phòng học.").printStackTrace();
            return null;
        }
        return phongHocs;
    }

    public PhongHoc layThongTin(int IdPhongHoc) {
        PhongHoc phongHoc = phongHocRepository.getByIdPhongHoc(IdPhongHoc);
        if(phongHoc == null) {
            new Exception("Không tìm thấy thông tin phòng học, IdPhongHoc: " + IdPhongHoc).printStackTrace();
            return null;
        }
        return phongHoc;
    }

    // MARK: DynamicTasks

    public Map<PhongHoc, Boolean> layDanhSachCoDanhDauLichMuonPhong() {
        List<PhongHoc> phongHocsChuaDanhDau = layDanhSach();
        Set<PhongHoc> phongHocsTrongLichMuonPhong = layDanhSachTheoLichMuonPhongHienTai();
        if(phongHocsChuaDanhDau == null ||phongHocsTrongLichMuonPhong == null) {
            new Exception("Không tìm thấy danh sách phòng học.").printStackTrace();
            return null;
        }
        Map<PhongHoc, Boolean> danhDau = new HashMap<>();
        for(PhongHoc phongHoc : phongHocsChuaDanhDau) {
            if(phongHocsTrongLichMuonPhong.contains(phongHoc)) {
                danhDau.put(phongHoc, false); // false: có lịch mượn phòng gần đây
            } else {
                danhDau.put(phongHoc, true); // true: không có lịch mượn phòng gần đây
            }
        }
        return danhDau;
    }

    public Set<PhongHoc> layDanhSachTheoLichMuonPhongHienTai() {
        List<LichMuonPhong> lichMuonPhongs = new LichMuonPhongService().layDanhSachHienTai();
        if (lichMuonPhongs == null) {
            new Exception("Không tìm thấy danh sách lịch mượn phòng.").printStackTrace();
            return null;
        }
        Set<PhongHoc> phongHocs = new HashSet<>();
        for(LichMuonPhong lichMuonPhong : lichMuonPhongs) {
            phongHocs.add(lichMuonPhong.getPhongHoc());
        }
        return phongHocs;
    }

}
