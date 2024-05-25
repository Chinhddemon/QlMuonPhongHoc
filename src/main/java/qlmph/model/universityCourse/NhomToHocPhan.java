package qlmph.model.universityCourse;

import java.util.Date;

import javax.persistence.*;

import qlmph.model.user.GiangVien;
import qlmph.utils.Converter;

@Entity
@Table(name = "NhomToHocPhan")
public class NhomToHocPhan {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "idNhomToHocPhan")
  private int idNhomToHocPhan;

  @ManyToOne
  @JoinColumn(name = "idNhomHocPhan", referencedColumnName = "idNhomHocPhan")
  private NhomHocPhan nhomHocPhan;

  @ManyToOne
  @JoinColumn(name = "maGiangVienGiangDay", referencedColumnName = "maGiangVien")
  private GiangVien giangVienGiangDay;

  private short nhomTo;

  @Temporal(TemporalType.DATE)
  private Date startDate;

  @Temporal(TemporalType.DATE)
  private Date endDate;

  private String mucDich;

  @Temporal(TemporalType.TIMESTAMP)
  private Date _CreateAt = new Date();

  @Temporal(TemporalType.TIMESTAMP)
  private Date _LastUpdateAt = new Date();

  @Temporal(TemporalType.TIMESTAMP)
  private Date _DeleteAt;

  public NhomToHocPhan() {
  }

  public int getIdNhomToHocPhan() {
    return idNhomToHocPhan;
  }

  public String getIdNhomToHocPhanAsString() {
    return Converter.intToStringNchar(idNhomToHocPhan, 8);
  }

  public void setIdNhomToHocPhan(int idNhomToHocPhan) {
    this.idNhomToHocPhan = idNhomToHocPhan;
  }

  public NhomHocPhan getNhomHocPhan() {
    return nhomHocPhan;
  }

  public void setNhomHocPhan(NhomHocPhan nhomHocPhan) {
    this.nhomHocPhan = nhomHocPhan;
  }

  public GiangVien getGiangVienGiangDay() {
    return giangVienGiangDay;
  }

  public void setGiangVienGiangDay(GiangVien giangVienGiangDay) {
    this.giangVienGiangDay = giangVienGiangDay;
  }

  public short getNhomTo() {
    return nhomTo;
  }

  public String getNhomToAsString() {
    return Converter.shortToString2char(nhomTo);
  }

  public void setNhomTo(short nhomTo) {
    this.nhomTo = nhomTo;
  }

  public Date getStartDate() {
    return startDate;
  }

  public void setStartDate(Date startDate) {
    this.startDate = startDate;
  }

  public Date getEndDate() {
    return endDate;
  }

  public void setEndDate(Date endDate) {
    this.endDate = endDate;
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
  
}
