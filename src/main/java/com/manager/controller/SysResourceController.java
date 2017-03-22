package com.manager.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.manager.controller.base.BaseController;
import com.manager.controller.base.ResultInfo;
import com.manager.json.JacksonUtils;
import com.manager.model.admin.SysResource;
import com.manager.service.ISysLogService;
import com.manager.service.ISysResourceService;
import com.server.api.util.DateUtils;


/**
 * 资源控制器
 * @author zhaokaijia
 */
@Controller
@RequestMapping("/sysResource")
public class SysResourceController extends BaseController {
    
    @Autowired
    ISysLogService sysLogService;
    @Autowired
    ISysResourceService sysResourceService;
    
    @RequestMapping("/treeGrid")
    @ResponseBody
    public List<SysResource> treeGrid(Integer resStatuss){
        return sysResourceService.treeGrid(resStatuss);
    }
    
    @RequestMapping("/resParentIdCombotree")
    @ResponseBody
    public List<SysResource> resParentIdCombotree(){
        return sysResourceService.resParentIdCombotree();
    }
    
    @RequestMapping("/create")
    @ResponseBody
    public ResultInfo create(SysResource record) throws Exception{
    	sysResourceService.create(record , session);
    	return this.success();
    }
    
    @RequestMapping("/edit")
    @ResponseBody
    public ResultInfo edit(SysResource record) throws Exception{
    	sysResourceService.edit(record , session);
    	return this.success();
    }
    
    @RequestMapping("/delete")
    @ResponseBody
    public ResultInfo delete(Long resId) throws Exception{
    	sysResourceService.delete(resId , session);
    	return this.success();
    }
    
    @RequestMapping("/exportMenu")
    public String exportMenu(){
        List<SysResource> list = sysResourceService.exportMenu();
        this.downloadFile(response, JacksonUtils.jsonObjectSerializer(list), DateUtils.toString(new Date(), "yyyyMMddHHmmss")+".menu");
        return null;
    }
    
    @RequestMapping("/importMenu")
    @ResponseBody
    public String importMenu(MultipartFile importMenuFile) throws Exception{
        this.isSuperAdmin();
	    sysResourceService.importMenu(importMenuFile , session);
	    return JacksonUtils.jsonObjectSerializer(this.success());
    }
    
}

