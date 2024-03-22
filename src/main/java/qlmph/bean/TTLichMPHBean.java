package qlmph.bean;

import java.sql.Timestamp;

// Danh sách models liên kết
import qlmph.models.QLTaiKhoan.GiangVien;       // Model Giảng viên
import qlmph.models.QLTaiKhoan.QuanLy;          // Model Quản lý
import qlmph.models.QLTaiKhoan.SinhVien;        // Model Sinh viên
import qlmph.models.QLTaiKhoan.UserOneTime;     // Model Tài khoản dùng một lần
import qlmph.models.QLThongTin.LichMuonPhong;   // Model Lịch mượn phòng
import qlmph.models.QLThongTin.LopHoc;          // Model Lớp học
import qlmph.models.QLThongTin.LopSV;           // Model Lớp sinh viên
import qlmph.models.QLThongTin.MonHoc;          // Model Môn học
import qlmph.models.QLThongTin.MuonPhongHoc;    // Model Thủ tục mượn phòng học
import qlmph.models.QLThongTin.PhongHoc;        // Model Phòng học
// Thư viện dự án
import qlmph.utils.Converter;
import qlmph.utils.IsNull;

public class TTLichMPHBean {
    private String maLMPH;          // Mã Lịch mượn phòng học
    private String maPH;            // Mã Phòng học
    private String maLH;            // Mã Lớp học
    private int idMPH;              // Id Thủ thục mượn phòng
    private String thoiGian_BD;     // Thời gian mượn
    private String thoiGian_KT;     // Thời gian trả
    private String mucDich;         // Mục đích sử dụng phòng
    private String lyDo;            // Lý do sử dụng mục đích khác hoặc thay đổi phòng
    private String _CreateAt;       // Thời điểm khởi tạo lịch mượn phòng
    private String _DeleteAt;       // Thời điểm hủy lịch mượn phòng
    private String tinhTrangPH;     // Tình trạng phòng học
    private String _DeactiveAtPH;   // Thời điểm hủy trạng thái phòng học
    private int idGVGiangDay;       // Id Giảng viên giảng dạy
    private String maMH;            // Mã Môn học
    private String maLopSV;         // Mã Lớp sinh viên
    private String hoTenGiangVien;  // Họ tên giảng viên giảng dạy
    private String monHoc;          // Tên môn học
    private String lopSV;           // Tên lớp sinh viên
    private int idNgMPH;            // Id Người mượn phòng
    private int idQLDuyet;          // Id Quản lý duyệt
    private String thoiGian_MPH;    // Thời điểm mượn phòng
    private String thoiGian_TPH;    // Thời điểm trả phòng
    private String yeuCau;          // Yêu cầu học cụ hoặc trang thiết bị phòng học
    private String hoTenNgMPH;      // Họ tên người mượn phòng
    private String vaiTroNgMPH;     // Vai trò người mượn phòng 
    private String hoTenQLDuyet;    // Họ tên quản lý duyệt
    private String trangThai;       // Trạng thái duyệt

    public TTLichMPHBean() {
    }
    // Khởi tạo và nhập thông tin đồng thời
    public TTLichMPHBean(LichMuonPhong lichMuonPhong, PhongHoc phongHoc, LopHoc lopHoc, GiangVien giangVien, MonHoc monHoc,
            LopSV lopSV, MuonPhongHoc muonPhongHoc, SinhVien ngMPH_SV, GiangVien ngMPH_GV, UserOneTime ngMPH_UOT, QuanLy quanLy) {
        if(lichMuonPhong != null) {
            if(lichMuonPhong.getMaLMPH() != null) this.maLMPH = lichMuonPhong.getMaLMPH();
            if(lichMuonPhong.getMaPH() != null) this.maPH = lichMuonPhong.getMaPH();
            if(lichMuonPhong.getMaLH() != null) this.maLH = lichMuonPhong.getMaLH();
            if(lichMuonPhong.getIdMPH() != IsNull.UUID) this.idMPH = lichMuonPhong.getIdMPH();
            if(lichMuonPhong.getThoiGian_BD() != null) this.thoiGian_BD = Converter.timestampToString(lichMuonPhong.getThoiGian_BD());
            if(lichMuonPhong.getThoiGian_KT() != null) this.thoiGian_KT = Converter.timestampToString(lichMuonPhong.getThoiGian_KT());
            if(lichMuonPhong.getMucDich() != null) this.mucDich = lichMuonPhong.getMucDich();
            if(lichMuonPhong.getLyDo() != null) this.lyDo = lichMuonPhong.getLyDo();
            if(lichMuonPhong.get_CreateAt() != null) this._CreateAt = Converter.timestampToString(lichMuonPhong.get_CreateAt());
            if(lichMuonPhong.get_DeleteAt() != null) this._DeleteAt = Converter.timestampToString(lichMuonPhong.get_DeleteAt());
            if(phongHoc != null && this.maPH.equals(phongHoc.getMaPH())) {
                if(phongHoc.getTinhTrang() != null) this.tinhTrangPH = phongHoc.getTinhTrang();
                if(phongHoc.get_DeactiveAt() != null) this._DeactiveAtPH = Converter.timestampToString(phongHoc.get_DeactiveAt());
            }
            if(lopHoc != null && this.maLH.equals(lopHoc.getMaLH())) {
                if(lopHoc.getIdGVGiangDay() != IsNull.UUID) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
                if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
                if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
                if(giangVien != null && this.idGVGiangDay == giangVien.getIdGV()) {
                    if(giangVien.getHoTen() != null) this.hoTenGiangVien = giangVien.getHoTen();
                }
                if(monHoc != null && this.maMH.equals(monHoc.getMaMH())) {
                    if(monHoc.getMonHoc() != null) this.monHoc = monHoc.getMonHoc();
                }
                if(lopSV != null && this.maLopSV.equals(lopSV.getMaLopSV())) {
                    if(lopSV.getLopSV() != null) this.lopSV = lopSV.getLopSV();
                }
            }
            if(muonPhongHoc != null && this.idMPH == muonPhongHoc.getIdMPH()) {
                if(muonPhongHoc.getIdNgMPH() != IsNull.UUID) this.idNgMPH = muonPhongHoc.getIdNgMPH();
                if(muonPhongHoc.getIdQLDuyet() != IsNull.UUID) this.idQLDuyet = muonPhongHoc.getIdQLDuyet();
                if(muonPhongHoc.getThoiGian_MPH() != null) this.thoiGian_MPH = Converter.timestampToString(muonPhongHoc.getThoiGian_MPH());
                if(muonPhongHoc.getThoiGian_TPH() != null) this.thoiGian_TPH = Converter.timestampToString(muonPhongHoc.getThoiGian_TPH());
                if(muonPhongHoc.getYeuCau() != null) this.yeuCau = muonPhongHoc.getYeuCau();
                if(ngMPH_SV != null && this.idNgMPH == ngMPH_SV.getIdSV()) {
                    if(ngMPH_SV.getHoTen() != null) this.hoTenNgMPH = ngMPH_SV.getHoTen();
                    this.vaiTroNgMPH = "Sinh viên";
                }
                else if(ngMPH_GV != null && this.idNgMPH == ngMPH_GV.getIdGV()) {
                    if(ngMPH_GV.getHoTen() != null) this.hoTenNgMPH = ngMPH_GV.getHoTen();
                    this.vaiTroNgMPH = "Giảng viên";
                }
                else if(ngMPH_UOT != null && this.idNgMPH == ngMPH_UOT.getIdUserOneTime()) {
                    this.hoTenNgMPH = "Không ghi nhận";
                    this.vaiTroNgMPH = "Khác";
                }
                if(quanLy != null && this.idQLDuyet == quanLy.getIdQL()) {
                    if(quanLy.getHoTen() != null) this.hoTenQLDuyet = quanLy.getHoTen();
                }
            }
            if(this.idMPH != IsNull.UUID) {this.trangThai = "Đã mượn phòng";} 
            else if(this._DeleteAt != null) {this.trangThai = "Đã hủy phòng";}
            else {this.trangThai = "Chưa mượn phòng";}
        }
    }
    public void getLichMuonPhong(LichMuonPhong lichMuonPhong) {
        if(lichMuonPhong != null) {
            if(lichMuonPhong.getMaLMPH() != null) this.maLMPH = lichMuonPhong.getMaLMPH();
            if(lichMuonPhong.getMaPH() != null) this.maPH = lichMuonPhong.getMaPH();
            if(lichMuonPhong.getMaLH() != null) this.maLH = lichMuonPhong.getMaLH();
            if(lichMuonPhong.getIdMPH() != IsNull.UUID) this.idMPH = lichMuonPhong.getIdMPH();
            if(lichMuonPhong.getThoiGian_BD() != null) this.thoiGian_BD = Converter.timestampToString(lichMuonPhong.getThoiGian_BD());
            if(lichMuonPhong.getThoiGian_KT() != null) this.thoiGian_KT = Converter.timestampToString(lichMuonPhong.getThoiGian_KT());
            if(lichMuonPhong.getMucDich() != null) this.mucDich = lichMuonPhong.getMucDich();
            if(lichMuonPhong.getLyDo() != null) this.lyDo = lichMuonPhong.getLyDo();
            if(lichMuonPhong.get_CreateAt() != null) this._CreateAt = Converter.timestampToString(lichMuonPhong.get_CreateAt());
            if(lichMuonPhong.get_DeleteAt() != null) this._DeleteAt = Converter.timestampToString(lichMuonPhong.get_DeleteAt());
            if(this.idMPH != IsNull.UUID) {this.trangThai = "Đã mượn phòng";} 
            else if(this._DeleteAt != null) {this.trangThai = "Đã hủy phòng";}
            else {this.trangThai = "Chưa mượn phòng";}
        }
    }
    public void getPhongHoc(PhongHoc phongHoc) {
        if(phongHoc != null && this.maPH.equals(phongHoc.getMaPH())) {
            if(phongHoc.getTinhTrang() != null) this.tinhTrangPH = phongHoc.getTinhTrang();
            if(phongHoc.get_DeactiveAt() != null) this._DeactiveAtPH = Converter.timestampToString(phongHoc.get_DeactiveAt());
        }
    }
    public void getLopHoc(LopHoc lopHoc) {
        if(lopHoc != null && this.maLH.equals(lopHoc.getMaLH())) {
            if(lopHoc.getIdGVGiangDay() != IsNull.UUID) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
            if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
            if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
        }
    } 
    public void getGiangVien(GiangVien giangVien) {
        if(giangVien != null && this.idGVGiangDay == giangVien.getIdGV()) {
            if(giangVien.getHoTen() != null) this.hoTenGiangVien = giangVien.getHoTen();
        }
    }
    public void getMonHoc(MonHoc monHoc) {
        if(monHoc != null && this.maMH.equals(monHoc.getMaMH())) {
            if(monHoc.getMonHoc() != null) this.monHoc = monHoc.getMonHoc();
        }
    }
    public void getLopSV(LopSV lopSV) {
        if(lopSV != null && this.maLopSV.equals(lopSV.getMaLopSV())) {
            if(lopSV.getLopSV() != null) this.lopSV = lopSV.getLopSV();
        }
    }
    public void getMuonPhongHoc(MuonPhongHoc muonPhongHoc) {
        if(muonPhongHoc != null && this.idMPH == muonPhongHoc.getIdMPH()) {
            if(muonPhongHoc.getIdNgMPH() != IsNull.UUID) this.idNgMPH = muonPhongHoc.getIdNgMPH();
            if(muonPhongHoc.getIdQLDuyet() != IsNull.UUID) this.idQLDuyet = muonPhongHoc.getIdQLDuyet();
            if(muonPhongHoc.getThoiGian_MPH() != null) this.thoiGian_MPH = Converter.timestampToString(muonPhongHoc.getThoiGian_MPH());
            if(muonPhongHoc.getThoiGian_TPH() != null) this.thoiGian_TPH = Converter.timestampToString(muonPhongHoc.getThoiGian_TPH());
            if(muonPhongHoc.getYeuCau() != null) this.yeuCau = muonPhongHoc.getYeuCau();
        }
    }
    public void getNgMPH(SinhVien ngMPH_SV) {
        if(ngMPH_SV != null && this.idNgMPH == ngMPH_SV.getIdSV()) {
            if(ngMPH_SV.getHoTen() != null) this.hoTenNgMPH = ngMPH_SV.getHoTen();
            this.vaiTroNgMPH = "Sinh viên";
        }
    }
    public void getNgMPH(GiangVien ngMPH_GV) {
        if(ngMPH_GV != null && this.idNgMPH == ngMPH_GV.getIdGV()) {
            if(ngMPH_GV.getHoTen() != null) this.hoTenNgMPH = ngMPH_GV.getHoTen();
            this.vaiTroNgMPH = "Sinh viên";
        }
    }
    public void getNgMPH(UserOneTime ngMPH_UOT) {
        if(ngMPH_UOT != null && this.idNgMPH == ngMPH_UOT.getIdUserOneTime()) {
            this.hoTenNgMPH = "Không ghi nhận";
            this.vaiTroNgMPH = "Khác";
        }
    }
    public void getQLDuyet(QuanLy quanLy) {
        if(quanLy != null && this.idQLDuyet == quanLy.getIdQL()) {
            if(quanLy.getHoTen() != null) this.hoTenQLDuyet = quanLy.getHoTen();
        }
    }
    public String getMaLMPH() {
        return maLMPH;
    }
    public void setMaLMPH(String maLMPH) {
        this.maLMPH = maLMPH;
    }
    public String getMaPH() {
        return maPH;
    }
    public void setMaPH(String maPH) {
        this.maPH = maPH;
    }
    public String getMaLH() {
        return maLH;
    }
    public void setMaLH(String maLH) {
        this.maLH = maLH;
    }
    public int getIdMPH() {
        return idMPH;
    }
    public void setIdMPH(int idMPH) {
        this.idMPH = idMPH;
    }
    public String getThoiGian_BD() {
        return thoiGian_BD;
    }
    public void setThoiGian_BD(Timestamp thoiGian_BD) {
        this.thoiGian_BD = Converter.dateToString(thoiGian_BD);
    }
    public void setThoiGian_BD(String thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }
    public String getThoiGian_KT() {
        return thoiGian_KT;
    }
    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        this.thoiGian_KT = Converter.dateToString(thoiGian_KT);
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
    public String get_CreateAt() {
        return _CreateAt;
    }
    public void set_CreateAt(Timestamp _CreateAt) {
        this._CreateAt = Converter.dateToString(_CreateAt);
    }
    public void set_CreateAt(String _CreateAt) {
        this._CreateAt = _CreateAt;
    }
    public String get_DeleteAt() {
        return _DeleteAt;
    }
    public void set_DeleteAt(Timestamp _DeleteAt) {
        this._DeleteAt = Converter.dateToString(_DeleteAt);
    }
    public void set_DeleteAt(String _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }
    public String getTinhTrangPH() {
        return tinhTrangPH;
    }
    public void setTinhTrangPH(String tinhTrangPH) {
        this.tinhTrangPH = tinhTrangPH;
    }
    public String get_DeactiveAtPH() {
        return _DeactiveAtPH;
    }
    public void set_DeactiveAtPH(Timestamp _DeactiveAtPH) {
        this._DeactiveAtPH = Converter.dateToString(_DeactiveAtPH);
    }
    public void set_DeactiveAtPH(String _DeactiveAtPH) {
        this._DeactiveAtPH = _DeactiveAtPH;
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
    public int getIdNgMPH() {
        return idNgMPH;
    }
    public void setIdNgMPH(int idNgMPH) {
        this.idNgMPH = idNgMPH;
    }
    public int getIdQLDuyet() {
        return idQLDuyet;
    }
    public void setIdQLDuyet(int idQLDuyet) {
        this.idQLDuyet = idQLDuyet;
    }
    public String getThoiGian_MPH() {
        return thoiGian_MPH;
    }
    public void setThoiGian_MPH(Timestamp thoiGian_MPH) {
        this.thoiGian_MPH = Converter.dateToString(thoiGian_MPH);
    }
    public void setThoiGian_MPH(String thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }
    public String getThoiGian_TPH() {
        return thoiGian_TPH;
    }
    public void setThoiGian_TPH(Timestamp thoiGian_TPH) {
        this.thoiGian_TPH = Converter.dateToString(thoiGian_TPH);
    }
    public void setThoiGian_TPH(String thoiGian_TPH) {
        this.thoiGian_TPH = thoiGian_TPH;
    }
    public String getYeuCau() {
        return yeuCau;
    }
    public void setYeuCau(String yeuCau) {
        this.yeuCau = yeuCau;
    }
    public String getHoTenNgMPH() {
        return hoTenNgMPH;
    }
    public void setHoTenNgMPH(String hoTenNgMPH) {
        this.hoTenNgMPH = hoTenNgMPH;
    }
    public String getVaiTroNgMPH() {
        return vaiTroNgMPH;
    }
    public void setVaiTroNgMPH(String vaiTroNgMPH) {
        this.vaiTroNgMPH = vaiTroNgMPH;
    }
    public String getHoTenQLDuyet() {
        return hoTenQLDuyet;
    }
    public void setHoTenQLDuyet(String hoTenQLDuyet) {
        this.hoTenQLDuyet = hoTenQLDuyet;
    }
    public String getTrangThai() {
        return trangThai;
    }
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}
