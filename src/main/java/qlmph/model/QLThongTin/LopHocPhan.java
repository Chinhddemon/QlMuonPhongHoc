package qlmph.model.QLThongTin;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;

import java.util.Date;
import java.util.List;

import qlmph.utils.Converter;

@Entity
@Table(name = "LopHocPhan")
public class LopHocPhan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdLHP")
    private int idLHP;

    @ManyToOne
    @JoinColumn(name = "MaMH", referencedColumnName = "MaMH")
    private MonHoc monHoc;

    @ManyToOne
    @JoinColumn(name = "MaLopSV", referencedColumnName = "MaLopSV")
    private LopSV lopSV;

    @Column(name = "Nhom")
    private byte nhom;

    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt;

    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _UpdateAt;

    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "DsNgMPH_LopHocPhan",
        joinColumns = @JoinColumn(name = "IdLHP", referencedColumnName = "IdLHP"), 
        inverseJoinColumns = @JoinColumn(name = "MaNgMPH", referencedColumnName = "MaNgMPH"))
    List<NguoiMuonPhong> nguoiMuonPhongs;

    @OneToMany(mappedBy = "lopHocPhan", fetch = FetchType.EAGER)
    List<LopHocPhanSection> lopHocPhanSections;

    public LopHocPhan() {
    }

    public LopHocPhan(MonHoc monHoc, LopSV lopSV, byte nhom, List<NguoiMuonPhong> nguoiMuonPhongs,
            List<LopHocPhanSection> lopHocPhanSections) {
        this.monHoc = monHoc;
        this.lopSV = lopSV;
        this.nhom = nhom;
        this.nguoiMuonPhongs = nguoiMuonPhongs;
        this.lopHocPhanSections = lopHocPhanSections;
    }

    public String getIdLHP() {
        return Converter.intToStringNchar(idLHP, 8);
    }

    public void setIdLHP(int idLHP) {
        this.idLHP = idLHP;
    }

    public MonHoc getMonHoc() {
        return monHoc;
    }

    public void setMonHoc(MonHoc monHoc) {
        this.monHoc = monHoc;
    }

    public LopSV getLopSV() {
        return lopSV;
    }

    public void setLopSV(LopSV lopSV) {
        this.lopSV = lopSV;
    }

    public String getNhom() {
        return Converter.byteToString2char(nhom);
    }

    public void setNhom(byte nhom) {
        this.nhom = nhom;
    }

    public String get_CreateAt() {
        return Converter.DateTimeToString(_CreateAt);
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public String get_UpdateAt() {
        return Converter.DateTimeToString(_UpdateAt);
    }

    public void set_UpdateAt(Date _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public String get_DeleteAt() {
        return Converter.DateTimeToString(_DeleteAt);
    }

    public void set_DeleteAt(Date _DeleteAt) {
        this._DeleteAt = _DeleteAt;
    }

    public List<NguoiMuonPhong> getNguoiMuonPhongs() {
        return nguoiMuonPhongs;
    }

    public void setNguoiMuonPhongs(List<NguoiMuonPhong> nguoiMuonPhongs) {
        this.nguoiMuonPhongs = nguoiMuonPhongs;
    }

    public List<LopHocPhanSection> getLopHocPhanSections() {
        return lopHocPhanSections;
    }

    public void setLopHocPhanSections(List<LopHocPhanSection> lopHocPhanSections) {
        this.lopHocPhanSections = lopHocPhanSections;
    }
}