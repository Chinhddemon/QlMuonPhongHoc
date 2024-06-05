package qlmph.model.universityBorrowRoom;

import javax.persistence.*;

import qlmph.model.universityBase.PhongHoc;
import qlmph.model.universityCourse.NhomToHocPhan;
import qlmph.model.user.QuanLy;
import qlmph.utils.Converter;

import java.util.Date;

@Entity
public class LichMuonPhong {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private int idLichMuonPhong;

  @ManyToOne
  @JoinColumn(name = "idNhomToHocPhan", referencedColumnName = "idNhomToHocPhan")
  private NhomToHocPhan nhomToHocPhan;

  @ManyToOne
  @JoinColumn(name = "idPhongHoc", referencedColumnName = "idPhongHoc")
  private PhongHoc phongHoc;
  
  @ManyToOne
  @JoinColumn(name = "maQuanLyKhoiTao", referencedColumnName = "maQuanLy")
  private QuanLy quanLyKhoiTao;

  @Temporal(TemporalType.TIMESTAMP)
  private Date startDatetime;

  @Temporal(TemporalType.TIMESTAMP)
  private Date endDatetime;

  private String mucDich;

  @Temporal(TemporalType.TIMESTAMP)
  private Date _CreateAt = new Date();

  @Temporal(TemporalType.TIMESTAMP)
  private Date _LastUpdateAt = new Date();

  @Temporal(TemporalType.TIMESTAMP)
  private Date _DeleteAt;

  @OneToOne
  @JoinColumn(name = "idLichMuonPhong")
  private MuonPhongHoc muonPhongHoc;

  public LichMuonPhong() {
  }

  public LichMuonPhong(NhomToHocPhan nhomToHocPhan, PhongHoc phongHoc, QuanLy quanLyKhoiTao, Date startDatetime,
      Date endDatetime, String mucDich) {
    this.nhomToHocPhan = nhomToHocPhan;
    this.phongHoc = phongHoc;
    this.quanLyKhoiTao = quanLyKhoiTao;
    this.startDatetime = startDatetime;
    this.endDatetime = endDatetime;
    this.mucDich = mucDich;
  }
  
  public int getIdLichMuonPhong() {
    return idLichMuonPhong;
  }

  public String getIdLichMuonPhongAsString() {
    return Converter.intToStringNchar(idLichMuonPhong, 8);
  }

  public void setIdLichMuonPhong(int idLichMuonPhong) {
    this.idLichMuonPhong = idLichMuonPhong;
  }

  public NhomToHocPhan getNhomToHocPhan() {
    return nhomToHocPhan;
  }

  public void setNhomToHocPhan(NhomToHocPhan nhomToHocPhan) {
    this.nhomToHocPhan = nhomToHocPhan;
  }

  public PhongHoc getPhongHoc() {
    return phongHoc;
  }

  public void setPhongHoc(PhongHoc phongHoc) {
    this.phongHoc = phongHoc;
  }

  public QuanLy getQuanLyKhoiTao() {
    return quanLyKhoiTao;
  }

  public void setQuanLyKhoiTao(QuanLy quanLyKhoiTao) {
    this.quanLyKhoiTao = quanLyKhoiTao;
  }

  public Date getStartDatetime() {
    return startDatetime;
  }

  public void setStartDatetime(Date startDatetime) {
    this.startDatetime = startDatetime;
  }

  public Date getEndDatetime() {
    return endDatetime;
  }

  public void setEndDatetime(Date endDatetime) {
    this.endDatetime = endDatetime;
  }

  public String getMucDich() {
    return mucDich;
  }

  public void setMucDich(String mucDich) {
    this.mucDich = mucDich;
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

  public MuonPhongHoc getMuonPhongHoc() {
    return muonPhongHoc;
  }

  public void setMuonPhongHoc(MuonPhongHoc muonPhongHoc) {
    this.muonPhongHoc = muonPhongHoc;
  }
}
