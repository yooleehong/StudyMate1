package studyMate.dto;

import java.util.Date;

public class Image {
	int idx;
	int userIdx;
	String originalfileName;
	String fileName;
	String route;
	long fileSize;
	Date fileTime;
	byte[] data;
	public String getRoute() {
		return route;
	}




	public void setRoute(String route) {
		this.route = route;
	}


	
	public int getIdx() {
		return idx;
	}




	public void setIdx(int idx) {
		this.idx = idx;
	}




	public int getUserIdx() {
		return userIdx;
	}




	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}




	public String getOriginalfileName() {
		return originalfileName;
	}




	public void setOriginalfileName(String originalfileName) {
		this.originalfileName = originalfileName;
	}




	public String getFileName() {
		return fileName;
	}




	public void setFileName(String fileName) {
		this.fileName = fileName;
	}




	public long getFileSize() {
		return fileSize;
	}




	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}




	public Date getFileTime() {
		return fileTime;
	}




	public void setFileTime(Date fileTime) {
		this.fileTime = fileTime;
	}




	public byte[] getData() {
		return data;
	}




	public void setData(byte[] data) {
		this.data = data;
	}


  
	public String getMimeType() {
        int index = fileName.lastIndexOf('.');
        if (index > 0) {
            String extension = fileName.substring(index + 1).toLowerCase();
            switch (extension) {
            case "png":
            case "bmp":
            case "gif":
                return "image/" + extension;
            }
        }
        return "image/jpeg";
    }
}
