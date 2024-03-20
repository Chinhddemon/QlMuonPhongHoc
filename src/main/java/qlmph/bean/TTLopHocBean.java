package qlmph.bean;

// Danh sách models liên kết
import qlmph.models.QLTaiKhoan.GiangVien;   // Model Giảng viên
import qlmph.models.QLThongTin.LopHoc;      // Model Lớp học
import qlmph.models.QLThongTin.LopSV;       // Model Lớp sinh viên
import qlmph.models.QLThongTin.MonHoc;      // Model Môn học

// Thư viện dự án
import qlmph.utils.Converter;

public class TTLopHocBean {
    private String maLH;            // Mã lớp học
    private int idGVGiangDay;       // Id giảng viên giảng dạy
    private String maMH;            // Mã môn học
    private String maLopSV;         // Mã lớp sinh viên
    private String ngay_BD;         // Kỳ học bắt đầu
    private String ngay_KT;         // Kỳ học kết thúc
    private String hoTenGiangVien;  // Họ tên giảng viên
    private String monHoc;          // Tên môn học
    private String lopSV;           // Tên lớp sinh viên
    
    public TTLopHocBean() {
    }

    // Khởi tạo và nhập thông tin đồng thời
	public TTLopHocBean(LopHoc lopHoc, GiangVien giangVien, MonHoc monHoc, LopSV lopSV) {
        if(lopHoc != null) {
            if(lopHoc.getMaLH() != null) this.maLH = lopHoc.getMaLH();
            if(lopHoc.getIdGVGiangDay() != -1) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
            if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
            if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
            if(lopHoc.getNgay_BD() != null) this.ngay_BD = Converter.dateToString(lopHoc.getNgay_BD());
            if(lopHoc.getNgay_KT() != null) this.ngay_KT = Converter.dateToString(lopHoc.getNgay_KT());
            if(giangVien != null && this.idGVGiangDay == giangVien.getIdGV()) {
                if(giangVien.getHoTen() != null) this.hoTenGiangVien = giangVien.getHoTen();
            }
            if(monHoc != null && this.maMH.equals(monHoc.getMaMH())) {
                if(monHoc.getMonHoc() != null) this.maMH = monHoc.getMonHoc();
            }
            if(lopSV != null && this.maLopSV.equals(lopSV.getMaLopSV())) {
                if(lopSV.getLopSV() != null) this.lopSV = lopSV.getLopSV();
            }
        }
    }
    public void getLopHoc(LopHoc lopHoc) {
        if(lopHoc != null) {
            if(lopHoc.getMaLH() != null) this.maLH = lopHoc.getMaLH();
            if(lopHoc.getIdGVGiangDay() != -1) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
            if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
            if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
            if(lopHoc.getNgay_BD() != null) this.ngay_BD = Converter.dateToString(lopHoc.getNgay_BD());
            if(lopHoc.getNgay_KT() != null) this.ngay_KT = Converter.dateToString(lopHoc.getNgay_KT());
        }
    }
    public void getGiangVien(GiangVien giangVien) {
        if(giangVien != null && this.idGVGiangDay == giangVien.getIdGV()) {
            if( giangVien.getHoTen() != null ) this.hoTenGiangVien = giangVien.getHoTen();
        }
    }
    public void getMonHoc(MonHoc monHoc) {
        if(monHoc != null && this.maMH.equals(monHoc.getMaMH())) {
            if( monHoc.getMonHoc() != null ) this.maMH = monHoc.getMonHoc();
        }
    }
    public void getLopSV(LopSV lopSV) {
        if(lopSV != null && this.maLopSV.equals(lopSV.getMaLopSV())) {
            if( lopSV.getLopSV() != null ) this.lopSV = lopSV.getLopSV();
        }
    }

    public String getMaLH() {
        return maLH;
    }

    public void setMaLH(String maLH) {
        this.maLH = maLH;
    }

    public int getIdGVGiangDay() {
        return idGVGiangDay;
    }

    public void setIdGVGiangDay(int idGVGiangDay) {
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

    public String getHoTenGiangVien() {
        return hoTenGiangVien;
    }

    public void setHoTenGiangVien(String hoTenGiangVien) {
        this.hoTenGiangVien = hoTenGiangVien;
    }

    public String getMonHoc() {
        return monHoc;
    }

    public void setMonHoc(String monHoc) {
        this.monHoc = monHoc;
    }

    public String getLopSV() {
        return lopSV;
    }

    public void setLopSV(String lopSV) {
        this.lopSV = lopSV;
    }
    

}
