/*  
Định nghĩa dữ liệu xử lý:
    MaLMPH          -   Mã lịch mượn phòng
    MaLH            -   Mã lớp học
    IdGV            -   Id giảng viên
    GiangVien       -   Họ tên giảng viên
    MaLopSV         -   Mã lớp giảng dạy
    MaMH            -   Mã môn học
    TenMH           -   Tên môn học
    MaPH            -   Mã phòng học    
    ThoiGian_BD     -   Thời gian mượn
    ThoiGian_KT     -   Thời gian trả
    HinhThuc        -   Hình thức
    Lydo            -   Lý do tạo lịch mượn phòng học
    IdNgMPH         -   Id người mượn phòng học
    NgMPH           -   Người mượn phòng học
    VaiTro          -   Vai trò người mượn phòng
    IdQL_Duyet      -   Id quản lý duyệt
    QL_Duyet        -   Quản lý duyệt
    ThoiGian_MPH    -   Thời gian mượn phòng học
    YeuCauHocCu     -   Yêu cầu học cụ
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
    MaLMPH          -   Mã lịch mượn phòng
    MaLH            -   Mã lớp học
    GiangVien       -   Họ tên giảng viên
    MaLopSV         -   Mã lớp giảng dạy
    MaMH            -   Mã môn học
    TenMH           -   Tên môn học
    MaPH            -   Mã phòng học    
    ThoiGian_BD     -   Thời gian mượn
    ThoiGian_KT     -   Thời gian trả
    HinhThuc        -   Hình thức
    Lydo            -   Lý do tạo lịch mượn phòng học
    TrangThai       -   Trạng thái mượn phòng học
    NgMPH           -   Người mượn phòng học
    VaiTro          -   Vai trò người mượn phòng
    QL_Duyet        -   Quản lý duyệt
    ThoiGian_MPH    -   Thời gian mượn phòng học
    YeuCauHocCu     -   Yêu cầu học cụ
*/
package qlmph.bean;

import java.sql.Timestamp;

import qlmph.utils.handleDataType;

public class TTLichMPH {
    private String maLMPH;
    private String maLH;
    private String giangVien;
    private String maLopSV;
    private String maMH;
    private String tenMH;
    private String maPH;
    private String thoiGian_BD;
    private String thoiGian_KT;
    private String hinhThuc;
    private String lyDo;
    private String trangThai;
    private String ngMPH;
    private String vaiTro;
    private String qL_Duyet;
    private String thoiGian_MPH;
    private String yeuCauHocCu;

    public TTLichMPH() {
    }

    // Chỉ sử dụng để test
    public TTLichMPH(String maLMPH, String maLH, String giangVien, String maLopSV, String maMH, String tenMH,
            String maPH, Timestamp thoiGian_BD, Timestamp thoiGian_KT, String hinhThuc, String lyDo, String trangThai,
            String ngMPH, String vaiTro, String qL_Duyet, Timestamp thoiGian_MPH, String yeuCauHocCu) {
        this.maLMPH = maLMPH;
        this.maLH = maLH;
        this.giangVien = giangVien;
        this.maLopSV = maLopSV;
        this.maMH = maMH;
        this.tenMH = tenMH;
        this.maPH = maPH;
        this.thoiGian_BD = handleDataType.timestampToString(thoiGian_BD);
        this.thoiGian_KT = handleDataType.timestampToString(thoiGian_KT);
        this.hinhThuc = hinhThuc;
        this.lyDo = lyDo;
        this.trangThai = trangThai;
        this.ngMPH = ngMPH;
        this.vaiTro = vaiTro;
        this.qL_Duyet = qL_Duyet;
        this.thoiGian_MPH = handleDataType.timestampToString(thoiGian_MPH);
        this.yeuCauHocCu = yeuCauHocCu;
    }


    public TTLichMPH(String maLMPH, String maLH, String giangVien, String maLopSV, String maMH, String tenMH,
            String maPH, String thoiGian_BD, String thoiGian_KT, String hinhThuc, String lyDo, String trangThai,
            String ngMPH, String vaiTro, String qL_Duyet, String thoiGian_MPH, String yeuCauHocCu) {
        this.maLMPH = maLMPH;
        this.maLH = maLH;
        this.giangVien = giangVien;
        this.maLopSV = maLopSV;
        this.maMH = maMH;
        this.tenMH = tenMH;
        this.maPH = maPH;
        this.thoiGian_BD = thoiGian_BD;
        this.thoiGian_KT = thoiGian_KT;
        this.hinhThuc = hinhThuc;
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
        this.thoiGian_BD = handleDataType.timestampToString(thoiGian_BD);
    }
    public void setThoiGian_BD(String thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }
    public String getThoiGian_KT() {
        return thoiGian_KT;
    }
    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        this.thoiGian_KT = handleDataType.timestampToString(thoiGian_KT);
    }
    public void setThoiGian_KT(String thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }
    public String getHinhThuc() {
        return hinhThuc;
    }
    public void setHinhThuc(String hinhThuc) {
        this.hinhThuc = hinhThuc;
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
        this.thoiGian_MPH = handleDataType.timestampToString(thoiGian_MPH);
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
