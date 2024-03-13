package cnpm.model.QLTaiKhoan;

import java.util.UUID;

public class VaiTro {
    private UUID IdVaiTro;
    private String Vaitro;

    public VaiTro() {
    }
    public VaiTro(UUID idVaiTro, String vaitro) {
        IdVaiTro = idVaiTro;
        Vaitro = vaitro;
    }
    public UUID getIdVaiTro() {
        return IdVaiTro;
    }
    public void setIdVaiTro(UUID idVaiTro) {
        IdVaiTro = idVaiTro;
    }
    public String getVaitro() {
        return Vaitro;
    }
    public void setVaitro(String vaitro) {
        Vaitro = vaitro;
    }
}
