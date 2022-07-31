package py.edu.gestisoft.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.model.base.DatosEmpresa;
import py.edu.gestisoft.repositories.base.DatosEmpresaRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class DatosEmpresaService {
	@Autowired
	private DatosEmpresaRepository datosEmpresaRepository;

	public DatosEmpresa save(DatosEmpresa datosEmpresa) {
		return datosEmpresaRepository.save(datosEmpresa);
	}

	public List<DatosEmpresa> findAllEmpresas() {
		return datosEmpresaRepository.findAll();
	}
}
