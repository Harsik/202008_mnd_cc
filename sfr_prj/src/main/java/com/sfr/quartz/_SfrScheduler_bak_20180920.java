package com.sfr.quartz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class _SfrScheduler_bak_20180920 extends QuartzJobBean {
	
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
			 * 군 정보	(A=국방부,B=육군, C=해군, D=공군)
			 * 각군 BATCH 가 돌았는지 확인...
			 *   
			 * BACKUP 테이블 확인... 일주일치만 저장..
			 * 
			 * */
			
			String thisDay = new java.text.SimpleDateFormat ("yyyyMMdd").format(new java.util.Date());
				
			java.text.SimpleDateFormat sdfNow = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


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
			
			log.debug("-------------BATCH START------------	: "+sdfNow.format(System.currentTimeMillis()));
			log.debug("----------------------------------- start: "+sdfNow.format(System.currentTimeMillis()));
			
			//테이블 백업
			tableBackup(conn, stmt, rs, thisDay);
			
			
			log.debug("----------------------------------- backup end: "+sdfNow.format(System.currentTimeMillis()));
			
			ifUserDeleteC(conn, stmt, rs);
			
			//(국방부:A)
			ifATableToTable(conn, stmt, rs, "A", thisDay);
			
			log.debug("----------------------------------- A end: "+sdfNow.format(System.currentTimeMillis()));
			
			//(육군:B)
			ifTableToTable(conn, stmt, rs, "B", thisDay);
			
			log.debug("----------------------------------- B end: "+sdfNow.format(System.currentTimeMillis()));
			
			//(해군:C)
			ifTableToTable(conn, stmt, rs, "C", thisDay);

			log.debug("----------------------------------- C end: "+sdfNow.format(System.currentTimeMillis()));
			
			//(공군:D)
			ifTableToTable(conn, stmt, rs, "D", thisDay);
			
			log.debug("----------------------------------- D end: "+sdfNow.format(System.currentTimeMillis()));
			
			
			//최상위 코드 #으로 초기화
			hrgnkSetting(conn, stmt, rs, "A", "1290000");
			
			hrgnkSetting(conn, stmt, rs, "A", "1290451");
		
			hrgnkSetting(conn, stmt, rs, "B", "9810001");
			
			hrgnkSetting(conn, stmt, rs, "C", "6000000000");
			
			hrgnkSetting(conn, stmt, rs, "D", "");
			
			hrgnkSettingC(conn, stmt, rs, "C", "6000000000");
			
			
			
			log.debug("FULL DEPT NM UPDATE : A start");
			
			stmt = conn.prepareStatement("UPDATE tbl_dept a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS full_dept_nm, dept_cd "
							+ "   FROM tbl_dept start WITH HGRNK_DEPT_CD=? AND mildsc=? connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.full_dept_nm = b.full_dept_nm "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "A");
			
			stmt.executeUpdate();
			conn.commit();
			log.debug("FULL DEPT NM UPDATE : A end");
			

			log.debug("FULL DEPT NM UPDATE : B start");
			
			stmt = conn.prepareStatement("UPDATE tbl_dept a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS full_dept_nm, dept_cd "
							+ "   FROM tbl_dept start WITH HGRNK_DEPT_CD=? AND mildsc=? connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.full_dept_nm = b.full_dept_nm "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "B");
			
			stmt.executeUpdate();
			conn.commit();
			log.debug("FULL DEPT NM UPDATE : B end");
			
			
			log.debug("FULL DEPT NM UPDATE : C start");
			
			stmt = conn.prepareStatement("UPDATE tbl_dept a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS full_dept_nm, dept_cd "
							+ "   FROM tbl_dept start WITH HGRNK_DEPT_CD=? AND mildsc=? connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.full_dept_nm = b.full_dept_nm "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "C");
			
			stmt.executeUpdate();
			conn.commit();
			log.debug("FULL DEPT NM UPDATE : C end");
			
			
			log.debug("FULL DEPT NM UPDATE : D start");
			
			stmt = conn.prepareStatement("UPDATE tbl_dept a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS full_dept_nm, dept_cd "
							+ "   FROM tbl_dept start WITH HGRNK_DEPT_CD=? AND mildsc=? connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.full_dept_nm = b.full_dept_nm "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "D");
			
			stmt.executeUpdate();
			conn.commit();
			log.debug("FULL DEPT NM UPDATE : D end");
			
			
			log.debug("-------------BATCH END------------	: "+sdfNow.format(System.currentTimeMillis()));
			
		}catch(Exception e){
			e.printStackTrace();
		} finally{
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
	
	
	public void ifUserDeleteC(Connection conn, PreparedStatement stmt, ResultSet rs) throws Exception {

		try {

			log.debug("USER 해군 병 삭제  start :	");

			// log.debug(selectSql);
			stmt = conn.prepareStatement("DELETE FROM tbl_user_if WHERE mildsc ='C' AND RANK LIKE '%병%'");

			stmt.executeUpdate();

			conn.commit();
			
			log.debug("USER 해군 병 삭제  end :	");
			
		} catch(Exception e){
			e.printStackTrace();
		}

	}
	
	
	

	public void ifTableToTable(
									Connection conn,	
									PreparedStatement stmt,	
									ResultSet rs, 
									String mildsc,
									String thisDay) throws Exception{
		
		
		try{
			
			log.debug("USER 인터페이스 테이블 확인 (B=육군, C=해군, D=공군) :	"+mildsc);
			
			//log.debug(selectSql);
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_IF WHERE MILDSC=? AND REG_DT=?");
			
			stmt.setString(1, mildsc);
			stmt.setString(2, thisDay);
			rs = stmt.executeQuery();
			rs.next();
			
			if(rs.getInt(1)>0){
				
				log.debug("USER 테이블 DELETE :	"+mildsc);
				//log.debug(deleteSql);
				
				stmt = conn.prepareStatement("DELETE FROM TBL_USER WHERE MILDSC=?");
				
				stmt.setString(1, mildsc);
				stmt.executeUpdate();	
				
				
				log.debug("USER 테이블 INSERT :	"+mildsc);
				//log.debug(insertSql);
				
				stmt = conn.prepareStatement("INSERT INTO TBL_USER SELECT * FROM TBL_USER_IF WHERE MILDSC=? AND REG_DT=?");
				
				stmt.setString(1, mildsc);
				stmt.setString(2, thisDay);
				stmt.executeUpdate();			
				
				
				log.debug("USER 인터페이스 테이블 DELETE :	"+mildsc);
				
				//stmt = conn.prepareStatement("DELETE FROM TBL_USER_IF WHERE MILDSC=?");
				//stmt.setString(1, mildsc);
				//stmt.executeUpdate();				
				
			}else{
				log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.debug(thisDay+"	   USER  인터페이스 테이블 데이터 없음	:	"+mildsc);
				throw new Exception();
			}
			
			
			
			log.debug("DEPT 인터페이스 테이블 확인 (B=육군, C=해군, D=공군) :	"+mildsc);
			
			//log.debug(selectSql);
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_IF WHERE MILDSC=? AND REG_DT=?");
			
			stmt.setString(1, mildsc);
			stmt.setString(2, thisDay);
			rs = stmt.executeQuery();
			rs.next();
			
			if(rs.getInt(1)>0){
				
				
				log.debug("DEPT 테이블 DELETE :	"+mildsc);
				//log.debug(deleteSql);
				
				stmt = conn.prepareStatement("DELETE FROM TBL_DEPT WHERE MILDSC=?");
				
				stmt.setString(1, mildsc);
				stmt.executeUpdate();	
				
				
				log.debug("DEPT 테이블 INSERT :	"+mildsc);
				//log.debug(insertSql);
				
				stmt = conn.prepareStatement("INSERT INTO TBL_DEPT SELECT * FROM TBL_DEPT_IF WHERE MILDSC=? AND REG_DT=?");
				
				stmt.setString(1, mildsc);
				stmt.setString(2, thisDay);
				stmt.executeUpdate();			
				
				
				log.debug("DEPT 인터페이스 테이블 DELETE :	"+mildsc);
				
				//stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_IF WHERE MILDSC=?");
				//stmt.setString(1, mildsc);
				//stmt.executeUpdate();			
				
				
				
			}else{
				log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.debug(thisDay+"	   DEPT  인터페이스 테이블 데이터 없음	:	"+mildsc);
				throw new Exception();
			}
			
			
			
			
			
			conn.commit();
			
			
		}catch(Exception e){
			conn.rollback();
			log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.debug(thisDay+"	   Exception	:	"+mildsc);
			
			e.printStackTrace();
			log.debug(e.getMessage());
		}
	}
	
	
	

	
	/* 국방부 테이블 IF 테이블 따로 처리*/
	public void ifATableToTable(
									Connection conn,	
									PreparedStatement stmt,	
									ResultSet rs, 
									String mildsc,
									String thisDay) throws Exception{
		
		
		try{
			
			log.debug("USER 인터페이스 테이블 확인 (A=국방부) :	"+mildsc);
			
			stmt = conn.prepareStatement("update tbl_dept_a_if set seq = '999999' where seq is null");
			stmt.executeUpdate();	

			conn.commit();
			
			stmt = conn.prepareStatement("update tbl_user_a_if set seq = '999999' where seq is null");
			stmt.executeUpdate();	

			conn.commit();
			
			//log.debug(selectSql);
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_A_IF");
			
			//stmt.setString(1, mildsc);
			//stmt.setString(2, thisDay);
			rs = stmt.executeQuery();
			rs.next();
			
			if(rs.getInt(1)>0){
				
				log.debug("USER 테이블 DELETE  (A=국방부) :	"+mildsc);
				//log.debug(deleteSql);
				
				stmt = conn.prepareStatement("DELETE FROM TBL_USER WHERE MILDSC=?");
				
				stmt.setString(1, mildsc);
				stmt.executeUpdate();	
				
				
				log.debug("USER 테이블 INSERT  (A=국방부) :	"+mildsc);
				//log.debug(insertSql);
				
				stmt = conn.prepareStatement("INSERT INTO TBL_USER "
						+ " (SELECT SEQ, ?, ?, ID,PW,NM,DEPT_CD,MIL_NO,	RSPSBLT_BIZNES,	RANK, RSPOFC_NM,	TELNO,	MPNO,	EMAIL,	OPNPBL_YN,	STATE "
						+ " FROM TBL_USER_A_IF) ");
				
				stmt.setString(1, thisDay);
				stmt.setString(2, mildsc);			
				
				stmt.executeUpdate();			
							
				
			}else{
				log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.debug(thisDay+"	   USER  인터페이스 테이블 데이터 없음	:	"+mildsc);
			}
			
			
			
			log.debug("DEPT 인터페이스 테이블 확인 (A=국방부) :	"+mildsc);
			
			//log.debug(selectSql);
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_A_IF");
			
			//stmt.setString(1, mildsc);
			//stmt.setString(2, thisDay);
			rs = stmt.executeQuery();
			rs.next();
			
			if(rs.getInt(1)>0){
				
				
				log.debug("DEPT 테이블 DELETE  (A=국방부) :	"+mildsc);
				//log.debug(deleteSql);
				
				stmt = conn.prepareStatement("DELETE FROM TBL_DEPT WHERE MILDSC=?");
				
				stmt.setString(1, mildsc);
				stmt.executeUpdate();	
				
				
				log.debug("DEPT 테이블 INSERT  (A=국방부) :	"+mildsc);
				//log.debug(insertSql);
				
				stmt = conn.prepareStatement("INSERT INTO TBL_DEPT "
						+ " (SELECT SEQ, ?, ?, DEPT_CD, DEPT_NM, ORDER_NO, DEPT_ABRVWD, DEPT_ABRVWD2, FULL_DEPT_NM, HGRNK_DEPT_CD, TELNO, OPNPBL_YN, STATE "
						+ " FROM TBL_DEPT_A_IF)");
				
				stmt.setString(1, thisDay);
				stmt.setString(2, mildsc);
				
				stmt.executeUpdate();			
				
				
			}else{
				log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.debug(thisDay+"	   DEPT  인터페이스 테이블 데이터 없음	:	"+mildsc);
			}
			
			
			
			
			
			conn.commit();
			
			
		}catch(Exception e){
			conn.rollback();
			log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.debug(thisDay+"	   Exception	:	"+mildsc);
			
			e.printStackTrace();
			log.debug(e.getMessage());
		}
	}
	
	
	
	
	
	public void tableBackup(Connection conn,	
									PreparedStatement stmt,	
									ResultSet rs,
									String thisDay) throws Exception {
		
		try{
			
			log.debug("USER 백업 테이블 삭제 ");
			stmt = conn.prepareStatement("DELETE FROM TBL_USER_BACKUP");
			stmt.executeUpdate();	
			
			log.debug("DEPT 백업 테이블 삭제 ");
			stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_BACKUP");
			stmt.executeUpdate();	
			
			log.debug("USER 테이블 백업 ");
			stmt = conn.prepareStatement("INSERT INTO TBL_USER_BACKUP SELECT * FROM TBL_USER");
			stmt.executeUpdate();	
			
			log.debug("DEPT 테이블 백업 ");
			stmt = conn.prepareStatement("INSERT INTO TBL_DEPT_BACKUP SELECT * FROM TBL_DEPT");
			stmt.executeUpdate();	
			
			conn.commit();
		}catch(Exception e){
			conn.rollback();
			log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.debug(thisDay+"	 BACKUP Exception	");
			
			e.printStackTrace();
			log.debug(e.getMessage());
		}
		
	}
	
	
	
	/* 상위 부서코드 #으로 초기화*/
	public void hrgnkSetting(
									Connection conn,	
									PreparedStatement stmt,	
									ResultSet rs, 
									String mildsc,
									String deptCd) throws Exception{
		
		
		try{
			
			log.debug("상위 부서코드 #으로 초기화  start			: "+ mildsc);
			stmt = conn.prepareStatement("UPDATE tbl_dept SET HGRNK_DEPT_CD='#' WHERE mildsc=? and dept_cd=?");
			
			stmt.setString(1, mildsc);
			stmt.setString(2, deptCd);
			
			
			stmt.executeUpdate();	
			
			
			
			
			conn.commit();
			
			
			log.debug("상위 부서코드 #으로 초기화  end			: "+ mildsc);
		}catch(Exception e){
			conn.rollback();
			log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.debug("상위 부서코드 #으로 초기화 error");
			
			e.printStackTrace();
			log.debug(e.getMessage());
		}

	}
	
	public void hrgnkSettingC(
			Connection conn,	
			PreparedStatement stmt,	
			ResultSet rs, 
			String mildsc,
			String hgrnk_dept_cd) throws Exception{


	try{
	
			log.debug("해군 6000000000 => 6000000001변경  start			: "+ mildsc);
			stmt = conn.prepareStatement("UPDATE tbl_dept SET hgrnk_dept_cd ='6000000001' WHERE  mildsc=? AND hgrnk_dept_cd = ?");
			stmt.setString(1, mildsc);
			stmt.setString(2, hgrnk_dept_cd);
			
			
			stmt.executeUpdate();	
	
			stmt = conn.prepareStatement("UPDATE tbl_dept SET hgrnk_dept_cd = '6000000000' WHERE mildsc=? and dept_cd = '6000000001'");
			stmt.setString(1, mildsc);
			
			stmt.executeUpdate();	
			
			conn.commit();
			
			log.debug("해군 6000000000 => 6000000001변경 end			: "+ mildsc);
			
		}catch(Exception e){
			conn.rollback();
			log.debug("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.debug("상위 부서코드 #으로 초기화 error");
			
			e.printStackTrace();
			log.debug(e.getMessage());
		}
	
	}

	
}
