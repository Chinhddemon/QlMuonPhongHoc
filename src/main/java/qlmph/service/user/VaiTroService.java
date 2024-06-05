package qlmph.service.user;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.user.VaiTro;
import qlmph.repository.user.VaiTroRepository;

@Service
public class VaiTroService {

  @Autowired
  private VaiTroRepository vaiTroRepository;

  public VaiTro layThongTinBangMaVaiTro(String maVaiTro) {
    VaiTro vaiTro = vaiTroRepository.getByMaVaiTro(maVaiTro);
    if (vaiTro == null) {
      new Exception("Không tìm thấy thông tin vai trò, maVaiTro: " + maVaiTro).printStackTrace();
      return null;
    }
    return vaiTro;
  }

}
