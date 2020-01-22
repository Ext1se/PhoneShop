package com.tpu.shop.utils;

import com.tpu.shop.data.*;

import java.io.Serializable;
import java.util.List;

public class Filter implements Serializable {

    private List<Company> companies;
    private List<Os> oss;
    private List<Camera> cameras;
    private List<Resolution> resolutions;
    private List<Display> displays;
    private List<DisplayType> displayTypes;
    private List<Cpu> cpunits;
    private List<Material> materials;
    private List<Color> colors;
    private Integer ramFrom;
    private Integer ramTo;
    private Integer storageFrom;
    private Integer storageTo;
    private Integer costFrom;
    private Integer costTo;

    public Filter() {

    }

    public List<Company> getCompanies() {
        return companies;
    }

    public void setCompanies(List<Company> companies) {
        this.companies = companies;
    }

    public List<Os> getOss() {
        return oss;
    }

    public void setOss(List<Os> oss) {
        this.oss = oss;
    }

    public List<Camera> getCameras() {
        return cameras;
    }

    public void setCameras(List<Camera> cameras) {
        this.cameras = cameras;
    }

    public List<Resolution> getResolutions() {
        return resolutions;
    }

    public void setResolutions(List<Resolution> resolutions) {
        this.resolutions = resolutions;
    }

    public List<Display> getDisplays() {
        return displays;
    }

    public void setDisplays(List<Display> displays) {
        this.displays = displays;
    }

    public List<DisplayType> getDisplayTypes() {
        return displayTypes;
    }

    public void setDisplayTypes(List<DisplayType> displayTypes) {
        this.displayTypes = displayTypes;
    }

    public List<Cpu> getCpunits() {
        return cpunits;
    }

    public void setCpunits(List<Cpu> cpunits) {
        this.cpunits = cpunits;
    }

    public List<Color> getColors() {
        return colors;
    }

    public void setColors(List<Color> colors) {
        this.colors = colors;
    }

    public Integer getRamFrom() {
        return ramFrom;
    }

    public void setRamFrom(Integer ramFrom) {
        this.ramFrom = ramFrom;
    }

    public Integer getRamTo() {
        return ramTo;
    }

    public void setRamTo(Integer ramTo) {
        this.ramTo = ramTo;
    }

    public Integer getStorageFrom() {
        return storageFrom;
    }

    public void setStorageFrom(Integer storageFrom) {
        this.storageFrom = storageFrom;
    }

    public Integer getStorageTo() {
        return storageTo;
    }

    public void setStorageTo(Integer storageTo) {
        this.storageTo = storageTo;
    }

    public Integer getCostFrom() {
        return costFrom;
    }

    public void setCostFrom(Integer costFrom) {
        this.costFrom = costFrom;
    }

    public Integer getCostTo() {
        return costTo;
    }

    public void setCostTo(Integer costTo) {
        this.costTo = costTo;
    }

    public List<Material> getMaterials() {
        return materials;
    }

    public void setMaterials(List<Material> materials) {
        this.materials = materials;
    }
}
