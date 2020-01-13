package com.fh.controller;

import com.fh.model.*;
import com.fh.service.DrugService;
import com.fh.util.FileUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("drug")
public class DrugController {
 @Autowired
 private DrugService drugService;
//明天在哪
    //上传药品图片
    @RequestMapping("uploadFile")
    @ResponseBody
    public Map<String,Object> uploadFile(@RequestParam("file") MultipartFile file, HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        try {
            String filePath = FileUtil.uploadFile(request,file,"/zhangxuhao");
            result.put("filePath",filePath);
            result.put("code",200);
        } catch (IOException e) {
            e.printStackTrace();
            result.put("code",500);
        }
        return result;
    }



 //跳转查询页面
  @RequestMapping("toDrugList")
  public String  toDrugList(){
      return "drug/list";
  }
  //带分页的查询
    @RequestMapping("queryDrugList")
    @ResponseBody                       //条件类
  public DataTableResult queryDrugList(DrugQuery drugQuery){
        DataTableResult dataTableResult  = drugService.queryDrugList(drugQuery);
        return dataTableResult;
    }
//查询地区
  @RequestMapping("queryAreaList")
  @ResponseBody
  public Map<String,Object> queryAreaList(){
      Map<String,Object> result = new HashMap<>();
      try {
          List<Area> areaList = drugService.queryAreaList();
          result.put("data",areaList);
          result.put("code",200);
      } catch (Exception e) {
          e.printStackTrace();
          result.put("code",500);
      }
      return result;
  }
//查询品牌
@RequestMapping("queryBrandList")
@ResponseBody
public Map<String,Object> queryBrandList(){
    Map<String,Object> result = new HashMap<>();
    try {
        List<Brand> brandList = drugService.queryBrandList();
        result.put("data",brandList);
        result.put("code",200);
    } catch (Exception e) {
        e.printStackTrace();
        result.put("code",500);
    }
    return result;
}
    //新增药品
    @RequestMapping("addDrug")
    @ResponseBody                   //实体类
    public Map<String,Object> addDrug(Drug drug){
        //map
        Map<String,Object> result = new HashMap<>();
        try {
            //方法
            drugService.addDrug(drug);
            //成功200
            result.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
            //失败500
            result.put("code",500);
        }
        return result;
    }
    //删除
    @RequestMapping("deleteDrug")
    @ResponseBody
    public Map<String,Object> deleteDrug(Integer id,HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        try {
            //如果该药品之前上传过图片，则把图片删除掉
            Drug oldDrug = drugService.getDrugById(id);
            if(StringUtils.isNotBlank(oldDrug.getFilePath())){
                FileUtil.deleteFile(request,oldDrug.getFilePath());
            }
            drugService.deleteDrug(id);
            result.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code",500);
        }
        return result;
    }
    //获取单个id
    @RequestMapping("getDrugById")
    @ResponseBody
    public Map<String,Object> getDrugById(Integer id,HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        try {
            Drug drug = drugService.getDrugById(id);
            result.put("data",drug);
            result.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code",500);
        }
        return result;
    }
    //修改药品
    @RequestMapping("updateDrug")
    @ResponseBody
    public Map<String,Object> updateDrug(Drug drug){
        Map<String,Object> result = new HashMap<>();
        try {
            drugService.updateDrug(drug);
            result.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code",500);
        }
        return result;
    }


    @RequestMapping("batchDeleteDrug")
    @ResponseBody
    public Map<String,Object> batchDeleteDrug(@RequestParam("ids[]")List<Integer> idList,HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        try {
//            //如果该药品之前上传过图片，则把图片删除掉
//            Drug oldDrug = drugService.getDrugById(id);
//            if(StringUtils.isNotBlank(oldDrug.getFilePath())){
//                FileUtil.deleteFile(request,oldDrug.getFilePath());
//            }
//            drugService.deleteDrug(id);
            List<Drug> drugList = drugService.queryDrugListByIds(idList);
            for(Drug drug : drugList){
                if(StringUtils.isNotBlank(drug.getFilePath())){
                    FileUtil.deleteFile(request,drug.getFilePath());
                }
            }
            drugService.batchDeleteDrug(idList);
            result.put("code",200);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("code",500);
        }
        return result;
    }


}
