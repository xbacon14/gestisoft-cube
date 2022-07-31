package py.edu.gestisoft.repositories.base;

import org.springframework.data.jpa.repository.JpaRepository;

import py.edu.gestisoft.model.base.DatosEmpresa;

public interface DatosEmpresaRepository extends JpaRepository<DatosEmpresa, Long> {

}
