/*  
Định nghĩa dữ liệu xử lý:
    maLMPH          -   Mã lịch mượn phòng
    maLH            -   Mã lớp học
    idGV            -   Id giảng viên
    giangVien       -   Họ tên giảng viên
    maLopSV         -   Mã lớp giảng dạy
    maMH            -   Mã môn học
    tenMH           -   Tên môn học
    maPH            -   Mã phòng học    
    thoiGian_BD     -   Thời gian mượn
    thoiGian_KT     -   Thời gian trả
    mucDich         -   Mục đích mượn phòng học
    lydo            -   Lý do tạo lịch mượn phòng học
    idNgMPH         -   Id người mượn phòng học
    ngMPH           -   Người mượn phòng học
    vaiTro          -   Vai trò người mượn phòng
    idQL_Duyet      -   Id quản lý duyệt
    qL_Duyet        -   Quản lý duyệt
    thoiGian_MPH    -   Thời gian mượn phòng học
    yeuCauHocCu     -   Yêu cầu học cụ
    _DeleteAt       -   Thời gian hủy lịch mượn phòng
Xử lý nhận đầu vào từ Model:
    LichMuonPhong
    LopHoc
    GiangVien
    MonHoc
    PhongHoc
    MuonPhongHoc
    QuanLy
Xử lý thông tin tại controller:
    TrangThai = ThoiGian_MPH ? "Đã mượn phòng" : (_DeleteAt ? "Đã hủy" : "Chưa mượn phòng" ) 
Dữ liệu lưu trữ:
    maLMPH          -   Mã lịch mượn phòng
    giangVien       -   Họ tên giảng viên
    maLopSV         -   Mã lớp giảng dạy
    maMH            -   Mã môn học
    tenMH           -   Tên môn học
    maPH            -   Mã phòng học    
    thoiGian_BD     -   Thời gian mượn
    thoiGian_KT     -   Thời gian trả
    mucDich         -   Mục đích mượn phòng học
    lydo            -   Lý do tạo lịch mượn phòng học
    trangThai       -   Trạng thái mượn phòng học
    ngMPH           -   Người mượn phòng học
    vaiTro          -   Vai trò người mượn phòng
    qL_Duyet        -   Quản lý duyệt
    thoiGian_MPH    -   Thời gian mượn phòng học
    yeuCauHocCu     -   Yêu cầu học cụ
*/
package qlmph.bean;

import java.sql.Timestamp;

import qlmph.utils.Converter;

public class TTLichMPHBean {
    private String maLMPH;
    private String giangVien;
    private String maLopSV;
    private String maMH;
    private String tenMH;
    private String maPH;
    private String thoiGian_BD;
    private String thoiGian_KT;
    private String mucDich;
    private String lyDo;
    private String trangThai;
    private String ngMPH;
    private String vaiTro;
    private String qL_Duyet;
    private String thoiGian_MPH;
    private String yeuCauHocCu;

    public TTLichMPHBean() {
    }

    // Chỉ sử dụng để test
    public TTLichMPHBean(String maLMPH, String giangVien, String maLopSV, String maMH, String tenMH,
            String maPH, Timestamp thoiGian_BD, Timestamp thoiGian_KT, String mucDich, String lyDo, String trangThai,
            String ngMPH, String vaiTro, String qL_Duyet, Timestamp thoiGian_MPH, String yeuCauHocCu) {
        this.maLMPH = maLMPH;
        this.giangVien = giangVien;
        this.maLopSV = maLopSV;
        this.maMH = maMH;
        this.tenMH = tenMH;
        this.maPH = maPH;
        this.thoiGian_BD = Converter.timestampToString(thoiGian_BD);
        this.thoiGian_KT = Converter.timestampToString(thoiGian_KT);
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this.trangThai = trangThai;
        this.ngMPH = ngMPH;
        this.vaiTro = vaiTro;
        this.qL_Duyet = qL_Duyet;
        this.thoiGian_MPH = Converter.timestampToString(thoiGian_MPH);
        this.yeuCauHocCu = yeuCauHocCu;
    }


    public TTLichMPHBean(String maLMPH, String giangVien, String maLopSV, String maMH, String tenMH,
            String maPH, String thoiGian_BD, String thoiGian_KT, String mucDich, String lyDo, String trangThai,
            String ngMPH, String vaiTro, String qL_Duyet, String thoiGian_MPH, String yeuCauHocCu) {
        this.maLMPH = maLMPH;
        this.giangVien = giangVien;
        this.maLopSV = maLopSV;
        this.maMH = maMH;
        this.tenMH = tenMH;
        this.maPH = maPH;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.mucDich = mucDich;
        this.lyDo = lyDo;
        this.trangThai = trangThai;
        this.ngMPH = ngMPH;
        this.vaiTro = vaiTro;
        this.qL_Duyet = qL_Duyet;
        this.thoiGian_MPH = thoiGian_MPH;
        this.yeuCauHocCu = yeuCauHocCu;
    }

    public String getMaLMPH() {
        return maLMPH;
    }
    public void setMaLMPH(String maLMPH) {
        this.maLMPH = maLMPH;
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
    public String getMaPH() {
        return maPH;
    }
    public void setMaPH(String maPH) {
        this.maPH = maPH;
    }
    public String getThoiGian_BD() {
        return thoiGian_BD;
    }
    public void setThoiGian_BD(Timestamp thoiGian_BD) {
        this.thoiGian_BD = Converter.timestampToString(thoiGian_BD);
    }
    public void setThoiGian_BD(String thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }
    public String getThoiGian_KT() {
        return thoiGian_KT;
    }
    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        this.thoiGian_KT = Converter.timestampToString(thoiGian_KT);
    }
    public void setThoiGian_KT(String thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }
    public String getMucDich() {
        return mucDich;
    }
    public void setMucDich(String mucDich) {
        this.mucDich = mucDich;
    }
    public String getLyDo() {
        return lyDo;
    }
    public void setLyDo(String lyDo) {
        this.lyDo = lyDo;
    }
    public String getTrangThai() {
        return trangThai;
    }
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    public String getNgMPH() {
        return ngMPH;
    }
    public void setNgMPH(String ngMPH) {
        this.ngMPH = ngMPH;
    }
    public String getVaiTro() {
        return vaiTro;
    }
    public void setVaiTro(String vaiTro) {
        this.vaiTro = vaiTro;
    }
    public String getQL_Duyet() {
        return qL_Duyet;
    }
    public void setQL_Duyet(String qL_Duyet) {
        this.qL_Duyet = qL_Duyet;
    }

    public String getThoiGian_MPH() {
        return thoiGian_MPH;
    }
    public void setThoiGian_MPH(Timestamp thoiGian_MPH) {
        this.thoiGian_MPH = Converter.timestampToString(thoiGian_MPH);
    }
    public void setThoiGian_MPH(String thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }
    
    public String getYeuCauHocCu() {
        return yeuCauHocCu;
    }

    public void setYeuCauHocCu(String yeuCauHocCu) {
        this.yeuCauHocCu = yeuCauHocCu;
    }

    public String getqL_Duyet() {
        return qL_Duyet;
    }

    public void setqL_Duyet(String qL_Duyet) {
        this.qL_Duyet = qL_Duyet;
    }

}
