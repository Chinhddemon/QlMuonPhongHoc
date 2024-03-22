package qlmph.models.QLTaiKhoan;

public class VaiTro {
    private short idVaiTro;
    private String tenVaitro;

    public VaiTro() {
    }

    public VaiTro(short idVaiTro, String tenVaitro) {
        this.idVaiTro = idVaiTro;
        this.tenVaitro = tenVaitro;
    }

    public short getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(short idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getTenVaitro() {
        return tenVaitro;
    }

    public void setTenVaitro(String tenVaitro) {
        this.tenVaitro = tenVaitro;
    }
}
