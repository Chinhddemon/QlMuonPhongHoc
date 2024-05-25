package qlmph.model.universityCourse;

import javax.persistence.*;

import qlmph.model.universityBase.MonHoc;
import qlmph.model.user.NguoiDung;
import qlmph.model.user.QuanLy;
import qlmph.utils.Converter;

import java.util.Date;
import java.util.List;

@Entity
public class NhomHocPhan {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int idNhomHocPhan;

  @ManyToOne
  @JoinColumn(name = "maMonHoc")
  private MonHoc monHoc;

  @ManyToOne
  @JoinColumn(name = "idHocKy_LopSinhVien", referencedColumnName = "idHocKy_LopSinhVien")
  private HocKy_LopSinhVien hocKy_LopSinhVien;

  @ManyToOne
  @JoinColumn(name = "maQuanLyKhoiTao", referencedColumnName = "maQuanLy")
  private QuanLy quanLyKhoiTao;

  private short nhom;

  @Temporal(TemporalType.TIMESTAMP)
  private Date _CreateAt = new Date();

  @Temporal(TemporalType.TIMESTAMP)
  private Date _LastUpdateAt = new Date();

  @Temporal(TemporalType.TIMESTAMP)
  private Date _DeleteAt;

  @OneToMany(mappedBy = "nhomHocPhan", fetch = FetchType.EAGER)
  private List<NhomToHocPhan> nhomToHocPhans;

  @ManyToMany
  @JoinTable(
    name = "DsNguoiMuonPhong_NhomHocPhan",
    joinColumns = @JoinColumn(name = "idNhomHocPhan"),
    inverseJoinColumns = @JoinColumn(name = "idNguoiMuonPhong")
  )
  private List<NguoiDung> nguoiMuonPhongs;

  public NhomHocPhan() {
  }

  public NhomHocPhan(MonHoc monHoc, HocKy_LopSinhVien hocKy_LopSinhVien, QuanLy quanLyKhoiTao, short nhom,
      List<NhomToHocPhan> nhomToHocPhans, List<NguoiDung> nguoiMuonPhongs) {
    this.monHoc = monHoc;
    this.hocKy_LopSinhVien = hocKy_LopSinhVien;
    this.quanLyKhoiTao = quanLyKhoiTao;
    this.nhom = nhom;
    this.nhomToHocPhans = nhomToHocPhans;
    this.nguoiMuonPhongs = nguoiMuonPhongs;
  }

  public int getIdNhomHocPhan() {
    return idNhomHocPhan;
  }

  public String getIdNhomHocPhanAsString() {
    return Converter.intToStringNchar(idNhomHocPhan, 6);
  }

  public void setIdNhomHocPhan(int idNhomHocPhan) {
    this.idNhomHocPhan = idNhomHocPhan;
  }

  public MonHoc getMonHoc() {
    return monHoc;
  }

  public void setMonHoc(MonHoc monHoc) {
    this.monHoc = monHoc;
  }

  public HocKy_LopSinhVien getHocKy_LopSinhVien() {
    return hocKy_LopSinhVien;
  }

  public void setHocKy_LopSinhVien(HocKy_LopSinhVien hocKy_LopSinhVien) {
    this.hocKy_LopSinhVien = hocKy_LopSinhVien;
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

  public Date get_LastUpdateAt() {
    return _LastUpdateAt;
  }

  public void set_LastUpdateAt(Date _LastUpdateAt) {
    this._LastUpdateAt = _LastUpdateAt;
  }

  public Date get_DeleteAt() {
    return _DeleteAt;
  }

  public void set_DeleteAt(Date _DeleteAt) {
    this._DeleteAt = _DeleteAt;
  }

  public List<NhomToHocPhan> getNhomToHocPhans() {
    return nhomToHocPhans;
  }

  public void setNhomToHocPhans(List<NhomToHocPhan> nhomToHocPhans) {
    this.nhomToHocPhans = nhomToHocPhans;
  }

  public List<NguoiDung> getNguoiMuonPhongs() {
    return nguoiMuonPhongs;
  }

  public void setNguoiMuonPhongs(List<NguoiDung> nguoiMuonPhongs) {
    this.nguoiMuonPhongs = nguoiMuonPhongs;
  }
}
