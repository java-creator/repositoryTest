package com.fh.service;

import com.fh.common.ServerResponse;
import com.fh.model.Drug;
import com.fh.model.DrugQuery;

import java.util.List;

public interface DrugService {
    ServerResponse queryList(DrugQuery drugQuery);

    ServerResponse addDrug(Drug drug);

    ServerResponse getIdByDrug(Integer id);

    ServerResponse updateDrug(Drug drug);

    ServerResponse deleteDrug(Integer id);

    ServerResponse queryAreaList();

    ServerResponse queryBrandList();

    void batchDelete(List list);
}
