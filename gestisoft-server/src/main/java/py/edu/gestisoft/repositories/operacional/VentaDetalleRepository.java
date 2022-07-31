package py.edu.gestisoft.repositories.operacional;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.operacional.VentaDetalle;

public interface VentaDetalleRepository extends JpaRepository<VentaDetalle, Long> {

}
