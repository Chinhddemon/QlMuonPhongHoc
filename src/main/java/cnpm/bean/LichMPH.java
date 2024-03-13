/*  
Định nghĩa khối dữ liệu:
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
    LyDo            -   Lý do
    TrangThai       -   Trạng thái mượn
    IdNgMPH         -   Id người mượn phòng học
    NgMPH           -   Người mượn phòng học
    VaiTro          -   Vai trò người mượn phòng
    IdQL_Duyet      -   Id quản lý duyệt
    QL_Duyet        -   Quản lý duyệt
    YeuCau          -   Yêu cầu khi mượn
Xử lý nhận đầu vào từ Model:
    BuoiHoc
    CapPhepMPH
    DoiBuoiHoc
    LopHoc
    GiangVien
    MonHoc
    PhongHoc
    MuonPhongHoc
    QuanLy
Xử lý thông tin tại controller:
    MaLMPH = MaBH ? "B" + MaBH : (MaCP ? "C" + MaCP : ( MaDBH ? "D" + MaDBH : ""))
    TrangThai = IdMPH || MaDBH ? (_DeleteAt ? "Đã hủy" : "Đã mượn phòng") : "Chưa mượn phòng"  
Xử lý trả kết quả tới View:
    MaLMPH          -   Mã lịch mượn phòng
    MaLH            -   Mã lớp học
    GiangVien       -   Họ tên giảng viên
    MaLopSV         -   Mã lớp giảng dạy
    TenMH           -   Tên môn học
    MaPH            -   Mã phòng học    
    ThoiGian_BD     -   Thời gian mượn
    ThoiGian_KT     -   Thời gian trả
    HinhThuc        -   Hình thức
    LyDo            -   Lý do
    TrangThai       -   Trạng thái mượn
    NgMPH           -   Người mượn phòng học
    VaiTro          -   Vai trò người mượn phòng
    QL_Duyet        -   Quản lý duyệt
    YeuCau          -   Yêu cầu khi mượn
*/
package cnpm.bean;

import java.sql.Timestamp;
import java.util.UUID;

public class LichMPH {
    private String MaLMPH;
    private String MaLH;
    private UUID IdGV;
    private String GiangVien;
    private String MaLopSV;
    private String MaMH;
    private String TenMH;
    private String MaPH;
    private Timestamp ThoiGian_BD;
    private Timestamp ThoiGian_KT;
    private String HinhThuc;
    private String LyDo;
    private String TrangThai;
    private UUID IdNgMPH;
    private String NgMPH;
    private String VaiTro;
    private UUID IdQL_Duyet;
    private String QL_Duyet;
    private String YeuCau;

    public LichMPH() {
    }

    public String getMaLMPH() {
        return MaLMPH;
    }
    public void setMaLMPH(String maLMPH) {
        MaLMPH = maLMPH;
    }
    public String getMaLH() {
        return MaLH;
    }
    public void setMaLH(String maLH) {
        MaLH = maLH;
    }
    public UUID getIdGV() {
        return IdGV;
    }
    public void setIdGV(UUID idGV) {
        IdGV = idGV;
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
    public String getMaPH() {
        return MaPH;
    }
    public void setMaPH(String maPH) {
        MaPH = maPH;
    }
    public Timestamp getThoiGian_BD() {
        return ThoiGian_BD;
    }
    public void setThoiGian_BD(Timestamp thoiGian_BD) {
        ThoiGian_BD = thoiGian_BD;
    }
    public Timestamp getThoiGian_KT() {
        return ThoiGian_KT;
    }
    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        ThoiGian_KT = thoiGian_KT;
    }
    public String getHinhThuc() {
        return HinhThuc;
    }
    public void setHinhThuc(String hinhThuc) {
        HinhThuc = hinhThuc;
    }
    public String getLyDo() {
        return LyDo;
    }
    public void setLyDo(String lyDo) {
        LyDo = lyDo;
    }
    public String getTrangThai() {
        return TrangThai;
    }
    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }
    public UUID getIdNgMPH() {
        return IdNgMPH;
    }
    public void setIdNgMPH(UUID idNgMPH) {
        IdNgMPH = idNgMPH;
    }
    public String getNgMPH() {
        return NgMPH;
    }
    public void setNgMPH(String ngMPH) {
        NgMPH = ngMPH;
    }
    public String getVaiTro() {
        return VaiTro;
    }
    public void setVaiTro(String vaiTro) {
        VaiTro = vaiTro;
    }
    public UUID getIdQL_Duyet() {
        return IdQL_Duyet;
    }
    public void setIdQL_Duyet(UUID idQL_Duyet) {
        IdQL_Duyet = idQL_Duyet;
    }
    public String getQL_Duyet() {
        return QL_Duyet;
    }
    public void setQL_Duyet(String qL_Duyet) {
        QL_Duyet = qL_Duyet;
    }
    public String getYeuCau() {
        return YeuCau;
    }
    public void setYeuCau(String yeuCau) {
        YeuCau = yeuCau;
    }
}
