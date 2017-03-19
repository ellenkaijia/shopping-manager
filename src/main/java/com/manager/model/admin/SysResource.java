package com.manager.model.admin;

import java.io.Serializable;
import java.util.List;

public class SysResource implements Serializable {
	
    private Long resId;
    private Integer resType;
    private String resName;
    private Long resParentId;
    private String resIcon;
    private String resUrl;
    private Integer resSeq;
    private Integer resStatus;
    private String attributes;
    private List<SysResource> childList;
    private static final long serialVersionUID = 1L;

    public Long getResId() {
        return resId;
    }

    public void setResId(Long resId) {
        this.resId = resId;
    }

    public List<SysResource> getChildList() {
        return childList;
    }

    public void setChildList(List<SysResource> childList) {
        this.childList = childList;
    }

    public Integer getResType() {
        return resType;
    }

    public void setResType(Integer resType) {
        this.resType = resType;
    }

    public String getResName() {
        return resName;
    }

    public void setResName(String resName) {
        this.resName = resName == null ? null : resName.trim();
    }

    public Long getResParentId() {
        return resParentId;
    }

    public void setResParentId(Long resParentId) {
        this.resParentId = resParentId;
    }

    public String getResIcon() {
        return resIcon;
    }

    public void setResIcon(String resIcon) {
        this.resIcon = resIcon == null ? null : resIcon.trim();
    }

    public String getResUrl() {
        return resUrl;
    }

    public void setResUrl(String resUrl) {
        this.resUrl = resUrl == null ? null : resUrl.trim();
    }

    public Integer getResSeq() {
        return resSeq;
    }

    public void setResSeq(Integer resSeq) {
        this.resSeq = resSeq;
    }

    public Integer getResStatus() {
        return resStatus;
    }

    public void setResStatus(Integer resStatus) {
        this.resStatus = resStatus;
    }

	public String getAttributes() {
		return attributes;
	}

	public void setAttributes(String attributes) {
		this.attributes = attributes;
	}

	@Override
	public boolean equals(Object obj) {
		if(obj==null || !(obj instanceof SysResource)){
			return false;
		}
		SysResource other = (SysResource)obj;
		if(this == other){
			return true;
		}
		if(this.getResId()==null || other.getResId()==null){
			return false;
		}
		if(this.getResId().equals(other.getResId())){
			return true;
		}
		return false;
	}

	@Override
	public int hashCode() {
		return super.hashCode();
	}
	
	
}