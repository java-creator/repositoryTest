package com.fh.controller;

import com.fh.common.ServerResponse;
import com.fh.model.Drug;
import com.fh.model.DrugQuery;
import com.fh.service.DrugService;
import com.fh.util.AliyunOssUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("drug")
@CrossOrigin
public class DrugController {
 @Autowired
 private DrugService drugService;

    //查询
    @RequestMapping("queryList")
    public ServerResponse queryList(DrugQuery drugQuery){
        return drugService.queryList(drugQuery);
    }
    //添加
    @RequestMapping("addDrug")
    public ServerResponse addDrug(Drug drug){
        return drugService.addDrug(drug);
    }
    //回显
    @RequestMapping("getIdByDrug")
    public ServerResponse getIdByDrug(Integer id){
        return drugService.getIdByDrug(id);
    }
    //修改
    @RequestMapping("updateDrug")
    public ServerResponse updateDrug(Drug drug){
        return drugService.updateDrug(drug);
    }
    //删除
    @RequestMapping("deleteDrug")
    public ServerResponse deleteDrug(Integer id){
        return drugService.deleteDrug(id);
    }
    //地区类型
    @RequestMapping("queryAreaList")
    public ServerResponse queryAreaList(){
        return drugService.queryAreaList();
    }
    //品牌类型
    @RequestMapping("queryBrandList")
    public ServerResponse queryBrandList(){
        return drugService.queryBrandList();
    }
    //批量删
    @RequestMapping("batchDelete")
    public ServerResponse batchDelete(@RequestParam("idList[]") List list) {
        drugService.batchDelete(list);
        return ServerResponse.success();
    }

    //上传用户图片

    @RequestMapping("uploadFile")
    public Map<String,Object> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        try {
            String originalFileName = file.getOriginalFilename();
            String url = AliyunOssUtil.uploadFile(file.getInputStream(), originalFileName, "images");
            result.put("filePath",url);
            result.put("code",200);
        } catch (IOException e) {
            e.printStackTrace();
            result.put("code",500);
        }
        return result;
    }

}
