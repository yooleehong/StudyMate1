package studyMate.util;

import java.util.ArrayList;
import java.util.List;

public class PageUtil {
    
    public static List<Page> getPageList(int currentPage, int pageSize, int recordCount) {
        ArrayList<Page> list = new ArrayList<Page>();
        int pageCount = (recordCount + pageSize - 1) / pageSize; 
        int basePage = ((currentPage - 1) / 10) * 10; 
        if (basePage > 0) 
            list.add(new Page(basePage, "Prev", false));
        for (int i=1; i <= 10 && basePage + i <= pageCount; ++i) {
            int n = basePage + i;
            list.add(new Page(n, String.valueOf(n), n == currentPage));
        }
        if (basePage + 11 <= pageCount) 
            list.add(new Page(basePage + 11, "Next", false));
        return list;
    }

}
