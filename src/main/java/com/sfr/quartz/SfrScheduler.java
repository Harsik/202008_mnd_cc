package com.sfr.quartz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.Properties;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class SfrScheduler extends QuartzJobBean {
	
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
        	
			Class.forName("cubrid.jdbc.driver.CUBRIDDriver");
			
			conn = DriverManager.getConnection(prop.getProperty("jdbc.url"), 
												prop.getProperty("jdbc.username"), 
												prop.getProperty("jdbc.password"));

			conn.setAutoCommit(false);
			
			log.error("-------------BATCH START------------	: "+sdfNow.format(System.currentTimeMillis()));
			log.error("----------------------------------- start: "+sdfNow.format(System.currentTimeMillis()));
			
			//테이블 백업
			tableBackup(conn, stmt, rs, thisDay);
			
			log.error("----------------------------------- backup end: "+sdfNow.format(System.currentTimeMillis()));

			//해군 병 삭제
			ifUserDeleteC(conn, stmt, rs);

			log.error("----------------------------------- 해군 병 삭제 end: "+sdfNow.format(System.currentTimeMillis()));
			
			//(국방부:A)
			ifATableToTable(conn, stmt, rs, "A", thisDay);
			
			log.error("----------------------------------- A end: "+sdfNow.format(System.currentTimeMillis()));

			//(육군:B)
			ifTableToTable(conn, stmt, rs, "B", thisDay);
			
			log.error("----------------------------------- B end: "+sdfNow.format(System.currentTimeMillis()));
			
			//(해군:C)
			ifTableToTable(conn, stmt, rs, "C", thisDay);

			log.error("----------------------------------- C end: "+sdfNow.format(System.currentTimeMillis()));
			
			//(공군:D)
			ifTableToTable(conn, stmt, rs, "D", thisDay);
			
			log.error("----------------------------------- D end: "+sdfNow.format(System.currentTimeMillis()));
			
			//최상위 코드 #으로 초기화
			hrgnkSetting(conn, stmt, rs, "A", "1290000");
			
			hrgnkSetting(conn, stmt, rs, "A", "1290451");
		
			hrgnkSetting(conn, stmt, rs, "B", "9810001");
			
			hrgnkSetting(conn, stmt, rs, "C", "6000000000");
			
			hrgnkSetting(conn, stmt, rs, "D", "");
			
			hrgnkSettingC(conn, stmt, rs, "C", "6000000000");
			
			log.error("FULL DEPT NM UPDATE : A start");
			
			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS WHL_DEPT_NM, dept_cd "
							+ "    FROM TBL_DEPT_N start WITH HGRNK_DEPT_CD=? AND MDCD=? "
							+ "                    connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.WHL_DEPT_NM = b.WHL_DEPT_NM "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "A");
			
			stmt.executeUpdate();
			conn.commit();
			log.error("FULL DEPT NM UPDATE : A end");

			log.error("FULL DEPT NM UPDATE : B start");

			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS WHL_DEPT_NM, dept_cd "
							+ "   FROM TBL_DEPT_N start WITH HGRNK_DEPT_CD=? AND MDCD=? "
							+ "                   connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.WHL_DEPT_NM = b.WHL_DEPT_NM "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "B");
			
			stmt.executeUpdate();
			conn.commit();
			log.error("FULL DEPT NM UPDATE : B end");
			
			log.error("FULL DEPT NM UPDATE : C start");

			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS WHL_DEPT_NM, dept_cd "
							+ "   FROM TBL_DEPT_N start WITH HGRNK_DEPT_CD=? AND MDCD=? "
							+ "                   connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.WHL_DEPT_NM = b.WHL_DEPT_NM "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "C");
			
			stmt.executeUpdate();
			conn.commit();
			log.error("FULL DEPT NM UPDATE : C end");
			
			log.error("FULL DEPT NM UPDATE : D start");

			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N a, " 
							+ " (SELECT SYS_CONNECT_BY_PATH(dept_nm, ' ') AS WHL_DEPT_NM, dept_cd "
							+ "   FROM TBL_DEPT_N start WITH HGRNK_DEPT_CD=? AND MDCD=? "
							+ "                   connect by PRIOR dept_cd=HGRNK_DEPT_CD) b "
							+ " SET a.WHL_DEPT_NM = b.WHL_DEPT_NM "
							+ " WHERE 1=1  "
							+ " AND a.dept_cd=b.dept_cd");
			
			stmt.setString(1, "#");
			stmt.setString(2, "D");
			
			stmt.executeUpdate();
			conn.commit();
			log.error("FULL DEPT NM UPDATE : D end");

			log.error("-------------BATCH END------------	: "+sdfNow.format(System.currentTimeMillis()));
			
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

			log.error("USER 해군 병 삭제  start :	");

			stmt = conn.prepareStatement("DELETE FROM tbl_user_if_n WHERE MDCD ='C' AND RANK_NM LIKE '%병%'");

			stmt.executeUpdate();

			conn.commit();
			
			log.error("USER 해군 병 삭제  end :	");
			
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
			
			// 21.06.26
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -3);
			
			String beforeDate = new java.text.SimpleDateFormat("yyyyMMdd").format(cal.getTime());
			System.out.println("beforeDate >>> " + beforeDate);
			
			log.error("USER 인터페이스 테이블 확인 (B=육군, C=해군, D=공군) :	"+mildsc);
			
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_IF_N WHERE MDCD=? AND RGST_DATE=?");
			
			stmt.setString(1, mildsc);
			stmt.setString(2, thisDay);
			rs = stmt.executeQuery();
			rs.next();
			
			int ifCnt = rs.getInt(1);
			if(ifCnt>0){
				
				log.error("TBL_USER_N 테이블 DELETE :	"+mildsc);

				stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_N WHERE MDCD=?");
				stmt.setString(1, mildsc);
				rs = stmt.executeQuery();
				rs.next();
				int uTot = rs.getInt(1);
				int uCnt = (uTot/5000)+1;
				
				for(int i=0; i<uCnt; i++ ){
					log.error("TBL_USER_N 테이블 ROW 삭제중... "+ (i+1)*5000 + "/" + uTot);
					stmt = conn.prepareStatement("DELETE FROM TBL_USER_N WHERE MDCD=? LIMIT 5000");
					
					stmt.setString(1, mildsc);
					stmt.executeUpdate();	
				}	
				// USER 테이블 DELETE 종료
				
				log.error("TBL_USER_N 테이블 INSERT :	"+mildsc);
				
				String queryString ="INSERT INTO TBL_USER_N  (  " + 
									"  SEQ, RGST_DATE, MDCD, ID, ECRYPTPW " + 
									", FULNM, DEPT_CD, SRVNO, RSPSBLT_BIZNES_NM, RANK_NM " + 
									", RSPONM, EMAIL, TELNO, MPNO, OPNPBL_YN, USER_EXSTNC_EXNEX " + 
									")  " + 
									"SELECT  " + 
									"  SEQ, RGST_DATE, MDCD, ID, ECRYPTPW " + 
									", FULNM, DEPT_CD, SRVNO, RSPSBLT_BIZNES_NM, RANK_NM " + 
									", RSPONM, EMAIL, TELNO, MPNO, OPNPBL_YN, USER_EXSTNC_EXNEX " + 
									"FROM tbl_user_if_n " +
									"WHERE MDCD=? AND RGST_DATE=? " + 
									"AND ROWNUM > ? AND ROWNUM < ? ";
				
				for(int i=0; i < ifCnt; i+=5000) {
					log.error("TBL_USER_N 테이블 INSERT  분할중 :	"+ (i+1) + "~" + (i+5000) + "/" + ifCnt);
					
					stmt = conn.prepareStatement(queryString);
					
					stmt.setString(1, mildsc);
					stmt.setString(2, thisDay);
					stmt.setInt(3, i);
					stmt.setInt(4, i+5001);
					stmt.executeUpdate();
				}
				conn.commit();	
					
				
				/* 인터페이스 삭제 주석
				 * 21.06.18 n일치를 제외한 나머지 삭제 */
				log.error("TBL_USER_IF_N 인터페이스 테이블 DELETE :	"+mildsc+ ", "+beforeDate+" 이전 데이터 삭제");

				stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_IF_N WHERE MDCD=? AND RGST_DATE < ?");
				stmt.setString(1, mildsc);
				stmt.setString(2, beforeDate);
				rs = stmt.executeQuery();
				rs.next();
				int iTot = rs.getInt(1);
				int iCnt = (iTot/5000)+1;

				for(int i=0; i<iCnt; i++ ){
					log.error("TBL_USER_IF_N 테이블 ROW 삭제중... "+ (i+1)*5000 + "/" + iTot);
					stmt = conn.prepareStatement("DELETE FROM TBL_USER_IF_N WHERE MDCD=? AND RGST_DATE < ? LIMIT 5000");
					stmt.setString(1, mildsc);
					stmt.setString(2, beforeDate);
					stmt.executeUpdate();	
				}	
				conn.commit();	
				
			}else{
				log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.error(thisDay+"	   USER  인터페이스 테이블 데이터 없음	:	"+mildsc);
				throw new Exception();
			}
			
			log.error("DEPT 인터페이스 테이블 확인 (B=육군, C=해군, D=공군) :	"+mildsc);
			
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_IF_N WHERE MDCD=? AND RGST_DATE=?");
			
			stmt.setString(1, mildsc);
			stmt.setString(2, thisDay);
			rs = stmt.executeQuery();
			rs.next();
			
			int difCnt = rs.getInt(1);
			if(difCnt>0){
				
				
				log.error("DEPT 테이블 DELETE :	"+mildsc);

				stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_N WHERE MDCD=?");
				stmt.setString(1, mildsc);
				rs = stmt.executeQuery();
				rs.next();
				int dTot = rs.getInt(1);
				int dCnt = (dTot/5000)+1;

				for(int i=0; i<dCnt; i++ ){
					log.error("테이블 ROW 삭제중... "+ (i+1)*5000 + "/" + dTot);
					stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_N WHERE MDCD=? LIMIT 5000");
					
					stmt.setString(1, mildsc);
					stmt.executeUpdate();	
				}	
				
				
				log.error("DEPT 테이블 INSERT :	"+mildsc);
				
				String queryString ="INSERT INTO TBL_DEPT_N  (  " + 
									"  SEQ, RGST_DATE, MDCD, DEPT_CD " + 
									", DEPT_NM " + 
									", SEQC, DEPT_ABRVWD_NM " + 
									", WHL_DEPT_NM, HGRNK_DEPT_CD " + 
									", TELNO, OPNPBL_YN, DEPT_EXSTNC_EXNEX " + 
									")  " + 
									"SELECT  " + 
									"  SEQ, RGST_DATE, MDCD, DEPT_CD " + 
									", DEPT_NM " + 
									", SEQC, DEPT_ABRVWD_NM " + 
									", WHL_DEPT_NM, HGRNK_DEPT_CD " + 
									", TELNO, OPNPBL_YN, DEPT_EXSTNC_EXNEX " + 
									"FROM TBL_DEPT_IF_N  " +
									"WHERE MDCD=? AND RGST_DATE=? " +
									"AND ROWNUM > ? AND ROWNUM < ? " ;
					
				for(int i=0; i < difCnt; i+=5000) {
					log.error("DEPT 테이블 INSERT  분할중 :	"+ (i+1) + "~" + (i+5000) + "/" + difCnt);

					stmt = conn.prepareStatement(queryString);
					
					stmt.setString(1, mildsc);
					stmt.setString(2, thisDay);
					stmt.setInt(3, i);
					stmt.setInt(4, i+5001);
					stmt.executeUpdate();
				}
				conn.commit();
				
				/* 인터페이스 삭제 주석
				 * 21.06.18 n일치를 제외한 나머지 삭제 */
				log.error("TBL_DEPT_IF_N 인터페이스 테이블 DELETE :	" +mildsc+ ", "+beforeDate+" 이전 데이터 삭제");

				stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_IF_N WHERE MDCD=? AND RGST_DATE < ?");
				stmt.setString(1, mildsc);
				stmt.setString(2, beforeDate);
				rs = stmt.executeQuery();
				rs.next();
				int iTot = rs.getInt(1);
				int iCnt = (iTot/5000)+1;

				for(int i=0; i<iCnt; i++ ){
					log.error("TBL_DEPT_IF_N 테이블 ROW 삭제중... "+ (i+1)*5000 + "/" + iTot);
					stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_IF_N WHERE MDCD=? AND RGST_DATE < ? LIMIT 5000");
					stmt.setString(1, mildsc);
					stmt.setString(2, beforeDate);
					stmt.executeUpdate();		
				}		
				conn.commit();
				
			}else{
				log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.error(thisDay+"	   DEPT  인터페이스 테이블 데이터 없음	:	"+mildsc);
				throw new Exception();
			}
						
			
		}catch(Exception e){
			conn.rollback();
			log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.error(thisDay+"	   Exception	:	"+mildsc);
			
			e.printStackTrace();
			log.error(e.getMessage());
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
			
			log.error("USER 인터페이스 테이블 확인 (A=국방부) :	"+mildsc);
			
			stmt = conn.prepareStatement("update TBL_DEPT_A_IF_N set seq = '999999' where seq is null");
			stmt.executeUpdate();	

			conn.commit();
			
			stmt = conn.prepareStatement("update TBL_USER_A_IF_N set seq = '999999' where seq is null");
			stmt.executeUpdate();	

			conn.commit();
			
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_A_IF_N");
			
			rs = stmt.executeQuery();
			rs.next();
			
			if(rs.getInt(1)>0){
				
				log.error("USER 테이블 DELETE  (A=국방부) :	"+mildsc);
				
				stmt = conn.prepareStatement("DELETE FROM TBL_USER_N WHERE MDCD=?");
				
				stmt.setString(1, mildsc);
				stmt.executeUpdate();	
				
				log.error("USER 테이블 INSERT  (A=국방부) :	"+mildsc);

				stmt = conn.prepareStatement("INSERT INTO TBL_USER_N "
						+ " (SEQ, RGST_DATE, MDCD, ID, ECRYPTPW, FULNM, DEPT_CD, SRVNO,"
						+ " RSPSBLT_BIZNES_NM, RANK_NM, RSPONM, TELNO, MPNO, EMAIL, OPNPBL_YN, USER_EXSTNC_EXNEX) "
						+ " (SELECT SEQ, ?, ?, ID, ECRYPTPW, FULNM, DEPT_CD, SRVNO	"
						+ ", RSPSBLT_BIZNES_NM, RANK_NM, RSPONM, TELNO, MPNO, EMAIL, OPNPBL_YN, USER_EXSTNC_EXNEX "
						+ " FROM TBL_USER_A_IF_N) ");
				
				stmt.setString(1, thisDay);
				stmt.setString(2, mildsc);			
				
				stmt.executeUpdate();
				conn.commit();			

				/* 인터페이스 삭제 주석
				log.error("USER 인터페이스 테이블 DELETE (A=국방부) :	"+mildsc);

				stmt = conn.prepareStatement("DELETE FROM TBL_USER_A_IF_N");
				stmt.executeUpdate();	
				conn.commit();
				*/
				
			}else{
				log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.error(thisDay+"	   USER  인터페이스 테이블 데이터 없음	:	"+mildsc);
			}
			
			log.error("DEPT 인터페이스 테이블 확인 (A=국방부) :	"+mildsc);
			
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_A_IF_N");
			
			rs = stmt.executeQuery();
			rs.next();
			
			if(rs.getInt(1)>0){
				
				log.error("DEPT 테이블 DELETE  (A=국방부) :	"+mildsc);
				
				stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_N WHERE MDCD=?");
				
				stmt.setString(1, mildsc);
				stmt.executeUpdate();	
				
				log.error("DEPT 테이블 INSERT  (A=국방부) :	"+mildsc);
				
				
				stmt = conn.prepareStatement("INSERT INTO TBL_DEPT_N "
						+ " (SELECT SEQ, ?, ?, DEPT_CD, DEPT_NM, "
						+ "  SEQC, DEPT_ABRVWD_NM, WHL_DEPT_NM, HGRNK_DEPT_CD, "
						+ "  TELNO, OPNPBL_YN, DEPT_EXSTNC_EXNEX "
						+ " FROM TBL_DEPT_A_IF_N)");
				
				/* 2022.01.21 : 1515에서 안보사 포함되어야 하기 때문에 주석처리
				stmt = conn.prepareStatement("INSERT INTO TBL_DEPT_N "
						+ " (SELECT SEQ, ?, ?, DEPT_CD, DEPT_NM, "
						+ "  SEQC, DEPT_ABRVWD_NM, WHL_DEPT_NM, HGRNK_DEPT_CD, "
						+ "  TELNO, OPNPBL_YN, DEPT_EXSTNC_EXNEX "
						+ " FROM TBL_DEPT_A_IF_N WHERE DEPT_CD NOT IN (?,?))"); 
				*/
				
				stmt.setString(1, thisDay);
				stmt.setString(2, mildsc);
				
				/* 2022.01.21 : 1515에서 안보사 포함되어야 하기 때문에 주석처리
				// 국방부 국직기관 안보지원사령부 제외
				stmt.setString(3, "9800105");
				// 국방부 기타 800군사안보지원부대 제외
				stmt.setString(4, "999C215");
				*/
				
				stmt.executeUpdate();	
				conn.commit();		

				/* 인터페이스 삭제 주석
				log.error("DEPT 인터페이스 테이블 DELETE (A=국방부) :	"+mildsc);

				stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_A_IF_N");
				stmt.executeUpdate();	
				conn.commit();
				*/
				
			}else{
				log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				log.error(thisDay+"	   DEPT  인터페이스 테이블 데이터 없음	:	"+mildsc);
			}
			
		}catch(Exception e){
			conn.rollback();
			log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.error(thisDay+"	   Exception	:	"+mildsc);
			
			e.printStackTrace();
			log.error(e.getMessage());
		}
	}
	
	public void tableBackup(Connection conn,	
									PreparedStatement stmt,	
									ResultSet rs,
									String thisDay) throws Exception {
		try{
			
			int bTot = 0;
			int bCnt = 0;

			log.error("TBL_USER_BACKUP_N 백업 테이블 삭제 ");
			// TBL_USER_BACKUP_N 전체 데이타 삭제
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_BACKUP_N");
			rs = stmt.executeQuery();
			rs.next();
			bTot = rs.getInt(1);
			bCnt = (bTot/5000)+1;
			
			for(int i=0; i<bCnt; i++ ){
				log.error("TBL_USER_BACKUP_N 테이블 ROW 삭제중... "+ (i+1)*5000 + "/" + bTot);
				stmt = conn.prepareStatement("DELETE FROM TBL_USER_BACKUP_N LIMIT 5000");
				stmt.executeUpdate();	
			}
			//USER 백업 테이블 삭제 종료
			
			log.error("USER 테이블 백업 ");
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_USER_N");
			rs = stmt.executeQuery();
			rs.next();
			bTot = rs.getInt(1);

			for(int i=0; i < bTot; i+=5000) {

				log.error("테이블 ROW 입력중 :	"+ (i+1) + "~" + (i+5000) + "/" + bTot);
				stmt = conn.prepareStatement("INSERT INTO TBL_USER_BACKUP_N SELECT * FROM TBL_USER_N"
											+" WHERE ROWNUM > ? AND ROWNUM < ? ");
				
				stmt.setInt(1, i);
				stmt.setInt(2, i+5001);
				stmt.executeUpdate();
			}
			//USER 테이블 백업 종료
			conn.commit();
			
			log.error("DEPT 백업 테이블 삭제 ");
			
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_BACKUP_N");
			rs = stmt.executeQuery();
			rs.next();
			bTot = rs.getInt(1);
			bCnt = (bTot/5000)+1;

			for(int i=0; i<bCnt; i++ ){
				log.error("테이블 ROW 삭제중... "+ (i+1)*5000 + "/" + bTot);
				stmt = conn.prepareStatement("DELETE FROM TBL_DEPT_BACKUP_N LIMIT 5000");
				stmt.executeUpdate();	
			}
			//DEPT 백업 테이블 삭제 종료
			
			log.error("DEPT 테이블 백업 ");
			stmt = conn.prepareStatement("SELECT COUNT(*) FROM TBL_DEPT_N");
			rs = stmt.executeQuery();
			rs.next();
			bTot = rs.getInt(1);

			for(int i=0; i < bTot; i+=5000) {

				log.error("테이블 ROW 입력중 :	"+ (i+1) + "~" + (i+5000) + "/" + bTot);
				stmt = conn.prepareStatement("INSERT INTO TBL_DEPT_BACKUP_N SELECT * FROM TBL_DEPT_N"
											+" WHERE ROWNUM > ? AND ROWNUM < ? ");
				
				stmt.setInt(1, i);
				stmt.setInt(2, i+5001);
				stmt.executeUpdate();	
			}
			//DEPT 테이블 백업 종료			
			conn.commit();
			
		}catch(Exception e){
			conn.rollback();
			log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.error(thisDay+"	 BACKUP Exception	");
			
			e.printStackTrace();
			log.error(e.getMessage());
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
			
			log.error("상위 부서코드 #으로 초기화  start			: "+ mildsc);
			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N SET HGRNK_DEPT_CD='#' WHERE MDCD=? and dept_cd=?");
			
			stmt.setString(1, mildsc);
			stmt.setString(2, deptCd);
			
			stmt.executeUpdate();	
			
			conn.commit();
			
			log.error("상위 부서코드 #으로 초기화  end			: "+ mildsc);
		}catch(Exception e){
			conn.rollback();
			log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.error("상위 부서코드 #으로 초기화 error");
			
			e.printStackTrace();
			log.error(e.getMessage());
		}

	}
	
	public void hrgnkSettingC(
			Connection conn,	
			PreparedStatement stmt,	
			ResultSet rs, 
			String mildsc,
			String hgrnk_dept_cd) throws Exception{

	try{
			log.error("해군 6000000000 => 6000000001변경  start			: "+ mildsc);
			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N SET hgrnk_dept_cd ='6000000001' WHERE  MDCD=? AND hgrnk_dept_cd = ?");
			stmt.setString(1, mildsc);
			stmt.setString(2, hgrnk_dept_cd);
			
			stmt.executeUpdate();	
	
			stmt = conn.prepareStatement("UPDATE TBL_DEPT_N SET hgrnk_dept_cd = '6000000000' WHERE MDCD=? and dept_cd = '6000000001'");
			stmt.setString(1, mildsc);
			
			stmt.executeUpdate();	
			
			conn.commit();
			
			log.error("해군 6000000000 => 6000000001변경 end			: "+ mildsc);
			
		}catch(Exception e){
			conn.rollback();
			log.error("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			log.error("상위 부서코드 #으로 초기화 error");
			
			e.printStackTrace();
			log.error(e.getMessage());
		}
	
	}

}
