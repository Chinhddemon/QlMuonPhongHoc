package qlmph.models.QLThongTin;

import java.sql.Timestamp;
import java.util.UUID;

public class MuonPhongHoc {
    private int idMPH;
    private UUID idTaiKhoan;
    private UUID idQLDuyet;
    private Timestamp thoiGian_MPH;
    private Timestamp thoiGian_TPH;
    private String yeuCau;

    public MuonPhongHoc() {
    }

    public MuonPhongHoc(int idMPH, UUID idTaiKhoan, UUID idQLDuyet, Timestamp thoiGian_MPH, Timestamp thoiGian_TPH,
            String yeuCau) {
        this.idMPH = idMPH;
        this.idTaiKhoan = idTaiKhoan;
        this.idQLDuyet = idQLDuyet;
        this.thoiGian_MPH = thoiGian_MPH;
        this.thoiGian_TPH = thoiGian_TPH;
        this.yeuCau = yeuCau;
    }

    public int getIdMPH() {
        return idMPH;
    }

    public void setIdMPH(int idMPH) {
        this.idMPH = idMPH;
    }

    public UUID getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(UUID idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public UUID getIdQLDuyet() {
        return idQLDuyet;
    }

    public void setIdQLDuyet(UUID idQLDuyet) {
        this.idQLDuyet = idQLDuyet;
    }

    public Timestamp getThoiGian_MPH() {
        return thoiGian_MPH;
    }

    public void setThoiGian_MPH(Timestamp thoiGian_MPH) {
        this.thoiGian_MPH = thoiGian_MPH;
    }

    public Timestamp getThoiGian_TPH() {
        return thoiGian_TPH;
    }

    public void setThoiGian_TPH(Timestamp thoiGian_TPH) {
        this.thoiGian_TPH = thoiGian_TPH;
    }

    public String getYeuCau() {
        return yeuCau;
    }

    public void setYeuCau(String yeuCau) {
        this.yeuCau = yeuCau;
    }

}
