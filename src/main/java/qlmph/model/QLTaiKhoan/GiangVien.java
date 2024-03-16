package QlMuonPhongHoc.model.QLTaiKhoan;

import java.util.UUID;
import java.sql.Date;

public class GiangVien {
    private UUID IdGV;
    private UUID IdTaiKhoan;
    private String HoTen;
    private Date NgaySinh;
    private boolean GioiTinh;
    private String Email;
    private String SDT;
    private String MaGV;
    private String ChucDanh;
    
    public GiangVien() {
    }

    public GiangVien(UUID idGV, UUID idTaiKhoan, String hoTen, Date ngaySinh, boolean gioiTinh, String email,
            String sDT, String maGV, String chucDanh) {
        IdGV = idGV;
        IdTaiKhoan = idTaiKhoan;
        HoTen = hoTen;
        NgaySinh = ngaySinh;
        GioiTinh = gioiTinh;
        Email = email;
        SDT = sDT;
        MaGV = maGV;
        ChucDanh = chucDanh;
    }

    public UUID getIdGV() {
        return IdGV;
    }

    public void setIdGV(UUID idGV) {
        IdGV = idGV;
    }

    public UUID getIdTaiKhoan() {
        return IdTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        IdTaiKhoan = idTaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public void setHoTen(String hoTen) {
        HoTen = hoTen;
    }

    public Date getNgaySinh() {
        return NgaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        NgaySinh = ngaySinh;
    }

    public boolean isGioiTinh() {
        return GioiTinh;
    }

    public void setGioiTinh(boolean gioiTinh) {
        GioiTinh = gioiTinh;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String sDT) {
        SDT = sDT;
    }

    public String getMaGV() {
        return MaGV;
    }

    public void setMaGV(String maGV) {
        MaGV = maGV;
    }

    public String getChucDanh() {
        return ChucDanh;
    }

    public void setChucDanh(String chucDanh) {
        ChucDanh = chucDanh;
    } 
}
class TestGetData {
    public GiangVien getAlldata () {
        //Lấy dữ liệu trong SQL
        GiangVien giangvien = new GiangVien('alldataSQl');

    }
    public GiangVien findGiangVienByMaGV () {
        //Lấy dữ liệu trong SQL
        List<GiangVien> DsGiangVien = new ArrayLIst<GiangVien>('alldataSQl');
        for (iterable_type iterable_element : iterable) {
            
        }
    }
}
