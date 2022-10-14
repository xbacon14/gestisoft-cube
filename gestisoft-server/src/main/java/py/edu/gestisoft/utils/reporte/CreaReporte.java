package py.edu.gestisoft.utils.reporte;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ResourceUtils;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsExporterConfiguration;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import py.edu.gestisoft.utils.date.DateUtils;

@Service
@Transactional(rollbackFor = Exception.class)
public class CreaReporte {

	public ResponseEntity<?> generaReporte(String filtro, String nombreReporte, List<?> list) {
		String path = "classpath:reports/";
		if (filtro == null || filtro.isEmpty()) {
			filtro = "NO POSEE FILTROS";
		}

		try {
			File file = ResourceUtils.getFile(path + nombreReporte + ".jrxml");
			InputStream input = new FileInputStream(file);
			JasperReport jasperReport = JasperCompileManager.compileReport(input);
			JRBeanCollectionDataSource source = new JRBeanCollectionDataSource(list);
			Map<String, Object> parameters = new HashMap<>();
			parameters.put("P_FILTRO", filtro);

			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, source);
			// Export the report to a PDF file
			byte[] data = JasperExportManager.exportReportToPdf(jasperPrint);
			if (data == null) {
				return ResponseEntity.ok(null);
			}
			String strg = Base64.getEncoder().encodeToString(data);
			return ResponseEntity.ok().body(strg);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return ResponseEntity.ok("ERROR AL GENERAR EL REPORTE");
		}
	}

	public ResponseEntity<?> generaXLS(String filtro, String nombreReporte, List<?> list) {

		ResponseEntity<?> response = ResponseEntity.ok(null);
		String path = "classpath:reports/";

		if (filtro == null || filtro.isEmpty()) {
			filtro = "NO POSEE FILTROS";
		}

		try {

			File file = ResourceUtils.getFile(path + nombreReporte + ".jrxml");
			InputStream input = new FileInputStream(file);
			JasperReport jasperReport = JasperCompileManager.compileReport(input);
			JRBeanCollectionDataSource source = new JRBeanCollectionDataSource(list);
			Map<String, Object> parameters = new HashMap<>();

			parameters.put("P_FILTRO", filtro);

			JasperPrint print = JasperFillManager.fillReport(jasperReport, parameters, source);

			JRXlsExporter exporterXLS = new JRXlsExporter();
			byte[] rawBytes;
			try (ByteArrayOutputStream xlsReport = new ByteArrayOutputStream()) {

				exporterXLS.setExporterInput(new SimpleExporterInput(print));
				exporterXLS.setExporterOutput(new SimpleOutputStreamExporterOutput(xlsReport));

				SimpleXlsReportConfiguration xlsReportConfiguration = new SimpleXlsReportConfiguration();
				SimpleXlsExporterConfiguration xlsExporterConfiguration = new SimpleXlsExporterConfiguration();

				xlsReportConfiguration.setOnePagePerSheet(true);
				xlsReportConfiguration.setRemoveEmptySpaceBetweenRows(true);
				xlsReportConfiguration.setDetectCellType(true);
				xlsReportConfiguration.setWhitePageBackground(false);
				exporterXLS.setConfiguration(xlsExporterConfiguration);
				exporterXLS.exportReport();
				rawBytes = xlsReport.toByteArray();

				if (rawBytes == null) {
					response = ResponseEntity.ok(null);
				}
				String s = Base64.getEncoder().encodeToString(rawBytes);
				response = ResponseEntity.ok().header("Content-Type", "application/pdf; charset=UTF-8").header(
						"Content-Disposition",
						"inline; filename=\"" + nombreReporte + "-" + DateUtils.formatDate(LocalDate.now()) + ".xls\"")
						.body(s);
			} catch (Exception e) {
				// TODO: handle exception
			}

//			exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, print);
//			exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, arrayOutputStream);
//			exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
//			exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
//			exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
//			exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
//			exporterXLS.exportReport();
//			
//			byte[] data = JasperExportManager.exportreportto

		} catch (JRException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		return response;
	}

}
