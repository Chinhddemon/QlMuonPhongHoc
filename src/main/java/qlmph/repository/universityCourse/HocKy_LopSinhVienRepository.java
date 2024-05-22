package qlmph.repository.universityCourse;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import qlmph.model.universityCourse.HocKy_LopSinhVien;

@Repository
public class HocKy_LopSinhVienRepository {
  
  @Autowired
  private SessionFactory sessionFactory;

  public List<HocKy_LopSinhVien> getAll() {
    try (Session session = sessionFactory.openSession()) {
      return session.createQuery("FROM HocKy_LopSinhVien", HocKy_LopSinhVien.class).list();
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }

  public HocKy_LopSinhVien getById(int idHocKy_LopSinhVien) {
    try (Session session = sessionFactory.openSession()) {
      return session.get(HocKy_LopSinhVien.class, idHocKy_LopSinhVien);
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
  }
}
