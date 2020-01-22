package com.tpu.shop.controllers.rest;

import com.fasterxml.jackson.annotation.JsonView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tpu.shop.data.*;
import com.tpu.shop.repository.ModelColorRepository;
import com.tpu.shop.repository.ModelPhotoRepository;
import com.tpu.shop.repository.ModelRepository;
import com.tpu.shop.repository.SmartPhoneRepository;
import com.tpu.shop.utils.Filter;
import com.tpu.shop.utils.RestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.plugin2.message.Message;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;


@RestController
@RequestMapping("/api")
public class ModelRestController {

    @Value("${upload.path.img.phone}")
    private String uploadPath;

    @Autowired
    private ModelRepository modelRepository;
    @Autowired
    private ModelColorRepository modelColorRepository;
    @Autowired
    private ModelPhotoRepository modelPhotoRepository;
    @Autowired
    private SmartPhoneRepository smartPhoneRepository;

    @PersistenceContext
    EntityManager entityManager;


    @JsonView(Views.FullModel.class)
    @GetMapping("/models-page")
    public Page<Model> getModels(
            @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable
    ) {
        Page<Model> page = modelRepository.findAll(pageable);
        return page;
    }

    @JsonView(Views.FullModel.class)
    @GetMapping("/models")
    public List<Model> getModels() {
        return modelRepository.findAll(new Sort(Sort.Direction.DESC, "id"));
    }

    @JsonView(Views.FullSmartPhone.class)
    @GetMapping("/smartphones")
    public List<SmartPhone> getSmartPhones() {
        return smartPhoneRepository.findAll(new Sort(Sort.Direction.DESC, "id"));
    }

    @JsonView(Views.FullSmartPhone.class)
    @GetMapping("/phone/{id}")
    public SmartPhone getSmartPhone(@PathVariable Long id) {
        return smartPhoneRepository.findById(id).get();
    }

    @JsonView(Views.FullSmartPhone.class)
    @GetMapping("/phones-model/{id}")
    public List<SmartPhone> getSmartPhonesModel(@PathVariable("id") Long idModel) {
        return smartPhoneRepository.findByModelId(idModel);
    }

    private String addQuery(String fullQuery, String partQuery) {
        if (fullQuery.length() == 0) {
            partQuery = " where " + partQuery;
        }
        if (fullQuery.length() > 0) {
            fullQuery += " and ";
        }
        fullQuery += partQuery;
        return fullQuery;
    }

    @JsonView(Views.FullModel.class)
    @GetMapping("/models/{name}")
    public List<Model> getModelsByName(@PathVariable String name) {
        if (name == null || name.isEmpty() || name.trim().isEmpty()) {
            return modelRepository.findAll(new Sort(Sort.Direction.DESC, "id"));
        }
        return modelRepository.findByLikeName(name);
    }

    @JsonView(Views.FullSmartPhone.class)
    @GetMapping("/smartphones/{name}")
    public List<SmartPhone> getSmartPhonesByName(@PathVariable String name) {
        if (name == null || name.isEmpty() || name.trim().isEmpty()) {
            return smartPhoneRepository.findAll(new Sort(Sort.Direction.DESC, "id"));
        }
        return smartPhoneRepository.findByName(name);
    }

    @JsonView(Views.FullSmartPhone.class)
    @PostMapping("/smartphones")
    public List<SmartPhone> getSmartPhonesByFilter(@RequestBody Filter filter) {
        String query = new String("");

        List<Color> colors = filter.getColors();
        if (colors.size() > 0) {
            query = addQuery(query, " p.colorModel.color in :colors ");
        }

        List<Company> companies = filter.getCompanies();
        if (companies.size() > 0) {
            query = addQuery(query, " p.colorModel.model.company in :companies ");
        }

        List<Os> oss = filter.getOss();
        if (oss.size() > 0) {
            query = addQuery(query, " p.os in :oss ");
        }

        List<Cpu> cpunits = filter.getCpunits();
        if (cpunits.size() > 0) {
            query = addQuery(query, " p.colorModel.model.cpu in :cpunits ");
        }

        List<DisplayType> displayTypes = filter.getDisplayTypes();
        if (displayTypes.size() > 0) {
            query = addQuery(query, " p.colorModel.model.display.displayType in :displayTypes ");
        }

        List<Resolution> resolutions = filter.getResolutions();
        if (resolutions.size() > 0) {
            query = addQuery(query, " p.colorModel.model.display.resolution in :resolutions ");
        }

        List<Material> materials = filter.getMaterials();
        if (materials.size() > 0) {
            query = addQuery(query, " p.colorModel.model.material in :materials ");
        }

        int ramStep = 100;
        if (filter.getRamFrom() != null) {
            if (filter.getRamTo() != null) {
                if (filter.getRamFrom().intValue() > filter.getRamTo().intValue()) {
                    filter.setRamTo(filter.getRamTo().intValue() + ramStep);
                }
            } else {
                filter.setRamTo(filter.getRamTo().intValue() + ramStep);
            }
            query = addQuery(query, " p.ram between :ramFrom and :ramTo ");
        }

        int storageStep = 1000;
        if (filter.getStorageFrom() != null) {
            if (filter.getStorageTo() != null) {
                if (filter.getStorageFrom().intValue() > filter.getStorageTo().intValue()) {
                    filter.setStorageTo(filter.getStorageFrom().intValue() + storageStep);
                }
            } else {
                filter.setStorageTo(filter.getStorageFrom().intValue() + storageStep);
            }
            query = addQuery(query, " p.storage between :storageFrom and :storageTo ");
        }

        int costStep = 10000;
        if (filter.getCostFrom() != null) {
            if (filter.getCostTo() != null) {
                if (filter.getCostFrom().intValue() > filter.getCostTo().intValue()) {
                    filter.setCostTo(filter.getCostFrom().intValue() + costStep);
                }
            } else {
                filter.setCostTo(filter.getCostFrom().intValue() + costStep);
            }
            query = addQuery(query, " p.cost between :costFrom and :costTo ");
        }

        String s = query;

        TypedQuery<SmartPhone> typedQuery = entityManager.createQuery("select p from SmartPhone p " +
                        query +
                        "order by p.id desc",
                SmartPhone.class);

        if (colors.size() > 0) {
            typedQuery.setParameter("colors", colors);
        }

        if (companies.size() > 0) {
            typedQuery.setParameter("companies", companies);
        }

        if (oss.size() > 0) {
            typedQuery.setParameter("oss", oss);
        }

        if (cpunits.size() > 0) {
            typedQuery.setParameter("cpunits", cpunits);
        }

        if (displayTypes.size() > 0) {
            typedQuery.setParameter("displayTypes", displayTypes);
        }

        if (resolutions.size() > 0) {
            typedQuery.setParameter("resolutions", resolutions);
        }

        if (materials.size() > 0) {
            typedQuery.setParameter("materials", materials);
        }

        if (filter.getRamFrom() != null) {
            typedQuery.setParameter("ramFrom", filter.getRamFrom());
            typedQuery.setParameter("ramTo", filter.getRamTo());
        }

        if (filter.getStorageFrom() != null) {
            typedQuery.setParameter("storageFrom", filter.getStorageFrom());
            typedQuery.setParameter("storageTo", filter.getStorageTo());
        }

        if (filter.getCostFrom() != null) {
            typedQuery.setParameter("costFrom", filter.getCostFrom());
            typedQuery.setParameter("costTo", filter.getCostTo());
        }

        return typedQuery.getResultList();
    }

    @JsonView(Views.FullModel.class)
    @PostMapping("/models")
    public List<Model> getModelsByFilter(@RequestBody Filter filter) {
        Query query
                = entityManager.createNativeQuery(
                "SELECT * FROM Model AS m" +
                        "INNER JOIN `model_color` AS `mc` ON `mc`.`id_model` = `m`.`id_model`" +
                        "INNER JOIN `color` AS `clr` ON `mc`.`id_color` = `clr`.`id_color`" +
                        "INNER JOIN `model_photo` AS `mp` ON `mc`.`id_model_color` = `mp`.`id_model_color`" +

                        "INNER JOIN `product` AS `p` ON `mc`.`id_model_color` = `p`.`id_model_color`" +
                        "INNER JOIN `os` AS `os` ON `p`.`id_os` = `os`.`id_os`" +

                        "INNER JOIN `company` as `c` ON `m`.`id_company` = `c`.`id_company`" +
                        "INNER JOIN `cpu` as `cpu` ON `m`.`id_cpu` = `cpu`.`id_cpu`" +
                        "INNER JOIN `gpu` as `gpu` ON `m`.`id_gpu` = `gpu`.`id_gpu`" +

                        "INNER JOIN `camera` as `cam_main` ON `m`.`id_camera_main` = `cam_main`.`id_camera`" +
                        "INNER JOIN `resolution` as `res_photo_cam_main` ON `cam_main`.`id_resolution_photo` = `res_photo_cam_main`.`id_resolution`" +
                        "INNER JOIN `resolution` as `res_video_cam_main` ON `cam_main`.`id_resolution_video` = `res_video_cam_main`.`id_resolution`" +

                        "INNER JOIN `camera` as `cam_add` ON `m`.`id_camera_add` = `cam_add`.`id_camera`" +
                        "INNER JOIN `resolution` as `res_photo_cam_add` ON `cam_add`.`id_resolution_photo` = `res_photo_cam_add`.`id_resolution`" +
                        "INNER JOIN `resolution` as `res_video_cam_add` ON `cam_add`.`id_resolution_video` = `res_video_cam_add`.`id_resolution`" +

                        "INNER JOIN `display` as `dp` ON `m`.`id_display` = `dp`.`id_display`" +
                        "INNER JOIN `display_type` as `dp_type` ON `dp`.`id_display_type` = `dp_type`.`id_display_type`" +

                        "INNER JOIN `material` as `mat` ON `m`.`id_material` = `mat`.`id_material`" +

                        "Where m.id_model = 40",
                Model.class);
        return modelRepository.findAll();
    }

    @JsonView(Views.FullModel.class)
    @GetMapping("/model/{id}")
    public Model getModel(@PathVariable Long id) {
        return modelRepository.findModelById(id);
    }

    @DeleteMapping("/model/{id}")
    public void removeModel(@PathVariable("id") Model model) {
        for (ModelColor modelColor : model.getColorModels()) {
            for (ModelPhoto modelPhoto : modelColor.getPhotos()) {
                File file = new File(uploadPath + "/" + modelPhoto.getUrl());
                file.delete();
            }
        }
        modelRepository.delete(model);
        //model
        //modelRepository.deleteById(id);
    }

    @PostMapping("/model")
    public Long saveOrUpdateModel(@RequestBody Model model) {
        Model existModel = modelRepository.findByName(model.getName());
        if (existModel != null && !existModel.getId().equals(model.getId())) {
            throw new RestException("Модель с таким названием уже существует!");
        }
        return modelRepository.save(model).getId();
    }

    private ModelColor parseColorModel(String jsonModelColor) {
        Gson gson = new Gson();
        Type type = new TypeToken<ModelColor>() {
        }.getType();
        return gson.fromJson(jsonModelColor, type);
    }

    private void createUploadDir() {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
    }

    private String saveFile(MultipartFile file) {
        String uuidFile = UUID.randomUUID().toString();
        String resultFilename = uuidFile + "." + file.getOriginalFilename();
        try {
            file.transferTo(new File(uploadPath + "/" + resultFilename));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RestException("Ошибка сохранения изображения!");
        }
        return resultFilename;
    }

    // Иногда возникает проблема с загрузкой файлов, нужно перезагрузить проект ....
    @JsonView(Views.Base.class)
    @PostMapping(value = "/color-model", consumes = {"multipart/form-data"})
    public ModelColor postColorModel(
            @RequestParam("modelColor") String jsonModelColor,
            @RequestParam("files") MultipartFile[] files) {
        ModelColor modelColor = parseColorModel(jsonModelColor);
        createUploadDir();
        for (int i = 0; i < files.length; i++) {
            String resultFilename = saveFile(files[i]);
            modelColor.getPhotos().get(i).setUrl(resultFilename);
        }
        modelPhotoRepository.saveAll(modelColor.getPhotos());
        return modelColorRepository.save(modelColor);
    }

    // ВНИМАНИЕ. С PutMapping не работает @RequestParam, но работает @RequestPart
    // Уточнить разницу
    @JsonView(Views.Base.class)
    @PutMapping(value = "/color-model-update", consumes = {"multipart/form-data"})
    public ModelColor updateColorModel(
            @RequestPart(value = "modelColor", required = false) String jsonModelColor,
            @RequestPart(value = "files", required = false) MultipartFile[] files) {
        ModelColor modelColor = parseColorModel(jsonModelColor);
        createUploadDir();
        int filePosition = 0;
        List<ModelPhoto> modelPhotos = modelColor.getPhotos();
        for (int i = 0; i < modelPhotos.size(); i++) {
            ModelPhoto modelPhoto = modelPhotos.get(i);
            if (modelPhoto.getId() != null) {
                continue;
            } else {
                String resultFilename = saveFile(files[filePosition]);
                modelPhoto.setUrl(resultFilename);
                modelPhotoRepository.save(modelPhoto);
                filePosition++;
            }
        }
        return modelColorRepository.save(modelColor);
    }

    @DeleteMapping("/color-model/{id}")
    public void deleteColorModel(@PathVariable Long id) {
        ModelColor modelColor = modelColorRepository.getOne(id);
        for (ModelPhoto modelPhoto : modelColor.getPhotos()) {
            File file = new File(uploadPath + "/" + modelPhoto.getUrl());
            file.delete();
        }
        modelColorRepository.deleteById(id);
    }

    @DeleteMapping("/color-model-photo/{id}")
    public void deletePhoto(@PathVariable Long id) {
        ModelPhoto modelPhoto = modelPhotoRepository.getOne(id);
        File file = new File(uploadPath + "/" + modelPhoto.getUrl());
        file.delete();
        modelPhotoRepository.delete(modelPhoto);
    }


    /*
       Один из вариантов реализации.
       Нужно парсить входной объект.
       Принимается только один файл.
    */
    @PostMapping(value = "/color-model-simple")
    public void postColorModelTest(@RequestBody ModelColor colorModel) {
        Color color = colorModel.getColor();

        //return modelColorRepository.save(colorModel);
    }


    @PutMapping("/model/{id}")
    public Model updateModel(@RequestBody Model model, @PathVariable Long id) {
        return modelRepository.save(model);
    }

    @PostMapping(value = "/configuration")
    public Long postConfiguration(@RequestBody SmartPhone smartPhone) {
        return smartPhoneRepository.save(smartPhone).getId();
    }

    @PutMapping(value = "/configuration")
    public void updateConfiguration(@RequestBody SmartPhone smartPhone) {
        smartPhoneRepository.save(smartPhone).getId();
    }

    @DeleteMapping(value = "/configuration/{id}")
    public void removeConfiguration(@PathVariable("id") SmartPhone smartPhone) {
        smartPhoneRepository.deleteById(smartPhone.getId());
    }
}
