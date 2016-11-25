package studyMate.dto;

import java.util.Date;

public class StreamImage {
   int idx;
   int streamIdx;
   int studyGroupIdx;
   String streamTitle;
   String fileName;
   byte[] data;
   Date fileTime;
   String route;
   long fileSize;
   int streamUserIdx;
   String streamUserName; //[10월19일추가]이름조회
   
public String getStreamUserName() {
	return streamUserName;
}
public void setStreamUserName(String streamUserName) {
	this.streamUserName = streamUserName;
}
public int getStreamUserIdx() {
	return streamUserIdx;
}
public void setStreamUserIdx(int streamUserIdx) {
	this.streamUserIdx = streamUserIdx;
}
public int getStudyGroupIdx() {
	return studyGroupIdx;
}
public void setStudyGroupIdx(int studyGroupIdx) {
	this.studyGroupIdx = studyGroupIdx;
}
public int getIdx() {
	return idx;
}
public void setIdx(int idx) {
	this.idx = idx;
}
public int getStreamIdx() {
	return streamIdx;
}
public void setStreamIdx(int streamIdx) {
	this.streamIdx = streamIdx;
}
public String getStreamTitle() {
	return streamTitle;
}
public void setStreamTitle(String streamTitle) {
	this.streamTitle = streamTitle;
}
public String getFileName() {
	return fileName;
}
public void setFileName(String fileName) {
	this.fileName = fileName;
}
public byte[] getData() {
	return data;
}
public void setData(byte[] data) {
	this.data = data;
}
public Date getFileTime() {
	return fileTime;
}
public void setFileTime(Date fileTime) {
	this.fileTime = fileTime;
}
public String getRoute() {
	return route;
}
public void setRoute(String route) {
	this.route = route;
}
public long getFileSize() {
	return fileSize;
}
public void setFileSize(long fileSize) {
	this.fileSize = fileSize;
}
  
}