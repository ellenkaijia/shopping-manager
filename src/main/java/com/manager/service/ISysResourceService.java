package com.manager.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.manager.model.admin.SysResource;

public interface ISysResourceService {

	List<SysResource> treeGrid(Integer resStatus);

	List<SysResource> resParentIdCombotree();

	void create(SysResource record, HttpSession session) throws Exception;

	void edit(SysResource record, HttpSession session) throws Exception;

	void delete(Long resId, HttpSession session) throws Exception;

	List<SysResource> exportMenu();

	void importMenu(MultipartFile importMenuFile, HttpSession session) throws Exception;

}
