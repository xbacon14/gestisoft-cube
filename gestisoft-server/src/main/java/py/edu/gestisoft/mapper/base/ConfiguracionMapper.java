package py.edu.gestisoft.mapper.base;

import java.util.List;

import py.edu.gestisoft.model.sistema.DatosEmpresa;

public interface ConfiguracionMapper {
	void truncateTables();

	List<DatosEmpresa> verificaConfiguracionEfectuada();
}
