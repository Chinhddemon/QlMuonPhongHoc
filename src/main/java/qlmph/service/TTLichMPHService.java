package qlmph.service;

import java.util.ArrayList;
import java.util.List;

import qlmph.DAO.QLTaiKhoan.GiangVienDAO;
import qlmph.DAO.QLTaiKhoan.QuanLyDAO;
import qlmph.DAO.QLTaiKhoan.SinhVienDAO;
import qlmph.DAO.QLTaiKhoan.TaiKhoanDAO;
import qlmph.DAO.QLTaiKhoan.VaiTroDAO;
import qlmph.DAO.QLThongTin.LichMuonPhongDAO;
import qlmph.DAO.QLThongTin.LopHocDAO;
import qlmph.DAO.QLThongTin.MonHocDAO;
import qlmph.DAO.QLThongTin.MuonPhongHocDAO;
import qlmph.bean.TTLichMPHBean;
import qlmph.model.QLTaiKhoan.GiangVien;
import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.model.QLTaiKhoan.TaiKhoan;
import qlmph.model.QLTaiKhoan.VaiTro;
import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.model.QLThongTin.LopHoc;
import qlmph.model.QLThongTin.MonHoc;
import qlmph.model.QLThongTin.MuonPhongHoc;
import qlmph.utils.Converter;

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
            
            TaiKhoan taiKhoan = null;
            VaiTro vaiTro = null;
            Object ngMPH = null;
            QuanLy quanLy = null;
            
            if(muonPhongHoc != null) {
            	taiKhoan = TaiKhoanRepository.getByIdTaiKhoan(muonPhongHoc.getIdTaiKhoan());
            	
            	vaiTro = VaiTroDAO.getByIdVaiTro(taiKhoan.getIdVaiTro());
            	
            	String tenVaiTro = vaiTro.getTenVaitro();

                if(tenVaiTro.equals("Giảng viên")) {
                    ngMPH = GiangVienDAO.getByIdTaiKhoan(taiKhoan.getIdTaiKhoan());
                }
                else if(tenVaiTro.equals("Sinh viên")) {
                    ngMPH = SinhVienDAO.getByIdSV(taiKhoan.getIdTaiKhoan());
                }
                else {
                    System.out.println("Lỗi lấy dữ liệu TTLichMPH thứ " + i);
                    new Exception();
                }
                
                quanLy = QuanLyDAO.getByIdQL(muonPhongHoc.getIdQLDuyet());
            }
            
            TTLichMPHBean ttLichMPHBean = new TTLichMPHBean(lichMuonPhong, lopHoc, giangVien, monHoc, muonPhongHoc, vaiTro, ngMPH, quanLy);

            DsLichMPH.add(ttLichMPHBean);
        }

        return DsLichMPH;
    }
    
    public static TTLichMPHBean getByIdLMPH(String IdLMPH) {
    	
        LichMuonPhong lichMuonPhong = LichMuonPhongDAO.getByIdLMPH(Converter.toInt(IdLMPH));

        LopHoc lopHoc = LopHocDAO.getByIdLH(lichMuonPhong.getIdLH());

        GiangVien giangVien = GiangVienDAO.getByIdGV(lopHoc.getIdGVGiangDay());

        MonHoc monHoc = MonHocDAO.getByMaMH(lopHoc.getMaMH());

        MuonPhongHoc muonPhongHoc = MuonPhongHocDAO.getByIdMPH(lichMuonPhong.getIdMPH());
        
        TaiKhoan taiKhoan = null;
        VaiTro vaiTro = null;
        Object ngMPH = null;
        QuanLy quanLy = null;
        
        if(muonPhongHoc != null) {
        	taiKhoan = TaiKhoanRepository.getByIdTaiKhoan(muonPhongHoc.getIdTaiKhoan());
        	
        	vaiTro = VaiTroDAO.getByIdVaiTro(taiKhoan.getIdVaiTro());
        	
        	String tenVaiTro = vaiTro.getTenVaitro();

            if(tenVaiTro.equals("Giảng viên")) {
                ngMPH = GiangVienDAO.getByIdTaiKhoan(taiKhoan.getIdTaiKhoan());
            }
            else if(tenVaiTro.equals("Sinh viên")) {
                ngMPH = SinhVienDAO.getByIdSV(taiKhoan.getIdTaiKhoan());
            }
            else {
                System.out.println("Lỗi lấy dữ liệu TTLichMPH với IdLMPH" + IdLMPH);
                new Exception();
            }
            
            quanLy = QuanLyDAO.getByIdQL(muonPhongHoc.getIdQLDuyet());
        }
        
        TTLichMPHBean ttLichMPHBean = new TTLichMPHBean(lichMuonPhong, lopHoc, giangVien, monHoc, muonPhongHoc, vaiTro, ngMPH, quanLy);

        return ttLichMPHBean;
    }
}
