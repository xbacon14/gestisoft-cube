package py.edu.gestisoft.model.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.Setter;

@Entity
@Table(name = "CLIENTE")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Cliente {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_CLIENTE")
	private Long id;

//	TODO 3
//	NO SERIA MEJOR LLAMARLE ACTIVO?
	@NonNull
	@Column(name = "ESTADO")
	private Boolean estado;

	@NonNull
	@Column(name = "NOMBRE")
	private String nombre;

	@Column(name = "CI_RUC")
	private String ciRuc;

	@Column(name = "CORREO_ELECTRONICO")
	private String correoElectronico;

//	TODO 2
//	REVISAR SI CELULARES ES NUMERO DE TELEFONO
	@Column(name = "NUMERO_CELULAR")
	private String numeroCelular;

	@Column(name = "NUMERO_LINEA_BAJA")
	private String numeroLineaBaja;

	@Column(name = "DIRECCION")
	private String direccion;

	@Column(name = "OBSERVACION")
	private String observacion;

//	TODO 1
//	REVISAR QUE ES LA FECHA ALTA
	@Column(name = "FECHA_ALTA")
	private String fechaAlta;

}
