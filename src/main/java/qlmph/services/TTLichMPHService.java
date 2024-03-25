package qlmph.services;

import java.util.ArrayList;
import java.util.List;

import qlmph.DAO.QLTaiKhoan.GiangVienDAO;
import qlmph.DAO.QLTaiKhoan.QuanLyDAO;
import qlmph.DAO.QLTaiKhoan.SinhVienDAO;
import qlmph.DAO.QLTaiKhoan.VaiTroDAO;
import qlmph.DAO.QLThongTin.LichMuonPhongDAO;
import qlmph.DAO.QLThongTin.LopHocDAO;
import qlmph.DAO.QLThongTin.MonHocDAO;
import qlmph.DAO.QLThongTin.MuonPhongHocDAO;
import qlmph.bean.TTLichMPHBean;
import qlmph.models.QLTaiKhoan.GiangVien;
import qlmph.models.QLTaiKhoan.QuanLy;
import qlmph.models.QLTaiKhoan.VaiTro;
import qlmph.models.QLThongTin.LichMuonPhong;
import qlmph.models.QLThongTin.LopHoc;
import qlmph.models.QLThongTin.MonHoc;
import qlmph.models.QLThongTin.MuonPhongHoc;

public class TTLichMPHService {
    
    public static List<TTLichMPHBean> getAll() {
        List<TTLichMPHBean> DsLichMPH = new ArrayList<>();
        
        List<LichMuonPhong> DsLichMuonPhong = LichMuonPhongDAO.getAll();
        for (int i = 0; i < DsLichMuonPhong.size(); ++i) {
            LichMuonPhong lichMuonPhong = DsLichMuonPhong.get(i);

            LopHoc lopHoc = LopHocDAO.getByIdLH(lichMuonPhong.getIdLH());

            GiangVien giangVien = GiangVienDAO.getByIdGV(lopHoc.getIdGVGiangDay());

            MonHoc monHoc = MonHocDAO.getByMaMH(lopHoc.getMaMH());

            MuonPhongHoc muonPhongHoc = MuonPhongHocDAO.getByIdMPH(lichMuonPhong.getIdMPH());

            VaiTro vaiTro = VaiTroDAO.getByIdVaiTro(muonPhongHoc.getIdVaiTro());

            String tenVaiTro = vaiTro.getTenVaitro();
            Object ngMPH = null;

            if(tenVaiTro.equals("Giảng viên")) {
                ngMPH = GiangVienDAO.getByIdGV(muonPhongHoc.getIdNgMPH());
            }
            else if(tenVaiTro.equals("Sinh viên")) {
                ngMPH = SinhVienDAO.getByIdSV(muonPhongHoc.getIdNgMPH());
            }
            else {
                System.out.println("Lỗi lấy dữ liệu TTLichMPH thứ " + i);
                new Exception();
            }

            QuanLy quanLy = QuanLyDAO.getByIdQL(muonPhongHoc.getIdQLDuyet());

            TTLichMPHBean ttLichMPHBean = new TTLichMPHBean(lichMuonPhong, lopHoc, giangVien, monHoc, muonPhongHoc, vaiTro, ngMPH, quanLy);

            DsLichMPH.add(ttLichMPHBean);
        }

        return DsLichMPH;
    }
}
