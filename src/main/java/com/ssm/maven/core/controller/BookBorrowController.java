package com.ssm.maven.core.controller;

import com.ssm.maven.core.entity.BookBorrowRecord;
import com.ssm.maven.core.service.BookBorrowService;
import com.ssm.maven.core.util.ResponseUtil;
import com.ssm.maven.core.util.TimestampUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bookborrow")
public class BookBorrowController {
    @Resource
    private BookBorrowService bookBorrowService;
    private static final Logger log = Logger.getLogger(BookBorrowController.class); //日志文件

    @RequestMapping("/borrow")
    public String borrow(@RequestParam(value = "ids") String ids, @RequestParam(value = "user_id") Integer user_id, HttpServletResponse response) throws Exception {
        JSONObject result = new JSONObject();
        String[] idsStr = ids.split(",");
        for(int i=0; i<idsStr.length; i++) {
            BookBorrowRecord bookBorrowRecord = new BookBorrowRecord(Integer.parseInt(idsStr[i]), user_id, new Timestamp(System.currentTimeMillis()),
                    BookBorrowRecord.akl1, 0, BigDecimal.ZERO, 0);
            Map<String, Object> map = new HashMap<>();
            map.put("id", Integer.parseInt(idsStr[i]));
            map.put("status", 1);
            try {
                bookBorrowService.borrowBook(bookBorrowRecord);
                bookBorrowService.changeBookStatus(map);
            } catch(Exception e) {
                e.printStackTrace();
            }
        }
        result.put("success", true);
        log.info("request: user/borrow , ids: " + ids);
        ResponseUtil.write(response, result);
        return null;
    }

    @RequestMapping("/returnBook")
    public String returnBook(@RequestParam(value = "ids") String ids, HttpServletResponse response) throws Exception {
        JSONObject result = new JSONObject();
        String[] idsStr = ids.split(",");
        for(int i=0; i<idsStr.length; i++) {
            BookBorrowRecord previous = bookBorrowService.findRecord(Integer.parseInt(idsStr[i]));
            Timestamp borrow_time = previous.getBRTime();
            Integer akl = previous.getAllowedKeepLength();
            BigDecimal arrearage = BigDecimal.valueOf(0);
            Long keepDays = TimestampUtil.countKeepDays(borrow_time, new Timestamp(System.currentTimeMillis()), akl);
            if(keepDays > akl) {
                arrearage = BigDecimal.valueOf(BookBorrowRecord.feePerDay * (keepDays - akl));
            }
            Map<String, Object> map = new HashMap<>();
            map.put("id", Integer.parseInt(idsStr[i]));
            map.put("br_time", new Timestamp(System.currentTimeMillis()));
            map.put("is_done", 1);
            map.put("arrearage", arrearage);
            bookBorrowService.returnBook(map);
        }
        result.put("success", true);
        log.info("request: user/return , ids: " + ids);
        ResponseUtil.write(response, result);
        return null;
    }

    @RequestMapping("/renewBook")
    public String renewBook(@RequestParam(value = "id") String id, HttpServletResponse response) throws Exception {
        JSONObject result = new JSONObject();
        BookBorrowRecord renewBefore = null;
        try {
            renewBefore = bookBorrowService.findRecord(Integer.parseInt(id));
        } catch(Exception e) {
            e.printStackTrace();
        }
        if(renewBefore != null && renewBefore.getRenewTimes() == 0) {
            try {
                Map<String, Object> map = new HashMap<>();
                map.put("id", Integer.parseInt(id));
                map.put("allowed_keep_length", BookBorrowRecord.akl2);
                map.put("renew_times", 1);
                bookBorrowService.renewBook(map);
            } catch(Exception e) {
                e.printStackTrace();
            }
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        log.info("request: user/renew , id: " + id);
        ResponseUtil.write(response, result);
        return null;
    }

    @RequestMapping("/listRecordsByUserID")
    public String listRecordsByUserID(@RequestParam(value = "user_id")String user_id, HttpServletResponse response) throws Exception {
        JSONObject result = new JSONObject();
        List<BookBorrowRecord> recordList = null;
        Long total = 0L;
        try {
            recordList = bookBorrowService.findRecordsByUserID(Integer.parseInt(user_id));
            total = bookBorrowService.getTotalRecordsByUserID(Integer.parseInt(user_id));
        } catch(Exception e) {
            e.printStackTrace();
        }
        JSONArray jsonArray = JSONArray.fromObject(recordList);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        log.info("request: records/listRecordsByUserID, user_id: " + user_id);
        return null;
    }
}
