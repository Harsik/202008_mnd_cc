package com.sfr.admin.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {
    
    public boolean fileUpload(MultipartFile mFile, String fPath, String fName, long fSize) throws Exception;
    
    
    
}
    