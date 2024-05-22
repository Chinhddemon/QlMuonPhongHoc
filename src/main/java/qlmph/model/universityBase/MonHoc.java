package qlmph.model.universityBase;

import javax.persistence.*;

import qlmph.model.universityCourse.NhomHocPhan;

import java.util.Date;
import java.util.List;

@Entity
public class MonHoc {
  @Id
  private String maMonHoc;

  private String tenMonHoc;

  // private int soTinChi;

  private char _Status;

  @Temporal(TemporalType.TIMESTAMP)
  private Date _ActiveAt;

  @OneToMany(mappedBy = "monHoc")
  private List<NhomHocPhan> nhomHocPhans;

  public MonHoc() {
  }

  public String getMaMonHoc() {
    return maMonHoc;
  }

  public void setMaMonHoc(String maMonHoc) {
    this.maMonHoc = maMonHoc;
  }

  public String getTenMonHoc() {
    return tenMonHoc;
  }

  public void setTenMonHoc(String tenMonHoc) {
    this.tenMonHoc = tenMonHoc;
  }

  // public int getSoTinChi() {
  //   return soTinChi;
  // }

  // public void setSoTinChi(int soTinChi) {
  //   this.soTinChi = soTinChi;
  // }

  public char get_Status() {
    return _Status;
  }

  public void set_Status(char _Status) {
    this._Status = _Status;
  }

  public Date get_ActiveAt() {
    return _ActiveAt;
  }

  public void set_ActiveAt(Date _ActiveAt) {
    this._ActiveAt = _ActiveAt;
  }

  public List<NhomHocPhan> getNhomHocPhans() {
    return nhomHocPhans;
  }

  public void setNhomHocPhans(List<NhomHocPhan> nhomHocPhans) {
    this.nhomHocPhans = nhomHocPhans;
  }
}
