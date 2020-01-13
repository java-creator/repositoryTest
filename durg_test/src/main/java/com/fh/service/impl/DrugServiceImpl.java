package com.fh.service.impl;

import com.fh.mapper.DrugMapper;

import com.fh.model.*;
import com.fh.service.DrugService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;


@Service
public class DrugServiceImpl implements DrugService {
@Autowired
    private DrugMapper drugMapper;

   //查询
    @Override
    public DataTableResult queryDrugList(DrugQuery drugQuery) {
    //条件查询 适合人群
        if(StringUtils.isNotBlank(drugQuery.getPerson())){
            drugQuery.setPersonList(Arrays.asList(drugQuery.getPerson().split(",")));
        }
       //查询总条数
        Long count =  drugMapper.queryDrugCount(drugQuery);
     //查询当前页数
       List<Drug> drugList = drugMapper.queryDrugList(drugQuery);
       DataTableResult dataTableResult = new DataTableResult(drugQuery.getDraw(), count, count, drugList);
        return dataTableResult;
    }
    //地区
    @Override
    public List<Area> queryAreaList() {
        return drugMapper.queryAreaList() ;
    }
   //品牌
    @Override
    public List<Brand> queryBrandList() {
        return drugMapper.queryBrandList() ;
    }
    //添加
    @Override
    public void addDrug(Drug drug) {
        drug.setCreateDate(new Date());
        drugMapper.addDrug(drug);
    }
    //获取单个id
    @Override
    public Drug getDrugById(Integer id) {
        return drugMapper.getDrugById(id);
    }
    //删除
    @Override
    public void deleteDrug(Integer id) {
        drugMapper.deleteDrug(id);
    }

    @Override
    public void updateDrug(Drug drug) {
        drug.setUpdateDate(new Date());
        drugMapper.updateDrug(drug);
    }
    //查询idList
    @Override
    public List<Drug> queryDrugListByIds(List<Integer> idList) {

        return drugMapper.queryDrugListByIds(idList);
    }
    //批量删
    @Override
    public void batchDeleteDrug(List<Integer> idList) {
        drugMapper.batchDeleteDrug(idList);
    }
}
