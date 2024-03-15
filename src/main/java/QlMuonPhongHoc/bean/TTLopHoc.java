/* 
Định nghĩa:
    MaLH        -   Mã lớp học
    IdGV        -   Id giảng viên
    GiangVien   -   Họ tên giảng viên
    MaLopSV     -   Mã lớp giảng dạy
    MaMH        -   Mã môn học
    TenMH       -   Tên môn học
    Ngay_BD     -   Kỳ học bắt đầu
    Ngay_KT     -   Kỳ học kết thúc
Xử lý nhận đầu vào từ Model:
    LopHoc
    GiangVien
    LopSV
    MonHoc
Xử lý trả kết quả tới View:
    MaLH        -   Mã lớp học
    IdGV        -   Id giảng viên
    GiangVien   -   Họ tên giảng viên
    MaLopSV     -   Mã lớp giảng dạy
    MaMH        -   Mã môn học
    TenMH       -   Tên môn học
    Ngay_BD     -   Kỳ học bắt đầu
    Ngay_KT     -   Kỳ học kết thúc
*/
package QlMuonPhongHoc.bean;

import java.sql.Date;

public class TTLopHoc {
    private String MaLH;
    private String GiangVien;
    private String MaLopSV;
    private String MaMH;
    private String TenMH;
    private Date Ngay_BD;
    private Date Ngay_KT;
    
    public TTLopHoc() {
    }

    public String getMaLH() {
        return MaLH;
    }
    public void setMaLH(String maLH) {
        MaLH = maLH;
    }
    public String getGiangVien() {
        return GiangVien;
    }
    public void setGiangVien(String giangVien) {
        GiangVien = giangVien;
    }
    public String getMaLopSV() {
        return MaLopSV;
    }
    public void setMaLopSV(String maLopSV) {
        MaLopSV = maLopSV;
    }
    public String getMaMH() {
        return MaMH;
    }
    public void setMaMH(String maMH) {
        MaMH = maMH;
    }
    public String getTenMH() {
        return TenMH;
    }
    public void setTenMH(String tenMH) {
        TenMH = tenMH;
    }
    public Date getNgay_BD() {
        return Ngay_BD;
    }
    public void setNgay_BD(Date ngay_BD) {
        Ngay_BD = ngay_BD;
    }
    public Date getNgay_KT() {
        return Ngay_KT;
    }
    public void setNgay_KT(Date ngay_KT) {
        Ngay_KT = ngay_KT;
    }
    
}
