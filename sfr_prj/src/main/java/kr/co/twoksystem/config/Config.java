package kr.co.twoksystem.config;

import java.util.ResourceBundle;

import org.apache.commons.lang.StringUtils;

public class Config {

	public static final String SERVICE_PACKAGE;
	public static final String BIZ_PACKAGE;
	public static final String PATH_FILE_UPLOAD;
	public static final int DBMS_COUNT;
	public static final String DBMS_DEFAULT;

	static {
		try {
			String propNm = "webapp";
			ResourceBundle res = ResourceBundle.getBundle(propNm);

			SERVICE_PACKAGE = StringUtils.trimToEmpty(res.getString("servicePackage"));
			BIZ_PACKAGE = StringUtils.trimToEmpty(res.getString("bizPackage"));
			PATH_FILE_UPLOAD = StringUtils.trimToEmpty(res.getString("pathFileUpload"));
			DBMS_COUNT = Integer.parseInt(StringUtils.trimToEmpty(res.getString("dbmsCount")), 10);
			DBMS_DEFAULT = StringUtils.trimToEmpty(res.getString("dbmsDefault"));
			
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new RuntimeException("Error.. initializing com.globee.core.config.Config class. cause : " + ex);
		}
	}

}
