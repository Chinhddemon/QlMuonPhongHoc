package qlmph.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLTaiKhoan.QuanLy;
import qlmph.repository.QLTaiKhoan.QuanLyRepository;
import qlmph.utils.UUIDEncoderDecoder;

@Service
public class QuanLyService {
    
    @Autowired
    QuanLyRepository quanLyRepository;

    public QuanLy layThongTin(String MaQL) {
        return quanLyRepository.getByMaQL(MaQL);
    }

    public QuanLy layThongTinTaiKhoan(String idTaiKhoan) {
        UUID IdTaiKhoan = UUID.fromString(UUIDEncoderDecoder.convertUuidString(idTaiKhoan));
        return quanLyRepository.getByIdTaiKhoan(IdTaiKhoan);
    }
    
}
