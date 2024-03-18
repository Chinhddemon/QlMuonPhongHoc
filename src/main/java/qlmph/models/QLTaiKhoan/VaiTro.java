package qlmph.models.QLTaiKhoan;

public class VaiTro {
    private String idVaiTro;
    private String vaitro;

    public VaiTro() {
    }

    public VaiTro(String idVaiTro, String vaitro) {
        this.idVaiTro = idVaiTro;
        this.vaitro = vaitro;
    }

    public String getIdVaiTro() {
        return idVaiTro;
    }

    public void setIdVaiTro(String idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public String getVaitro() {
        return vaitro;
    }

    public void setVaitro(String vaitro) {
        this.vaitro = vaitro;
    }

}
