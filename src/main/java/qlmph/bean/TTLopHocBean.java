/* 
Định nghĩa dữ liệu xử lý:
    maLH        -   Mã lớp học
    idGV        -   Id giảng viên
    giangVien   -   Họ tên giảng viên
    maLopSV     -   Mã lớp giảng dạy
    maMH        -   Mã môn học
    tenMH       -   Tên môn học
    ngay_BD     -   Kỳ học bắt đầu
    ngay_KT     -   Kỳ học kết thúc
Xử lý nhận đầu vào từ Model:
    LopHoc
    GiangVien
    LopSV
    MonHoc
Xử lý trả kết quả tới View:
    maLH        -   Mã lớp học
    giangVien   -   Họ tên giảng viên
    maLopSV     -   Mã lớp giảng dạy
    maMH        -   Mã môn học
    tenMH       -   Tên môn học
    ngay_BD     -   Kỳ học bắt đầu
    ngay_KT     -   Kỳ học kết thúc
*/
package qlmph.bean;

import qlmph.models.QLTaiKhoan.GiangVien;
import qlmph.models.QLThongTin.LopHoc;
import qlmph.models.QLThongTin.MonHoc;
import qlmph.utils.Converter;

public class TTLopHocBean {
    private String maLH;
    private String giangVien;
    private String maLopSV;
    private String maMH;
    private String tenMH;
    private String ngay_BD;
    private String ngay_KT;
    
    public TTLopHocBean() {
    }

    public TTLopHocBean(LopHoc lopHoc, GiangVien giangVien, MonHoc monHoc) {
        if( lopHoc.getMaLH() != null ) this.maLH = lopHoc.getMaLH();
        if( lopHoc.getMaLopSV() != null ) this.maLopSV = lopHoc.getMaLopSV();
        if( lopHoc.getMaMH() != null ) this.maMH = lopHoc.getMaMH();
        if( lopHoc.getNgay_BD() != null ) this.ngay_BD = Converter.dateToString(lopHoc.getNgay_BD());
        if( lopHoc.getNgay_KT() != null ) this.ngay_KT = Converter.dateToString(lopHoc.getNgay_KT());
        if( giangVien.getHoTen() != null ) this.giangVien = giangVien.getHoTen();
        if( monHoc.getMaMH() != null ) this.maMH = monHoc.getMaMH();
        if( monHoc.getTenMH() != null ) this.tenMH = monHoc.getTenMH();
    }

    public String getMaLH() {
        return maLH;
    }

    public void setMaLH(String maLH) {
        this.maLH = maLH;
    }

    public String getGiangVien() {
        return giangVien;
    }

    public void setGiangVien(String giangVien) {
        this.giangVien = giangVien;
    }

    public String getMaLopSV() {
        return maLopSV;
    }

    public void setMaLopSV(String maLopSV) {
        this.maLopSV = maLopSV;
    }

    public String getMaMH() {
        return maMH;
    }

    public void setMaMH(String maMH) {
        this.maMH = maMH;
    }

    public String getTenMH() {
        return tenMH;
    }

    public void setTenMH(String tenMH) {
        this.tenMH = tenMH;
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

    public void getLopHoc(LopHoc lopHoc) {
        if( lopHoc.getMaLH() != null ) this.maLH = lopHoc.getMaLH();
        if( lopHoc.getMaLopSV() != null ) this.maMH = lopHoc.getMaLopSV();
        if( lopHoc.getMaMH() != null ) this.maMH = lopHoc.getMaMH();
        if( lopHoc.getNgay_BD() != null ) this.maMH = Converter.dateToString(lopHoc.getNgay_BD());
        if( lopHoc.getNgay_KT() != null ) this.maMH = Converter.dateToString(lopHoc.getNgay_KT());
    }

    public void getGiangVien(GiangVien giangVien) {
        if( giangVien.getHoTen() != null ) this.giangVien = giangVien.getHoTen();
    }

    public void getMonHoc(MonHoc monHoc) {
        if( monHoc.getMaMH() != null ) this.maMH = monHoc.getMaMH();
        if( monHoc.getTenMH() != null ) this.tenMH = monHoc.getTenMH();
    }
    
}
