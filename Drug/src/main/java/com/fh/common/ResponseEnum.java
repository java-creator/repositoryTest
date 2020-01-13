package com.fh.common;

public enum ResponseEnum {
    SUCCESS(200,"操作成功"),
    ERROR(1000,"操作失败")
    ;
    private Integer status;
    private String mag;

    ResponseEnum(int code, String msg) {
        this.status = code;
        this.mag = msg;
    }

    public Integer getStatus() {
        return status;
    }

    public String getMag() {
        return mag;
    }
}
