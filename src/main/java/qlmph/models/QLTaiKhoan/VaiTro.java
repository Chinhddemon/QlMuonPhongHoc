package qlmph.models.QLTaiKhoan;

public class VaiTro {
    private short idVaiTro;
    private String vaitro;

    public VaiTro() {
    }

    public VaiTro(short idVaiTro, String vaitro) {
        this.idVaiTro = idVaiTro;
        this.vaitro = vaitro;
    }

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getVaitro() {
        return vaitro;
    }

    public void setVaitro(String vaitro) {
        this.vaitro = vaitro;
    }
}
