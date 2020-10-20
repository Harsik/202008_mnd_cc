package com.sfr.common;

import java.net.URLEncoder;
import java.io.*; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {



 	public FileDownloadView() {
        setContentType("applicaiton/download;charset=utf-8");
    }

    private void setDownloadFileName(String fileName, HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        String userAgent = request.getHeader("User-Agent");

        boolean isIe = userAgent.indexOf("MSIE") != -1;

        if(isIe){
            fileName = URLEncoder.encode(fileName, "utf-8");
        } else {
            fileName = new String(fileName.getBytes("utf-8"));
        }

        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
    }

    private void downloadFile(File downloadFile, HttpServletRequest request, HttpServletResponse response) throws java.sql.SQLException, Exception  {
        OutputStream out = response.getOutputStream();
        FileInputStream in = new FileInputStream(downloadFile);

        try {
            FileCopyUtils.copy(in, out);
            out.flush();
        } catch (Exception e) {
            throw e;
        } finally {
            try { if (in != null) in.close(); } catch (IOException ioe) { throw ioe;}
            try { if (out != null) out.close(); } catch (IOException ioe) {throw ioe;}
        }
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws java.sql.SQLException, Exception  {
        try {
            this.setResponseContentType(request, response);

            File downloadFile = (File) model.get("downloadFile");
            String fileName = (String)model.get("fileName");
            
            
            if (logger.isDebugEnabled()) {
                logger.debug("downloadFile: " + downloadFile);
            }

            this.setDownloadFileName(fileName, request, response);

            response.setContentLength((int) downloadFile.length());
            this.downloadFile(downloadFile, request, response);
        } catch (IOException ie) {
        	throw ie;
        } catch (Exception e) {
            throw e;
        }
    }
 
		
}
