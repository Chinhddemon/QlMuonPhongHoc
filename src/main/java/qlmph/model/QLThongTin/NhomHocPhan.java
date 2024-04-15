package qlmph.model.QLThongTin;

import javax.persistence.*;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.model.QLTaiKhoan.QuanLy;

import java.util.Date;
import java.util.List;

import qlmph.utils.Converter;

@Entity
@Table(name = "NhomHocPhan")
public class NhomHocPhan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IdNHP")
    private int idNHP;

    @ManyToOne
    @JoinColumn(name = "MaMH", referencedColumnName = "MaMH")
    private MonHoc monHoc;

    @ManyToOne
    @JoinColumn(name = "MaLopSV", referencedColumnName = "MaLopSV")
    private LopSV lopSV;

    @ManyToOne
    @JoinColumn(name = "MaQLKhoiTao", referencedColumnName = "MaQL")
    private QuanLy quanLyKhoiTao;

    @Column(name = "Nhom")
    private short nhom;

    @Column(name = "_CreateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _CreateAt = new Date();

    @Column(name = "_UpdateAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _UpdateAt = new Date();

    @Column(name = "_DeleteAt")
    @Temporal(TemporalType.TIMESTAMP)
    private Date _DeleteAt;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "DsNgMPH_NhomHocPhan", joinColumns = @JoinColumn(name = "IdNHP", referencedColumnName = "IdNHP"), inverseJoinColumns = @JoinColumn(name = "MaNgMPH", referencedColumnName = "MaNgMPH"))
    List<NguoiMuonPhong> nguoiMuonPhongs;

    @OneToMany(mappedBy = "nhomHocPhan", fetch = FetchType.EAGER)
    List<LopHocPhanSection> lopHocPhanSections;

    public NhomHocPhan() {
    }

    public NhomHocPhan(NhomHocPhan nhomHocPhan) {
        this.idNHP = nhomHocPhan.idNHP;
        this.monHoc = nhomHocPhan.monHoc;
        this.lopSV = nhomHocPhan.lopSV;
        this.quanLyKhoiTao = nhomHocPhan.quanLyKhoiTao;
        this.nhom = nhomHocPhan.nhom;
        this._CreateAt = nhomHocPhan._CreateAt;
        this._UpdateAt = nhomHocPhan._UpdateAt;
        this._DeleteAt = nhomHocPhan._DeleteAt;
        this.nguoiMuonPhongs = nhomHocPhan.nguoiMuonPhongs;
        this.lopHocPhanSections = nhomHocPhan.lopHocPhanSections;
    }

    public NhomHocPhan(MonHoc monHoc, LopSV lopSV, QuanLy quanLyKhoiTao, byte nhom,
            List<NguoiMuonPhong> nguoiMuonPhongs,
            List<LopHocPhanSection> lopHocPhanSections) {
        this.monHoc = monHoc;
        this.lopSV = lopSV;
        this.quanLyKhoiTao = quanLyKhoiTao;
        this.nhom = nhom;
        this.nguoiMuonPhongs = nguoiMuonPhongs;
        this.lopHocPhanSections = lopHocPhanSections;
    }

    public String getIdNHP() {
        return Converter.intToStringNchar(idNHP, 6);
    }

    public void setIdNHP(int idNHP) {
        this.idNHP = idNHP;
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

    public QuanLy getQuanLyKhoiTao() {
        return quanLyKhoiTao;
    }

    public void setQuanLyKhoiTao(QuanLy quanLyKhoiTao) {
        this.quanLyKhoiTao = quanLyKhoiTao;
    }

    public short getNhom() {
        return nhom;
    }

    public String getNhomAsString() {
        return Converter.shortToString2char(nhom);
    }

    public void setNhom(short nhom) {
        this.nhom = nhom;
    }

    public Date get_CreateAt() {
        return _CreateAt;
    }

    public void set_CreateAt(Date _CreateAt) {
        this._CreateAt = _CreateAt;
    }

    public Date get_UpdateAt() {
        return _UpdateAt;
    }

    public void set_UpdateAt(Date _UpdateAt) {
        this._UpdateAt = _UpdateAt;
    }

    public Date get_DeleteAt() {
        return _DeleteAt;
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