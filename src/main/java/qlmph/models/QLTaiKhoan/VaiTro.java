package qlmph.models.QLTaiKhoan;

public class VaiTro {
    private int idVaiTro;
    private String vaitro;

    public VaiTro() {
    }

    public VaiTro(int idVaiTro, String vaitro) {
        this.idVaiTro = idVaiTro;
        this.vaitro = vaitro;
    }

    public int getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(int idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getVaitro() {
        return vaitro;
    }

    public void setVaitro(String vaitro) {
        this.vaitro = vaitro;
    }
}
