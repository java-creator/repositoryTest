package com.fh.service;


import com.fh.common.ServerResponse;
import com.fh.mapper.AreaMapper;
import com.fh.mapper.BrandMapper;
import com.fh.mapper.DrugMapper;
import com.fh.model.Area;
import com.fh.model.Brand;
import com.fh.model.Drug;
import com.fh.model.DrugQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DrugServiceImpl implements DrugService {
    @Autowired
    private DrugMapper drugMapper;
    @Autowired
    private AreaMapper areaMapper;
    @Autowired
    private BrandMapper brandMapper;
    @Override
    public ServerResponse queryList(DrugQuery drugQuery) {
        Map map = new HashMap();
        List list =  drugMapper.queryList(drugQuery);
        Integer total = drugMapper.selectCount(null);
        map.put("draw",drugQuery.getDraw());
        map.put("recordsTotal",total);
        map.put("recordsFiltered",total);
        map.put("data",list);
        return ServerResponse.success(map);
    }

    @Override
    public ServerResponse addDrug(Drug drug) {
        drugMapper.insert(drug);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse getIdByDrug(Integer id) {
        Drug drug = drugMapper.selectById(id);
        return ServerResponse.success(drug);
    }

    @Override
    public ServerResponse updateDrug(Drug drug) {
        drugMapper.updateById(drug);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse deleteDrug(Integer id) {
        drugMapper.deleteById(id);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse queryAreaList() {
        List<Area> areaList = areaMapper.selectList(null);
        return ServerResponse.success(areaList);
    }

    @Override
    public ServerResponse queryBrandList() {
        List<Brand> brandList = brandMapper.selectList(null);
        return ServerResponse.success(brandList);
    }

    @Override
    public void batchDelete(List list) {
        drugMapper.batchDelete(list);
    }
}
