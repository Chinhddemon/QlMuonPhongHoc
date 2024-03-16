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

import java.sql.Date;

public class TTLopHoc {
    private String maLH;
    private String giangVien;
    private String maLopSV;
    private String maMH;
    private String tenMH;
    private Date ngay_BD;
    private Date ngay_KT;
    
    public TTLopHoc() {
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

    public Date getNgay_BD() {
        return ngay_BD;
    }

    public void setNgay_BD(Date ngay_BD) {
        this.ngay_BD = ngay_BD;
    }

    public Date getNgay_KT() {
        return ngay_KT;
    }

    public void setNgay_KT(Date ngay_KT) {
        this.ngay_KT = ngay_KT;
    }
    
}
