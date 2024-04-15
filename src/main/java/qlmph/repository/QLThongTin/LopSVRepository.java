package qlmph.repository.QLThongTin;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import qlmph.model.QLThongTin.LopSV;

@Repository
@Transactional
public class LopSVRepository {
    
  @Autowired
  private SessionFactory sessionFactory;

  @SuppressWarnings("unchecked")
  public List<LopSV> getAll() {
      List<LopSV> lopSVs = null;
      Session session = null;
      try {

          session = sessionFactory.openSession();
          lopSVs = (List<LopSV>) session.createQuery("FROM LopSV")
                  .list();
      } catch (Exception e) {
          e.printStackTrace();
      } finally {
          if (session != null) {
              session.close();
          }
      }
      return lopSVs;
  }
}
