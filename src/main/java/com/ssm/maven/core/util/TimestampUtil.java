package com.ssm.maven.core.util;

import java.sql.Timestamp;

public class TimestampUtil {
    public static Long countKeepDays(Timestamp t1, Timestamp t2, int akl) {
        Long diff = t2.getTime() - t1.getTime();
        return diff / (24*60*60*1000);
    }
}
