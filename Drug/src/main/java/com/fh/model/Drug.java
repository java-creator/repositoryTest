package com.fh.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Drug {

    private Integer id;//药品id

    private String drugName;//药品名称

    private Double drugPrice;//价格

    private Integer drugSales;//销量

    private Integer drugStock;//库存

    private Integer isOTC;//是否处方药 1是非处方药 2是处方药

    private String person;//适合人群(1幼儿 2少年 3青年 4中年 5老年 6孕妇)

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date producedDate;//生产日期

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expiredDate;//过期日期

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;//创建时间

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateDate;//修改时间

    private Integer areaId;//产地id

    private Integer brandId;//品牌id

    private String filePath; //药品图片相对路径

    private String areaName; //产地名称

    private String brandName; //品牌名称

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDrugName() {
        return drugName;
    }

    public void setDrugName(String drugName) {
        this.drugName = drugName;
    }

    public Double getDrugPrice() {
        return drugPrice;
    }

    public void setDrugPrice(Double drugPrice) {
        this.drugPrice = drugPrice;
    }

    public Integer getDrugSales() {
        return drugSales;
    }

    public void setDrugSales(Integer drugSales) {
        this.drugSales = drugSales;
    }

    public Integer getDrugStock() {
        return drugStock;
    }

    public void setDrugStock(Integer drugStock) {
        this.drugStock = drugStock;
    }

    public Integer getIsOTC() {
        return isOTC;
    }

    public void setIsOTC(Integer isOTC) {
        this.isOTC = isOTC;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public Date getProducedDate() {
        return producedDate;
    }

    public void setProducedDate(Date producedDate) {
        this.producedDate = producedDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
}
