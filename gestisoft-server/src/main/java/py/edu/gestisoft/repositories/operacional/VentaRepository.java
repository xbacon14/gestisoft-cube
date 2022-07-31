package py.edu.gestisoft.repositories.operacional;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.operacional.Venta;

public interface VentaRepository extends JpaRepository<Venta, Long> {

}
