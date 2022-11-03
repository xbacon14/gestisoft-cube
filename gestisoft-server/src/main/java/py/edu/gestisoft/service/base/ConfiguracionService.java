package py.edu.gestisoft.service.base;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.mapper.base.ConfiguracionMapper;
import py.edu.gestisoft.model.sistema.DatosEmpresa;

@Service
@Transactional(rollbackFor = Exception.class)
public class ConfiguracionService {
	@Autowired
	private ConfiguracionMapper configuracionMapper;

	public Boolean truncateTables() {
		configuracionMapper.truncateTables();
		return true;
	}

	public DatosEmpresa verificarConfiguracionEfectuada() {
		List<DatosEmpresa> empresas = new ArrayList<DatosEmpresa>();
		empresas = configuracionMapper.verificaConfiguracionEfectuada();

		if (empresas.isEmpty()) {
			return null;
		} else {
			return empresas.get(0);
		}

	}

}
