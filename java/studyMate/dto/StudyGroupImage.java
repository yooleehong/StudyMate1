package studyMate.dto;

import java.util.Date;

public class StudyGroupImage {
   int idx;
   int studyGroupIdx;
   String studyGroupName;
   String fileName;
   byte[] data;
   Date fileTime;
   String route;
   long fileSize;
   
   public int getIdx() {
      return idx;
   }
   public void setIdx(int idx) {
      this.idx = idx;
   }
   public int getStudyGroupIdx() {
      return studyGroupIdx;
   }
   public void setStudyGroupIdx(int studyGroupIdx) {
      this.studyGroupIdx = studyGroupIdx;
   }
   public String getStudyGroupName() {
      return studyGroupName;
   }
   public void setStudyGroupName(String studyGroupName) {
      this.studyGroupName = studyGroupName;
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