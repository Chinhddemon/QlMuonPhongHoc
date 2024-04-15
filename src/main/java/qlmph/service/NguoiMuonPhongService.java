package qlmph.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.NguoiMuonPhong;
import qlmph.repository.QLTaiKhoan.NguoiMuonPhongRepository;
import qlmph.utils.UUIDEncoderDecoder;

@Service
public class NguoiMuonPhongService {

	@Autowired
	NguoiMuonPhongRepository nguoiMuonPhongRepository;

	public NguoiMuonPhong layThongTin(String MaNgMPH) {
		return nguoiMuonPhongRepository.getByMaNgMPH(MaNgMPH);
	}

	public NguoiMuonPhong layThongTinTaiKhoan(String idTaiKhoan) {
		UUID IdTaiKhoan = UUID.fromString(UUIDEncoderDecoder.convertUuidString(idTaiKhoan));
		return nguoiMuonPhongRepository.getByIdTaiKhoan(IdTaiKhoan);
	}

}
