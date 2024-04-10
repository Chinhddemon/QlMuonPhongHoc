package qlmph.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.repository.QLTaiKhoan.GiangVienRepository;
import qlmph.model.QLTaiKhoan.GiangVien;

@Service
public class GiangVienService {

	@Autowired
	GiangVienRepository giangVienRepository;

	public List<GiangVien> getAll() {
		return giangVienRepository.getAll();
	}

	public GiangVien getByMaGV(String MaGV) {
		return giangVienRepository.getByMaGV(MaGV);
	}
}