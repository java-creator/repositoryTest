package com.fh.common;

public class ServerResponse {
    private Integer status;
    private String msg;
    private Object data;

    public static ServerResponse success(){
        return new ServerResponse(ResponseEnum.SUCCESS.getStatus(),ResponseEnum.SUCCESS.getMag());
    }

    public static ServerResponse error(){
        return new ServerResponse(ResponseEnum.ERROR.getStatus(),ResponseEnum.ERROR.getMag());
    }

    public static ServerResponse success(Object data){
        return new ServerResponse(ResponseEnum.SUCCESS.getStatus(),ResponseEnum.SUCCESS.getMag(),data);
    }

    public ServerResponse(Integer status, String msg, Object data) {
        this.status = status;
        this.msg = msg;
        this.data = data;
    }

    public ServerResponse(Integer status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    public ServerResponse() {

    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
