package py.edu.gestisoft.utils.date;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.context.i18n.LocaleContextHolder;

public class DateUtils {

	public static String formatDateTime(LocalDateTime date) {
		Locale locale = LocaleContextHolder.getLocale();

		String pattern = "dd/MM/YYYY HH:mm";
		if (locale.getDisplayLanguage().contains("en")) {
			pattern = "yyy-MM-dd HH:mm";
		}
		LocalDateTime localDateTime = date.atZone(ZoneOffset.UTC).withZoneSameInstant(ZoneId.of("UTC" + "-00:00"))
				.toLocalDateTime();

		String dateFormatted = DateTimeFormatter.ofPattern(pattern).format(localDateTime);
		return dateFormatted;
	}

	public static String formatDate(LocalDate date) {
		Locale locale = LocaleContextHolder.getLocale();
		String pattern = "dd/MM/YYYY";
		if (locale.getDisplayLanguage().contains("en")) {
			pattern = "yyy-MM-dd";
		}
		String dateFormatted = DateTimeFormatter.ofPattern(pattern).format(date);
		return dateFormatted;
	}
}
