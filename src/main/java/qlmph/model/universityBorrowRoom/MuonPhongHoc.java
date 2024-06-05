package qlmph.model.universityBorrowRoom;

import javax.persistence.*;

import qlmph.model.user.NguoiDung;
import qlmph.model.user.QuanLy;
import qlmph.model.user.VaiTro;
import qlmph.utils.Converter;

import java.util.Date;

@Entity
@Table
public class MuonPhongHoc {
  @Id
  private int idLichMuonPhong;

  @OneToOne
  @JoinColumn(name = "idLichMuonPhong", referencedColumnName = "idLichMuonPhong")
  private LichMuonPhong lichMuonPhong;

  @ManyToOne
  @JoinColumn(name = "idNguoiMuonPhong", referencedColumnName = "idNguoiDung")
  private NguoiDung nguoiMuonPhong;

  @ManyToOne
  @JoinColumn(name = "maQuanLyDuyet", referencedColumnName = "maQuanLy")
  private QuanLy quanLyDuyet;

  @ManyToOne
  @JoinColumn(name = "idVaiTro_NguoiMuonPhong", referencedColumnName = "idVaiTro")
  private VaiTro vaiTro_NguoiMuonPhong;

  private String yeuCau;

  // Thời gian mượn phòng
  @Temporal(TemporalType.TIMESTAMP)
  private Date _TransferAt = new Date();

  // Thời gian trả phòng
  @Temporal(TemporalType.TIMESTAMP)
  private Date _ReturnAt;

  public MuonPhongHoc() {
  }

  public MuonPhongHoc(NguoiDung nguoiMuonPhong, QuanLy quanLyDuyet, VaiTro vaiTro_NguoiMuonPhong, String yeuCau) {
    this.nguoiMuonPhong = nguoiMuonPhong;
    this.quanLyDuyet = quanLyDuyet;
    this.vaiTro_NguoiMuonPhong = vaiTro_NguoiMuonPhong;
    this.yeuCau = yeuCau;
  }

  public MuonPhongHoc(int idLichMuonPhong, NguoiDung nguoiMuonPhong, QuanLy quanLyDuyet, VaiTro vaiTro_NguoiMuonPhong,
      String yeuCau) {
    this.idLichMuonPhong = idLichMuonPhong;
    this.nguoiMuonPhong = nguoiMuonPhong;
    this.quanLyDuyet = quanLyDuyet;
    this.vaiTro_NguoiMuonPhong = vaiTro_NguoiMuonPhong;
    this.yeuCau = yeuCau;
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

  public LichMuonPhong getLichMuonPhong() {
    return lichMuonPhong;
  }

  public void setLichMuonPhong(LichMuonPhong lichMuonPhong) {
    this.lichMuonPhong = lichMuonPhong;
  }

  public NguoiDung getNguoiMuonPhong() {
    return nguoiMuonPhong;
  }

  public void setNguoiMuonPhong(NguoiDung nguoiMuonPhong) {
    this.nguoiMuonPhong = nguoiMuonPhong;
  }

  public QuanLy getQuanLyDuyet() {
    return quanLyDuyet;
  }

  public void setQuanLyDuyet(QuanLy quanLyDuyet) {
    this.quanLyDuyet = quanLyDuyet;
  }

  public VaiTro getVaiTro_NguoiMuonPhong() {
    return vaiTro_NguoiMuonPhong;
  }

  public void setVaiTro_NguoiMuonPhong(VaiTro vaiTro_NguoiMuonPhong) {
    this.vaiTro_NguoiMuonPhong = vaiTro_NguoiMuonPhong;
  }

  public String getYeuCau() {
    return yeuCau;
  }

  public void setYeuCau(String yeuCau) {
    this.yeuCau = yeuCau;
  }

  public Date get_TransferAt() {
    return _TransferAt;
  }

  public void set_TransferAt(Date _TransferAt) {
    this._TransferAt = _TransferAt;
  }

  public Date get_ReturnAt() {
    return _ReturnAt;
  }

  public void set_ReturnAt(Date _ReturnAt) {
    this._ReturnAt = _ReturnAt;
  }
}
