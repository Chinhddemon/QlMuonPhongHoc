package qlmph.bean;

import java.sql.Timestamp;
import java.util.UUID;

// Danh sách models liên kết
import qlmph.models.QLTaiKhoan.GiangVien;       // Model Giảng viên
import qlmph.models.QLTaiKhoan.QuanLy;          // Model Quản lý
import qlmph.models.QLTaiKhoan.SinhVien;        // Model Sinh viên
import qlmph.models.QLTaiKhoan.VaiTro;          // Model Vai Trò
import qlmph.models.QLThongTin.LichMuonPhong;   // Model Lịch mượn phòng
import qlmph.models.QLThongTin.LopHoc;          // Model Lớp học
import qlmph.models.QLThongTin.MonHoc;          // Model Môn học
import qlmph.models.QLThongTin.MuonPhongHoc;    // Model Thủ tục mượn phòng học
// Thư viện dự án
import qlmph.utils.Converter;
import qlmph.utils.IsNull;

public class TTLichMPHBean {
    // Model Lịch mượn phòng
    private String idLMPH;              // Id Lịch mượn phòng học
    private String maPH;                // Mã Phòng học
    private String idLH;                // Id Lớp học
    private String idMPH;               // Id Thủ thục mượn phòng
    private String thoiGian_BD;         // Thời gian mượn
    private String thoiGian_KT;         // Thời gian trả
    private String mucDich;             // Mục đích sử dụng phòng
    private String lyDo;                // Lý do sử dụng mục đích khác hoặc thay đổi phòng
    private String _DeleteAt;           // Thời điểm hủy lịch mượn phòng
    // Others for Model Lịch mượn phòng
    private String trangThai;           // Trạng thái duyệt  
    // Model Lớp học
    private UUID idGVGiangDay;          // Id Giảng viên giảng dạy
    private String maMH;                // Mã Môn học
    private String maLopSV;             // Mã Lớp sinh viên
    // Model Giảng viên
    private String hoTenGiangVien;      // Họ tên giảng viên giảng dạy
    // Model Môn học
    private String tenMonHoc;           // Tên môn học
    // Model Thủ tục mượn phòng học
    private UUID idTaiKhoan;            // Id Tài khoản mượn phòng
    private UUID idQLDuyet;             // Id Quản lý duyệt
    private short idVaiTro;             
    private String thoiGian_MPH;        // Thời điểm mượn phòng
    private String thoiGian_TPH;        // Thời điểm trả phòng
    private String yeuCau;              // Yêu cầu học cụ hoặc trang thiết bị phòng học
    // Model vai trò
    private String tenVaiTro;           // Vai trò người mượn phòng 
    // Model người mượn phòng học
    private String maNgMPH;             // Mã người mượn phòng
    private String hoTenNgMPH;          // Họ tên người mượn phòng
    // Model Quản lý
    private String maQL;                // Mã quản lý duyệt
    private String hoTenQuanLy;         // Họ tên quản lý duyệt
    
    public TTLichMPHBean() {
    }
    

    public TTLichMPHBean(String idLMPH, String maPH, String idLH, String idMPH, String thoiGian_BD, String thoiGian_KT,
			String mucDich, String lyDo, String _DeleteAt, String trangThai, UUID idGVGiangDay, String maMH,
			String maLopSV, String hoTenGiangVien, String tenMonHoc, UUID idQLDuyet, short idVaiTro,
			String thoiGian_MPH, String thoiGian_TPH, String yeuCau, String tenVaiTro, UUID idTaiKhoan, String maNgMPH,
			String hoTenNgMPH, String maQL, String hoTenQuanLy) {
		super();
		this.idLMPH = idLMPH;
		this.maPH = maPH;
		this.idLH = idLH;
		this.idMPH = idMPH;
		this.thoiGian_BD = thoiGian_BD;
		this.thoiGian_KT = thoiGian_KT;
		this.mucDich = mucDich;
		this.lyDo = lyDo;
		this._DeleteAt = _DeleteAt;
		this.trangThai = trangThai;
		this.idGVGiangDay = idGVGiangDay;
		this.maMH = maMH;
		this.maLopSV = maLopSV;
		this.hoTenGiangVien = hoTenGiangVien;
		this.tenMonHoc = tenMonHoc;
		this.idQLDuyet = idQLDuyet;
		this.idVaiTro = idVaiTro;
		this.thoiGian_MPH = thoiGian_MPH;
		this.thoiGian_TPH = thoiGian_TPH;
		this.yeuCau = yeuCau;
		this.tenVaiTro = tenVaiTro;
        this.idTaiKhoan = idTaiKhoan;
		this.maNgMPH = maNgMPH;
		this.hoTenNgMPH = hoTenNgMPH;
		this.maQL = maQL;
		this.hoTenQuanLy = hoTenQuanLy;
	}


	public TTLichMPHBean(LichMuonPhong lichMuonPhong, LopHoc lopHoc, GiangVien giangVien, MonHoc monHoc, MuonPhongHoc muonPhongHoc,
        VaiTro vaiTro,Object NgMPH, QuanLy quanLy) {
        if(lichMuonPhong != null) {
            if(lichMuonPhong.getIdLMPH() != IsNull.Int) this.idLMPH = Converter.toString8Char(lichMuonPhong.getIdLMPH());
            if(lichMuonPhong.getMaPH() != null) this.maPH = lichMuonPhong.getMaPH();
            if(lichMuonPhong.getIdLH() != IsNull.Int) this.idLH = Converter.toString8Char(lichMuonPhong.getIdLH());
            if(lichMuonPhong.getIdMPH() != IsNull.Int) this.idMPH = Converter.toString8Char(lichMuonPhong.getIdMPH());
            if(lichMuonPhong.getThoiGian_BD() != null) this.thoiGian_BD = Converter.toString(lichMuonPhong.getThoiGian_BD());
            if(lichMuonPhong.getThoiGian_KT() != null) this.thoiGian_KT = Converter.toString(lichMuonPhong.getThoiGian_KT());
            if(lichMuonPhong.getMucDich() != null) this.mucDich = lichMuonPhong.getMucDich();
            if(lichMuonPhong.getLyDo() != null) this.lyDo = lichMuonPhong.getLyDo();
            if(lichMuonPhong.get_DeleteAt() != null) this._DeleteAt = Converter.toString(lichMuonPhong.get_DeleteAt());
            if(this.idMPH != null) {this.trangThai = "Đã mượn phòng";} 
            else if(this._DeleteAt != null) {this.trangThai = "Đã hủy phòng";}
            else {this.trangThai = "Chưa mượn phòng";}
        }
        if(lopHoc != null) {
            if(lopHoc.getIdGVGiangDay() != IsNull.UUID) this.idGVGiangDay = lopHoc.getIdGVGiangDay();
            if(lopHoc.getMaMH() != null) this.maMH = lopHoc.getMaMH();
            if(lopHoc.getMaLopSV() != null) this.maLopSV = lopHoc.getMaLopSV();
            
        }
        if(giangVien != null) {
            if(giangVien.getHoTen() != null) this.hoTenGiangVien = giangVien.getHoTen();
        }
        if(monHoc != null) {
            if(monHoc.getTenMonHoc() != null) this.tenMonHoc = monHoc.getTenMonHoc();
        }
        if(muonPhongHoc != null) {
            if(muonPhongHoc.getIdTaiKhoan() != IsNull.UUID) this.idTaiKhoan = muonPhongHoc.getIdTaiKhoan();
            if(muonPhongHoc.getIdQLDuyet() != IsNull.UUID) this.idQLDuyet = muonPhongHoc.getIdQLDuyet();
            if(muonPhongHoc.getThoiGian_MPH() != null) this.thoiGian_MPH = Converter.toString(muonPhongHoc.getThoiGian_MPH());
            if(muonPhongHoc.getThoiGian_TPH() != null) this.thoiGian_TPH = Converter.toString(muonPhongHoc.getThoiGian_TPH());
            if(muonPhongHoc.getYeuCau() != null) this.yeuCau = muonPhongHoc.getYeuCau();
        }
        if(vaiTro != null) {
            if(vaiTro.getTenVaitro() != null) this.tenVaiTro = vaiTro.getTenVaitro();
            if(this.tenVaiTro.equals("Sinh viên")) {
                if(NgMPH instanceof SinhVien) {
                    SinhVien svMPH = (SinhVien) NgMPH;
                    if(svMPH.getMaSV() != null) this.maNgMPH = svMPH.getMaSV();
                    if(svMPH.getHoTen() != null) this.hoTenNgMPH = svMPH.getHoTen();
                }
                else if(NgMPH instanceof GiangVien) {
                    GiangVien gvMPH = (GiangVien) NgMPH;
                    if(gvMPH.getMaGV() != null) this.maNgMPH = gvMPH.getMaGV();
                    if(gvMPH.getHoTen() != null) this.hoTenNgMPH = gvMPH.getHoTen();
                }
            }
        }
        if(quanLy != null) {
            if(quanLy.getHoTen() != null) this.hoTenQuanLy = quanLy.getHoTen();
        }
        
    }

    public String getIdLMPH() {
        return idLMPH;
    }

    public void setIdLMPH(int idLMPH) {
        this.idLMPH = Converter.toString8Char(idLMPH);
    }

    public String getMaPH() {
        return maPH;
    }

    public void setMaPH(String maPH) {
        this.maPH = maPH;
    }

    public String getIdLH() {
        return idLH;
    }

    public void setIdLH(int idLH) {
        this.idLH = Converter.toString8Char(idLH);
    }

    public String getIdMPH() {
        return idMPH;
    }

    public void setIdMPH(int idMPH) {
        this.idMPH = Converter.toString8Char(idMPH);
    }

    public String getThoiGian_BD() {
        return thoiGian_BD;
    }

    public void setThoiGian_BD(Timestamp thoiGian_BD) {
        this.thoiGian_BD = Converter.toString(thoiGian_BD);
    }

    public String getThoiGian_KT() {
        return thoiGian_KT;
    }

    public void setThoiGian_KT(Timestamp thoiGian_KT) {
        this.thoiGian_KT = Converter.toString(thoiGian_KT);
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

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public UUID getIdQLDuyet() {
        return idQLDuyet;
    }

    public void setIdQLDuyet(UUID idQLDuyet) {
        this.idQLDuyet = idQLDuyet;
    }

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getThoiGian_MPH() {
        return thoiGian_MPH;
    }

    public void setThoiGian_MPH(Timestamp thoiGian_MPH) {
        this.thoiGian_MPH = Converter.toString(thoiGian_MPH);
    }

    public String getThoiGian_TPH() {
        return thoiGian_TPH;
    }

    public void setThoiGian_TPH(Timestamp thoiGian_TPH) {
        this.thoiGian_TPH = Converter.toString(thoiGian_TPH);
    }

    public String getYeuCau() {
        return yeuCau;
    }

    public void setYeuCau(String yeuCau) {
        this.yeuCau = yeuCau;
    }

    public String getMaNgMPH() {
        return maNgMPH;
    }

    public void setMaNgMPH(String maNgMPH) {
        this.maNgMPH = maNgMPH;
    }

    public String getHoTenNgMPH() {
        return hoTenNgMPH;
    }

    public void setHoTenNgMPH(String hoTenNgMPH) {
        this.hoTenNgMPH = hoTenNgMPH;
    }

    public String getMaQL() {
        return maQL;
    }

    public void setMaQL(String maQL) {
        this.maQL = maQL;
    }

    public String getHoTenQuanLy() {
        return hoTenQuanLy;
    }

    public void setHoTenQuanLy(String hoTenQuanLy) {
        this.hoTenQuanLy = hoTenQuanLy;
    }

    public String getTenVaiTro() {
        return tenVaiTro;
    }

    public void setTenVaiTro(String tenVaiTro) {
        this.tenVaiTro = tenVaiTro;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String get_DeleteAt() {
        return _DeleteAt;
    }

    public void set_DeleteAt(Timestamp _DeleteAt) {
        this._DeleteAt = Converter.toString(_DeleteAt);
    }

    public void setIdLMPH(String idLMPH) {
        this.idLMPH = idLMPH;
    }

    public void setIdLH(String idLH) {
        this.idLH = idLH;
    }

    public void setIdMPH(String idMPH) {
        this.idMPH = idMPH;
    }

    public void setThoiGian_BD(String thoiGian_BD) {
        this.thoiGian_BD = thoiGian_BD;
    }

    public void setThoiGian_KT(String thoiGian_KT) {
        this.thoiGian_KT = thoiGian_KT;
    }

    public void setThoiGian_MPH(String thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }

    public void setThoiGian_TPH(String thoiGian_TPH) {
        this.thoiGian_TPH = thoiGian_TPH;
    }
    public void set_DeleteAt(String _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }
}
