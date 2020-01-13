package com.fh.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;
//条件查询实体类需继承分页
public class DrugQuery extends DataTablePageBean{

    private String name;

    private Double minPrice;

    private Double  maxPrice;

    private Integer minSales;

    private Integer maxSales;

    private Integer areaId;

    private Integer minStock;

    private Integer maxStock;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date minExpiredDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date maxExpiredDate;

    private Integer brandId;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date minProducedDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date maxProducedDate;

    private String person;
    //条件查询因为是复选 是list
    //所以应该再创键一个集合
    private List<String> personList;

    private Integer isOTC;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Double minPrice) {
        this.minPrice = minPrice;
    }

    public Double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Integer getMinSales() {
        return minSales;
    }

    public void setMinSales(Integer minSales) {
        this.minSales = minSales;
    }

    public Integer getMaxSales() {
        return maxSales;
    }

    public void setMaxSales(Integer maxSales) {
        this.maxSales = maxSales;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public Integer getMinStock() {
        return minStock;
    }

    public void setMinStock(Integer minStock) {
        this.minStock = minStock;
    }

    public Integer getMaxStock() {
        return maxStock;
    }

    public void setMaxStock(Integer maxStock) {
        this.maxStock = maxStock;
    }

    public Date getMinExpiredDate() {
        return minExpiredDate;
    }

    public void setMinExpiredDate(Date minExpiredDate) {
        this.minExpiredDate = minExpiredDate;
    }

    public Date getMaxExpiredDate() {
        return maxExpiredDate;
    }

    public void setMaxExpiredDate(Date maxExpiredDate) {
        this.maxExpiredDate = maxExpiredDate;
    }

    public Integer getBrandId() {
        return brandId;
    }

    public void setBrandId(Integer brandId) {
        this.brandId = brandId;
    }

    public Date getMinProducedDate() {
        return minProducedDate;
    }

    public void setMinProducedDate(Date minProducedDate) {
        this.minProducedDate = minProducedDate;
    }

    public Date getMaxProducedDate() {
        return maxProducedDate;
    }

    public void setMaxProducedDate(Date maxProducedDate) {
        this.maxProducedDate = maxProducedDate;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public Integer getIsOTC() {
        return isOTC;
    }

    public void setIsOTC(Integer isOTC) {
        this.isOTC = isOTC;
    }

    public List<String> getPersonList() {
        return personList;
    }

    public void setPersonList(List<String> personList) {
        this.personList = personList;
    }
}
