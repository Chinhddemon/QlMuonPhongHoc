package qlmph.model.QLTaiKhoan;

import javax.persistence.*;

@Entity
public class DoiTuongNgMPH {
    @Id
    @Column(name = "IdDoiTuongNgMPH")
    private short idDoiTuongNgMPH;

    @Column(name = "TenDoiTuongNgMPH")
    private String tenDoiTuongNgMPH;

    @Override
    public String toString() {
        return "DoiTuongNgMPH [idDoiTuongNgMPH=" + idDoiTuongNgMPH + ", tenDoiTuongNgMPH=" + tenDoiTuongNgMPH + "]";
    }

    public DoiTuongNgMPH() {
    }

    public DoiTuongNgMPH(short idDoiTuongNgMPH, String tenDoiTuongNgMPH) {
        this.idDoiTuongNgMPH = idDoiTuongNgMPH;
        this.tenDoiTuongNgMPH = tenDoiTuongNgMPH;
    }

    public short getIdDoiTuongNgMPH() {
        return idDoiTuongNgMPH;
    }

    public void setIdDoiTuongNgMPH(short idDoiTuongNgMPH) {
        this.idDoiTuongNgMPH = idDoiTuongNgMPH;
    }

    public String getTenDoiTuongNgMPH() {
        return tenDoiTuongNgMPH;
    }

    public void setTenDoiTuongNgMPH(String tenDoiTuongNgMPH) {
        this.tenDoiTuongNgMPH = tenDoiTuongNgMPH;
    }

}
