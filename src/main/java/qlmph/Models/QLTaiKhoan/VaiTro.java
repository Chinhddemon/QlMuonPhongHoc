package qlmph.models.QLTaiKhoan;

import java.util.UUID;

public class VaiTro {
    private UUID idVaiTro;
    private String vaitro;

    public VaiTro() {
    }

    public VaiTro(UUID idVaiTro, String vaitro) {
        this.idVaiTro = idVaiTro;
        this.vaitro = vaitro;
    }

    public UUID getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(UUID idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getVaitro() {
        return vaitro;
    }

    public void setVaitro(String vaitro) {
        this.vaitro = vaitro;
    }

}
