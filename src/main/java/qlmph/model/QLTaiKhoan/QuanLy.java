package qlmph.model.QLTaiKhoan;

import javax.persistence.*;

import org.hibernate.annotations.Type;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.model.QLThongTin.MuonPhongHoc;

import java.util.Date;
import java.util.Set;
import java.util.UUID;

@Entity
@Table(name = "QuanLy")
public class QuanLy {
    @Id
    @Column(name = "MaQL")
    private String maQL;

    @Column(name = "IdTaiKhoan")
    @Type(type = "uuid-char")
    private UUID idTaiKHoan;

    @Column(name = "HoTen")
    private String hoTen;

    @Column(name = "Email")
    private String email;

    @Column(name = "SDT")
    private String sDT;

    @Column(name = "NgaySinh")
    private Date ngaySinh;

    @Column(name = "GioiTinh")
    private int gioiTinh;

    @Column(name = "DiaChi")
    private String diaChi;

    @OneToMany(mappedBy = "quanLy", fetch = FetchType.LAZY)
    private Set<LichMuonPhong> lichMuonPhongs;

    @OneToMany(mappedBy = "quanLy", fetch = FetchType.LAZY)
    private Set<MuonPhongHoc> muonPhongHocs;

    @Override
    public String toString() {
        return "QuanLy [maQL=" + maQL + ", idTaiKHoan=" + idTaiKHoan + ", hoTen=" + hoTen + ", email=" + email
                + ", sDT=" + sDT + ", ngaySinh=" + ngaySinh + ", gioiTinh=" + gioiTinh + ", diaChi=" + diaChi
                + ", lichMuonPhongs=" + lichMuonPhongs + ", muonPhongHocs=" + muonPhongHocs + "]";
    }

    public QuanLy(String maQL, UUID idTaiKHoan, String hoTen, String email, String sDT, Date ngaySinh, int gioiTinh,
            String diaChi) {
        this.maQL = maQL;
        this.idTaiKHoan = idTaiKHoan;
        this.hoTen = hoTen;
        this.email = email;
        this.sDT = sDT;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.diaChi = diaChi;
    }

    public QuanLy(String maQL, UUID idTaiKHoan, String hoTen, String email, String sDT, Date ngaySinh, int gioiTinh,
            String diaChi, Set<LichMuonPhong> lichMuonPhongs, Set<MuonPhongHoc> muonPhongHocs) {
        this.maQL = maQL;
        this.idTaiKHoan = idTaiKHoan;
        this.hoTen = hoTen;
        this.email = email;
        this.sDT = sDT;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.diaChi = diaChi;
        this.lichMuonPhongs = lichMuonPhongs;
        this.muonPhongHocs = muonPhongHocs;
    }

    public String getMaQL() {
        return maQL;
    }

    public void setMaQL(String maQL) {
        this.maQL = maQL;
    }

    public UUID getIdTaiKHoan() {
        return idTaiKHoan;
    }

    public void setIdTaiKHoan(UUID idTaiKHoan) {
        this.idTaiKHoan = idTaiKHoan;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getsDT() {
        return sDT;
    }

    public void setsDT(String sDT) {
        this.sDT = sDT;
    }

    public Date getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public int getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(int gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public Set<LichMuonPhong> getLichMuonPhongs() {
        return lichMuonPhongs;
    }

    public void setLichMuonPhongs(Set<LichMuonPhong> lichMuonPhongs) {
        this.lichMuonPhongs = lichMuonPhongs;
    }

    public Set<MuonPhongHoc> getMuonPhongHocs() {
        return muonPhongHocs;
    }

    public void setMuonPhongHocs(Set<MuonPhongHoc> muonPhongHocs) {
        this.muonPhongHocs = muonPhongHocs;
    }

}