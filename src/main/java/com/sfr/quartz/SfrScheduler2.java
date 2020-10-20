package com.sfr.quartz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class SfrScheduler2 extends QuartzJobBean {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		executeJob();
	}
	
	@SuppressWarnings("resource")
	private void executeJob() {		
		Connection conn = null;
		PreparedStatement stmt= null;
		ResultSet rs = null;
		
		try {
			/* *
			 * 검색이력 삭제 5일
			 * */
			
			String thisDay = new java.text.SimpleDateFormat ("yyyyMMdd").format(new java.util.Date());
			//String thisDay = "20180321";
				
			
			Properties prop = new Properties();
        	prop.load(getClass().getClassLoader().getResourceAsStream("properties/sfr.properties"));
        	
        	//String url = "jdbc:cubrid:172.17.0.30:33000:sfr_dev2:::";
    		//String username="dba";
    		//String password="soul0901";
			
			
			Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
			
			//conn = DriverManager.getConnection(url,username,password);
			conn = DriverManager.getConnection(prop.getProperty("jdbc.url"), 
												prop.getProperty("jdbc.username"), 
												prop.getProperty("jdbc.password"));

			conn.setAutoCommit(false);
			
			log.debug("-------------검색이력 삭제 START------------	:"+thisDay);
			
			
			stmt = conn.prepareStatement("DELETE FROM tbl_srch_log_n");
			
			stmt.executeUpdate();
			
			conn.commit();
			
			
			
			log.debug("-------------검색이력 삭제 END------------	:"+thisDay);
			
			
			
			
		}catch(Exception e){
			log.debug("-------------검색이력 삭제 Exception------------	:"+e.toString());
		}finally{
			try{
				if(conn != null){
					conn.close();
				}
				if(stmt != null){
					stmt.close();
				}
				if(rs != null){
					rs.close();
				}
			}catch(Exception e1){
				e1.printStackTrace();
			}
		}
	}
}
