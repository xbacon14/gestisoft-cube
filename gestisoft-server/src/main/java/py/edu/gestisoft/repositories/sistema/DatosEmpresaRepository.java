package py.edu.gestisoft.repositories.sistema;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.sistema.DatosEmpresa;

public interface DatosEmpresaRepository extends JpaRepository<DatosEmpresa	, Long> {

}
