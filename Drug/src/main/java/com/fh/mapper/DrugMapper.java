package com.fh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.model.*;

import java.util.List;

public interface DrugMapper extends BaseMapper<Drug> {

    List queryList(DrugQuery drugQuery);

    void batchDelete(List list);
}
