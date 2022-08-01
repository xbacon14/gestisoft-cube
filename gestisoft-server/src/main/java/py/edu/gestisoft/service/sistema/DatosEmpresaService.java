package py.edu.gestisoft.service.sistema;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import py.edu.gestisoft.model.sistema.DatosEmpresa;
import py.edu.gestisoft.repositories.sistema.DatosEmpresaRepository;

@Service
@Transactional(rollbackFor = Exception.class)
public class DatosEmpresaService {
	// INYECTA EL REPOSITORIO DEL MODULO
	@Autowired
	private DatosEmpresaRepository datosEmpresaRepository;

//		PERSISTE Y GUARDA LOS DATOS RECIBIDOS EN LA TABLA DATOS EMPRESA 
	public DatosEmpresa save(DatosEmpresa datosEmpresa) {
		return datosEmpresaRepository.save(datosEmpresa);
	}

//		DEVUELVE TODOS LOS DATOS DE LA TABLA DATOS_EMPRESA
	public List<DatosEmpresa> findAllDatosEmpresa() {
		return datosEmpresaRepository.findAll();
	}
}
