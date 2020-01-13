package com.fh.mapper;

import com.fh.model.*;

import java.util.List;

public interface DrugMapper {
    //查询总条数
    Long queryDrugCount(DrugQuery drugQuery);
    //查询
    List<Drug> queryDrugList(DrugQuery drugQuery);

    //查询地区
    List<Area> queryAreaList();
   //查询品牌
    List<Brand> queryBrandList();
    //添加
    void addDrug(Drug drug);
    //获取单个id
    Drug getDrugById(Integer id);
    //删除
    void deleteDrug(Integer id);
   //修改
    void updateDrug(Drug drug);

    //查询idlist
    List<Drug> queryDrugListByIds(List<Integer> idList);
    //批量删
    void batchDeleteDrug(List<Integer> idList);
}
