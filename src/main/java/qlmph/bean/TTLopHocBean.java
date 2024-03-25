package qlmph.bean;

import java.util.UUID;

// Danh sách models liên kết
import qlmph.models.QLTaiKhoan.GiangVien;   // Model Giảng viên
import qlmph.models.QLThongTin.LopHoc;      // Model Lớp học
import qlmph.models.QLThongTin.LopSV;       // Model Lớp sinh viên
import qlmph.models.QLThongTin.MonHoc;      // Model Môn học

// Thư viện dự án
import qlmph.utils.Converter;
import qlmph.utils.IsNull;

public class TTLopHocBean {
    // Model Lớp học
    private String idLH;            // Id lớp học
    private UUID idGVGiangDay;      // Id giảng viên giảng dạy
    private String maMH;            // Mã môn học
    private String maLopSV;         // Mã lớp sinh viên
    private String ngay_BD;         // Kỳ học bắt đầu
    private String ngay_KT;         // Kỳ học kết thúc
    // Model Giảng viên
    private String maGV;            // Mã giảng viên
    private String hoTenGiangVien;  // Họ tên giảng viên
    // Model Môn học
    private String tenMonHoc;       // Tên môn học
    // Model Lớp sinh viên
    private String tenLopSV;        // Tên lớp sinh viên   
    
    public TTLopHocBean() {
    }

    public TTLopHocBean(String idLH, UUID idGVGiangDay, String maMH, String maLopSV, String ngay_BD, String ngay_KT,
            String maGV, String hoTenGiangVien, String tenMonHoc, String tenLopSV) {
        this.idLH = idLH;
        this.idGVGiangDay = idGVGiangDay;
        this.maMH = maMH;
        this.maLopSV = maLopSV;
        this.ngay_BD = ngay_BD;
        this.ngay_KT = ngay_KT;
        this.maGV = maGV;
        this.hoTenGiangVien = hoTenGiangVien;
        this.tenMonHoc = tenMonHoc;
        this.tenLopSV = tenLopSV;
    }
    public TTLopHocBean(LopHoc lopHoc, GiangVien giangVien, MonHoc monHoc, LopSV lopSV) {
        if(lopHoc != null) {
            if(lopHoc.getIdLH() != IsNull.Int)  this.idLH = Converter.toString8Char(lopHoc.getIdLH());
            if(lopHoc.getIdGVGiangDay() != null) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
            if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
            if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
            if(lopHoc.getNgay_BD() != null) this.ngay_BD = Converter.toString(lopHoc.getNgay_BD());
            if(lopHoc.getNgay_KT() != null) this.ngay_KT = Converter.toString(lopHoc.getNgay_KT());
            if(giangVien != null) {
                if(giangVien.getMaGV() != null)  this.maGV = giangVien.getMaGV();
                if(giangVien.getHoTen() != null)  this.hoTenGiangVien = giangVien.getHoTen();
            }
            if(monHoc != null) {
                if(monHoc.getTenMonHoc() != null) this.tenMonHoc = monHoc.getTenMonHoc();
            }
            if(lopSV != null) {
                if(lopSV.getTenLopSV() != null) this.tenLopSV = lopSV.getTenLopSV();
            }
        }
    }
    public void getLopHoc(LopHoc lopHoc) {
        if(lopHoc != null) {
            if(lopHoc.getIdLH() != IsNull.Int)  this.idLH = Converter.toString8Char(lopHoc.getIdLH());
            if(lopHoc.getIdGVGiangDay() != null) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
            if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
            if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
            if(lopHoc.getNgay_BD() != null) this.ngay_BD = Converter.toString(lopHoc.getNgay_BD());
            if(lopHoc.getNgay_KT() != null) this.ngay_KT = Converter.toString(lopHoc.getNgay_KT());
        }
    }
    public void getGiangVien(GiangVien giangVien) {
        if(this.idGVGiangDay.equals(giangVien.getIdGV())) {
            if(giangVien != null) {
                if(giangVien.getMaGV() != null)  this.maGV = giangVien.getMaGV();
                if(giangVien.getHoTen() != null)  this.hoTenGiangVien = giangVien.getHoTen();
            }
        }
    }
    public void getMonHoc(MonHoc monHoc) {
        if(this.maMH.equals(monHoc.getMaMH())) {
            if(monHoc != null) {
                if(monHoc.getTenMonHoc() != null) this.tenMonHoc = monHoc.getTenMonHoc();
            }
        }
    }
    public void getLopSV(LopSV lopSV) {
        if(this.maLopSV.equals(lopSV.getMaLopSV())) {
            if(lopSV != null) {
                if(lopSV.getTenLopSV() != null) this.tenLopSV = lopSV.getTenLopSV();
            }
        }
    }

    public String getIdLH() {
        return idLH;
    }

    public void setIdLH(String idLH) {
        this.idLH = idLH;
    }

    public UUID getIdGVGiangDay() {
        return idGVGiangDay;
    }

    public void setIdGVGiangDay(UUID idGVGiangDay) {
        this.idGVGiangDay = idGVGiangDay;
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
    }

    public String getNgay_BD() {
        return ngay_BD;
    }

    public void setNgay_BD(String ngay_BD) {
        this.ngay_BD = ngay_BD;
    }

    public String getNgay_KT() {
        return ngay_KT;
    }

    public void setNgay_KT(String ngay_KT) {
        this.ngay_KT = ngay_KT;
    }

    public String getMaGV() {
        return maGV;
    }

    public void setMaGV(String maGV) {
        this.maGV = maGV;
    }

    public String getHoTenGiangVien() {
        return hoTenGiangVien;
    }

    public void setHoTenGiangVien(String hoTenGiangVien) {
        this.hoTenGiangVien = hoTenGiangVien;
    }

    public String getTenMonHoc() {
        return tenMonHoc;
    }

    public void setTenMonHoc(String tenMonHoc) {
        this.tenMonHoc = tenMonHoc;
    }

    public String getTenLopSV() {
        return tenLopSV;
    }

    public void setTenLopSV(String tenLopSV) {
        this.tenLopSV = tenLopSV;
    }
    

}
