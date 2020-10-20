package com.sfr.operator.service.impl;

import com.sfr.common.CommandMap;
import com.sfr.operator.dao.LoginDao;
import com.sfr.operator.service.LoginService;
import com.sfr.operator.service.impl.LoginServiceImpl;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;















public class LoginServiceImpl
  extends EgovAbstractServiceImpl
  implements LoginService
{
  private LoginDao loginDao;
  
  public EgovMap selectUserInfo(CommandMap commandMap) throws Exception { return this.loginDao.selectUserInfo(commandMap); }
}


/* Location:              D:\App\ServerSource\data\src\sfr_prj.war\!\LoginServiceImpl.class
 * Java compiler version: 7 (51.0)
 * JD-Core Version:       1.0.2
 */