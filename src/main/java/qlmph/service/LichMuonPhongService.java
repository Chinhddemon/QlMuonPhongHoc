package qlmph.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import qlmph.model.QLThongTin.LichMuonPhong;
import qlmph.repository.QLThongTin.LichMuonPhongRepository;

@Service
public class LichMuonPhongService {

	@Autowired
	LichMuonPhongRepository lichMuonPhongRepository;

	public List<LichMuonPhong> layDanhSach() {
		return lichMuonPhongRepository.getAll();
	}

	public List<LichMuonPhong> layDanhSachTheoDieuKien(List<GetCommand> Commands,
			Date ThoiGian_BD, Date ThoiGian_KT,
			int IdLHP,
			String MaGVGiangDay,
			String MaNgMPH) {

		// Các lệnh sắp xếp được sử dụng trên view:
		// Cho người mượn phòng:
		// Theo giảng viên giảng dạy - trang 1
		// Theo môn học - trang 1
		// Theo lớp giảng dạy - trang 1
		// Theo phòng học - trang 1
		// Theo thời gian lịch mượn phòng - trang 1
		// Cho quản lý:
		// Theo mục đích mượn phòng - trang 1
		// Theo trạng thái mượn phòng - trang 1
		// Theo thời gian mượn phòng - trang 2
		// Theo quản lý duyệt cho mượn phòng - trang 2
		// Theo người mượn phòng - trang 2
		// Theo quản lý tạo lịch mượn phòng - trang 2

		// Các lệnh điều kiện được sử dụng trong truy vấn:
		if (Commands.contains(GetCommand.TheoThoiGian_LichMuonPhong)) {
			if (ThoiGian_BD == null)
				return null; // Thời gian bắt đầu không được để trống
		}

		if (Commands.contains(GetCommand.TheoId_LopHocPhan)) {
			if (IdLHP == 0)
				return null; // Id lớp học phần không được để trống

		}
		if (Commands.contains(GetCommand.TheoMa_GiangVienGiangDay)) {
			if (MaGVGiangDay == null)
				return null; // Mã giảng viên giảng dạy không được để trống

		}
		if (Commands.contains(GetCommand.TheoMa_NguoiMuonPhong)) {
			if (MaNgMPH == null)
				return null; // Mã người mượn phòng không được để trống

		}
		return lichMuonPhongRepository.getListByCondition(Commands,
				ThoiGian_BD,
				ThoiGian_KT,
				IdLHP,
				MaGVGiangDay,
				MaNgMPH);
	}

	public LichMuonPhong layThongTin(int IdLichMPH) {
		return lichMuonPhongRepository.getByIdLMPH(IdLichMPH);
	}

	public enum GetCommand {
		TheoThoiGian_LichMuonPhong,
		TheoTrangThai_ChuaMuonPhong,
		TheoTrangThai_DaMuonPhong,
		TheoTrangThai_ChuaTraPhong,
		TheoTrangThai_DaHuy,
		TheoMucDich_LyThuyet,
		TheoMucDich_ThucHanh,
		TheoMucDich_Khac,
		TheoId_LopHocPhan,
		TheoMa_GiangVienGiangDay,
		TheoMa_NguoiMuonPhong
	}

	public LichMuonPhong luuThongTin(LichMuonPhong lichMuonPhong) {
		if (lichMuonPhongRepository.post(lichMuonPhong)) {
			return lichMuonPhong;
		}
		return null;
	}

	public boolean capNhatThongTin(LichMuonPhong lichMuonPhong) {
		if (lichMuonPhongRepository.existsRecord(Integer.parseInt(lichMuonPhong.getIdLMPH()))
				&& lichMuonPhongRepository.put(lichMuonPhong)) {
			return true;
		}
		return false;
	}

}
