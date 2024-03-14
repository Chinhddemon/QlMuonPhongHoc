package QlMuonPhongHoc.model.QLTaiKhoan;

public class LopSV {
    private String MaLopSV;
    private String LopSV;
    
    public LopSV() {
    }
    public LopSV(String maLopSV, String lopSV) {
        MaLopSV = maLopSV;
        LopSV = lopSV;
    }
    public String getMaLopSV() {
        return MaLopSV;
    }
    public void setMaLopSV(String maLopSV) {
        MaLopSV = maLopSV;
    }
    public String getLopSV() {
        return LopSV;
    }
    public void setLopSV(String lopSV) {
        LopSV = lopSV;
    }
}
