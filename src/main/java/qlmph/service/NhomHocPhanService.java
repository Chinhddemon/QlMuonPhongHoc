package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.NhomHocPhan;
import qlmph.repository.QLThongTin.NhomHocPhanRepository;

@Service
public class NhomHocPhanService {
    
    @Autowired
    NhomHocPhanRepository nhomHocPhanRepository;

    /*
     * Lấy danh sách lớp học phần:
     * - Lấy danh sách lớp học phần từ repository
     * - Tách dữ liệu lớp học phần ra thành từng cặp
     * - Trả về danh sách lớp học phần
     */

    public List<NhomHocPhan> layDanhSach() {
        List<NhomHocPhan> nhomHocPhans = nhomHocPhanRepository.getAll();
        if(nhomHocPhanRepository.validateGetList(nhomHocPhans)) {
            return nhomHocPhans;
        }
        return null;
    }

    public NhomHocPhan layThongTin(int IdLHP) {
        return nhomHocPhanRepository.getByIdLHP(IdLHP);
    }
    
    // public NhomHocPhan layThongTin(String MaGV, String MaLopSV, String MaMH) {
    //     return nhomHocPhanRepository.getByMaGVAndMaLopSVAndMaMH(MaGV, MaLopSV, MaMH);
    // }
}
