package com.sfr.quartz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class SfrScheduler3 extends QuartzJobBean {
	
	private Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		executeJob();
	}
	
	@SuppressWarnings("resource")
	private void executeJob() {		
		Connection conn = null;
		PreparedStatement pstmt= null;
		PreparedStatement pstmt2= null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try {
			/* *
			 * MOUS006 테이블 - 사용자 관리
			 * */
			
			java.text.SimpleDateFormat sdfNow = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
			Properties prop = new Properties();
        	prop.load(getClass().getClassLoader().getResourceAsStream("properties/sfr.properties"));
        	
			Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
			
			conn = DriverManager.getConnection(prop.getProperty("jdbc.url"), prop.getProperty("jdbc.username"), prop.getProperty("jdbc.password"));

			log.error("-------------MOUS BATCH START------------	: "+sdfNow.format(System.currentTimeMillis()));
			
			String tblOrgNm = "MOUS0006_IFC0006"; 	// 원본 테이블 이름
			String tblBakNm = "MOUS0006_BACKUP"; 	// 백업 테이블 이름
			String tblBatNm = "TBL_MOUS_USER"; 		// 배치 테이블 이름
			int splitNum = 100; // 분할 건수
			
			pstmt = conn.prepareStatement("SELECT COUNT(*) FROM " + tblOrgNm);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			int orgTot = rs.getInt(1); // 원본 테이블 전체 갯수 
			int resultCnt = 0; // 성공 건수
			
			String sql = "";
			
			conn.setAutoCommit(false);
			
			if(orgTot>0){ // 원본 테이블에 들어온 데이터가 1건이라도 있으면 실행
				for(int i=0; i<orgTot; i+=splitNum ){
					log.debug("================== " + i + " / " + orgTot);
					
					pstmt = conn.prepareStatement("SELECT mdcd,srvno,dims_data_seq FROM " + tblOrgNm + " ORDER BY DIMS_DATA_SEQ ASC LIMIT "+splitNum);
					rs = pstmt.executeQuery();
					
					while(rs.next()) {
						stmt = conn.createStatement();
						
						String mdcd = rs.getString("mdcd");	  // 현재 소속 군) 1:국방부, 5:육군, 6:해군, 7:공군
						String srvno = rs.getString("srvno"); // 군번
						int seq = rs.getInt("dims_data_seq"); // SEQ
						
						log.debug("["+resultCnt+ "] mdcd : "+mdcd+", srvno : " + srvno+", seq : " + seq);
						
						pstmt2 = conn.prepareStatement("SELECT COUNT(*) FROM "+tblBatNm+" WHERE MDCD=? AND SRVNO=? AND DIMS_DATA_SEQ < ?");
						pstmt2.setString(1, mdcd);
						pstmt2.setString(2, srvno);
						pstmt2.setInt(3, seq);
						
						rs2 = pstmt2.executeQuery();
						rs2.next();
						int batCnt = rs2.getInt(1); // 원본 테이블 전체 갯수 
						
						if(batCnt == 0) {
							// 신규 데이터 추가
							sql = "INSERT INTO "+tblBatNm+ " (SELECT * FROM "+tblOrgNm+" WHERE SRVNO='"+srvno+"' AND MDCD ="+mdcd+" AND DIMS_DATA_SEQ ="+seq+")";
							stmt.addBatch(sql);
//							stmt = conn.createStatement();
//							stmt.executeUpdate(sql);
//							stmt.close();
						}else {
							// 기존 데이터 삭제
							sql = "DELETE FROM "+tblBatNm+" WHERE SRVNO='"+srvno+"' AND MDCD ="+mdcd;
							stmt.addBatch(sql);
//							stmt = conn.createStatement();
//							stmt.executeUpdate(sql);
//							stmt.close();
							
							// 변경 데이터 추가
							sql = "INSERT INTO "+tblBatNm+ " (SELECT * FROM "+tblOrgNm+" WHERE SRVNO='"+srvno+"' AND MDCD ="+mdcd+" AND DIMS_DATA_SEQ ="+seq+")";
							stmt.addBatch(sql);
//							stmt = conn.createStatement();
//							stmt.executeUpdate(sql);
//							stmt.close();
						}
						
						// 백업 테이블에 추가
						sql = "INSERT INTO "+tblBakNm+ " (SELECT * FROM "+tblOrgNm+" WHERE SRVNO='"+srvno+"' AND MDCD ="+mdcd+" AND DIMS_DATA_SEQ = "+seq+")";
						stmt.addBatch(sql);
//						stmt = conn.createStatement();
//						stmt.executeUpdate(sql);
//						stmt.close();
						
						// 원본 데이터 삭제
						sql = "DELETE FROM "+tblOrgNm+" WHERE SRVNO='"+srvno+"' AND MDCD ="+mdcd+" AND DIMS_DATA_SEQ = "+seq;
						stmt.addBatch(sql);
//						stmt = conn.createStatement();
//						stmt.executeUpdate(sql);
//						stmt.close();
						
						resultCnt++;
						
						stmt.executeBatch(); // Batch execute
	                    stmt.clearBatch(); // Batch clear
	                    conn.commit(); // connection commit
	                    stmt.close();
	                    pstmt2.close();
						
	                }
					
					pstmt.close();
					
				}
				
	            System.out.println(sdfNow.format(System.currentTimeMillis()) + "] " + resultCnt + "건 executeBatch()");
			}
			
			log.debug("-------------MOUS BATCH END------------	:"+sdfNow.format(System.currentTimeMillis()));
			
		}catch(Exception e){
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			log.debug("-------------MOUS BATCH Exception------------	:"+e.toString());
		}finally{
			try{
				if(rs2 != null){
					rs2.close();
				}
				if(rs != null){
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
				if(pstmt2 != null){
					pstmt2.close();
				}
				if(pstmt != null){
					pstmt.close();
				}
				if(conn != null){
					conn.close();
				}
			}catch(Exception e1){
				e1.printStackTrace();
			}
		}
		
	}
	
}
