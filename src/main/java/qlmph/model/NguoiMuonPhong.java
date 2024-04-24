package qlmph.model;

import javax.persistence.*;

import org.hibernate.annotations.Type;

import java.util.Date;
import java.util.Set;
import java.util.UUID;

@SuppressWarnings("deprecation")
@Entity
@Table(name = "NguoiMuonPhong")
public class NguoiMuonPhong {
    @Id
    @Column(name = "MaNgMPH")
    private String maNgMPH;

    @Column(name = "IdTaiKhoan")
    @Type(type = "uuid-char")
    private UUID idTaiKHoan;

    @ManyToOne
    @JoinColumn(name = "IdDoiTuongNgMPH", referencedColumnName = "IdDoiTuongNgMPH")
    private DoiTuongNgMPH doiTuongNgMPH;

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

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "DsMPH_LopHoc", joinColumns = @JoinColumn(name = "MaNgMPH"), inverseJoinColumns = @JoinColumn(name = "IdLHP"))
    private Set<NhomHocPhan> nhomHocPhans;

    @Override
    public String toString() {
        return "NguoiMuonPhong [maNgMPH=" + maNgMPH + ", idTaiKHoan=" + idTaiKHoan + ", doiTuongNgMPH=" + doiTuongNgMPH
                + ", hoTen=" + hoTen + ", email=" + email + ", sDT=" + sDT + ", ngaySinh=" + ngaySinh + ", gioiTinh="
                + gioiTinh + ", diaChi=" + diaChi + "]";
    }

    public NguoiMuonPhong() {
    }

    public NguoiMuonPhong(String maNgMPH, UUID idTaiKHoan, DoiTuongNgMPH doiTuongNgMPH, String hoTen, String email,
            String sDT, Date ngaySinh, int gioiTinh, String diaChi) {
        this.maNgMPH = maNgMPH;
        this.idTaiKHoan = idTaiKHoan;
        this.doiTuongNgMPH = doiTuongNgMPH;
        this.hoTen = hoTen;
        this.email = email;
        this.sDT = sDT;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.diaChi = diaChi;
    }

    public String getMaNgMPH() {
        return maNgMPH;
    }

    public void setMaNgMPH(String maNgMPH) {
        this.maNgMPH = maNgMPH;
    }

    public UUID getIdTaiKHoan() {
        return idTaiKHoan;
    }

    public void setIdTaiKHoan(UUID idTaiKHoan) {
        this.idTaiKHoan = idTaiKHoan;
    }

    public DoiTuongNgMPH getDoiTuongNgMPH() {
        return doiTuongNgMPH;
    }

    public void setDoiTuongNgMPH(DoiTuongNgMPH doiTuongNgMPH) {
        this.doiTuongNgMPH = doiTuongNgMPH;
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

    public Set<NhomHocPhan> getNhomHocPhans() {
        return nhomHocPhans;
    }

    public void setNhomHocPhans(Set<NhomHocPhan> nhomHocPhans) {
        this.nhomHocPhans = nhomHocPhans;
    }
}