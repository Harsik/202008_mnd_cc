package com.sfr.admin.service.impl;


import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sfr.admin.service.FileService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("fileService")
public class FileServiceImpl extends EgovAbstractServiceImpl implements FileService
{
    /**
     * 개 요 : 파일 업로드 ( 사용자 관리 이미지 등 )
     */
    @SuppressWarnings("finally")
    public boolean fileUpload(MultipartFile mFile, String fPath, String fName, long fSize) throws Exception
    {
        //String fileName = mFile.getName();
        //String originalFileName = mFile.getOriginalFilename();
        //String contentType = mFile.getContentType();
        long fileSize = mFile.getSize();

        if(mFile == null || mFile.getSize() <= 0)
            return false;
        else if(fileSize <= 0 || fileSize > fSize)
            return false;

        InputStream inputStream = null;
        OutputStream outputStream = null;

        try
        {
            if(fileSize > 0)
            {
                inputStream = mFile.getInputStream();
                File realUploadDir = new File(fPath);

                if(!realUploadDir.exists())
                    realUploadDir.mkdirs();

                String organizedFilePath = realUploadDir + "/" + fName;
                outputStream = new FileOutputStream(organizedFilePath);

                int readBytes = 0;
                byte[] buffer = new byte[8192];

                while((readBytes = inputStream.read(buffer, 0, 8192)) != -1)
                    outputStream.write(buffer, 0, readBytes);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            if(outputStream != null)
            {
                try
                {
                    outputStream.close();
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            }
            else if(inputStream != null)
            {
                try
                {
                    inputStream.close();
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            }

            return true;
        }
    }


    
}
