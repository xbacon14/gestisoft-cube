package py.edu.gestisoft.model.operacional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import py.edu.gestisoft.model.base.Cliente;
import py.edu.gestisoft.model.base.Vendedor;

@Entity
@Table(name = "VENTA")
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Venta {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID_VENTA")
	private Long id;

	@Column(name = "CHOFER")
	private String chofer;

	@Column(name = "DOC_NRO")
	private String docNro;

//	CAMBIAR PARA FECHA VENTA?
	@Column(name = "FECHA")
	private LocalDateTime fecha;

	@Column(name = "OBSERVACION")
	private String observacion;

//	CAMBIAR PARA VALOR_TOTAL_VENTA
//	NECESITA SER BIG DECIMAL PARA OPERACIONES DE VALORES
	@Column(name = "TOTAL")
	private BigDecimal total;

	@Column(name = "VEHICULO")
	private String vehiculo;

	@Column(name = "ESTADO")
	private Boolean estado;

	@ManyToOne
	@JoinColumn(name = "ID_VENDEDOR", referencedColumnName = "ID_VENDEDOR")
	private Vendedor vendedor;

	@ManyToOne
	@JoinColumn(name = "ID_CLIENTE", referencedColumnName = "ID_CLIENTE")
	private Cliente cliente;

	@OneToMany(mappedBy = "venta")
	private List<VentaDetalle> detalles;

	public Venta(Long i) {
		this.id = i;
	}
}
