package qlmph.service.user;

import java.util.ArrayList;
import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.VaiTro;
// import qlmph.repository.user.VaiTroRepository;

@Service
public class VaiTroService {

  // @Autowired
  // private VaiTroRepository vaiTroRepository;

  public List<String> layDanhSachMaVaiTro(List<VaiTro> vaiTros) {
    List<String> maVaiTros = new ArrayList<>();
    for (VaiTro vaiTro : vaiTros) {
      maVaiTros.add(vaiTro.getMaVaiTro());
    }
    return maVaiTros;
  }

  public boolean vaiTroLaKhachHang(List<VaiTro> vaiTros) {
    List<String> maVaiTros = layDanhSachMaVaiTro(vaiTros);
    if (maVaiTros.contains("U")
        && maVaiTros.contains("S") && maVaiTros.contains("L")) {
      return true;
    }
    return false;
  }

  public boolean vaiTroLaQuanLy(List<VaiTro> vaiTros) {
    List<String> maVaiTros = layDanhSachMaVaiTro(vaiTros);
    if (maVaiTros.contains("U")
        && maVaiTros.contains("MB") || maVaiTros.contains("MM") || maVaiTros.contains("MDB")) {
      return true;
    }
    return false;
  }

  public boolean vaiTroLaQuanTriVien(List<VaiTro> vaiTros) {
    List<String> maVaiTros = layDanhSachMaVaiTro(vaiTros);
    if (maVaiTros.contains("U") && maVaiTros.contains("A")) {
      return true;
    }
    return false;
  }
}
