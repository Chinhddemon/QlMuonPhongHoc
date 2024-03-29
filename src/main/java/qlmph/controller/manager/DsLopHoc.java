package qlmph.controller.manager;

import java.util.List;
import java.util.UUID;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import qlmph.service.TTLopHocService;
import qlmph.bean.TTLopHocBean;
import qlmph.model.QLTaiKhoan.TaiKhoan;

@Controller
@RequestMapping("/DsLH")
public class DsLopHoc {
	@Autowired
	SessionFactory factory;
    
	@Transactional
    @RequestMapping("/XemDsLH")
    public String showDsLH(Model model) {
		String hql = "FROM TaiKhoan";
		@SuppressWarnings("unchecked")
		List<TaiKhoan> list =
			factory.getCurrentSession()
			.createQuery(hql)
			.list();

//    	List<TTLopHocBean> DsLopHoc = TTLopHocService.getAll();
    	
    	// Thiết lập khối dữ liệu hiển thị
//		model.addAttribute("DsLopHoc", DsLopHoc);
		
		// Thiết lập chuyển hướng trang kế tiếp theo điều kiện Usecase và tương tác View
		model.addAttribute("NextUsecaseTable", "DsMPH");
		model.addAttribute("NextUsecasePathTable", "XemDsMPH");
    	
        return "components/boardContent/ds-lop-hoc";
    }
    
}
