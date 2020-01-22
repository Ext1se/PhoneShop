const typeImages = ['jpg', 'jpeg', 'gif', 'bmp', 'png'];
const sizeImage = 1024 * 1024 * 10;
const maxImages = 3;
const modelId = document.getElementById("modelId").value;
const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#model-manager',
    data: {
        ui: {
            classInvalid: 'is-invalid',
            classTextSuccess: 'text-success',
            classTextDanger: 'text-danger',
            classTextWarning: 'text-warning',
        },
        //
        model: {
            id: -1,
            name: '',
            description: ''
        },
        companies: [],
        cpunits: [],
        gpunits: [],
        displays: [],
        cameras: [],
        materials: [],
        colors: [],
        oss: [],
        isValidated: false,
        //
        colorModels: [],
        configurations: []
    },
    computed: {
        saveColorModels() {
            return this.colorModels.filter(function (colorModel) {
                return colorModel.id
            })
        }
    },
    // Запускается после загрузки страницы
    mounted() {
        window.addEventListener('load', () => {
            if (this.model.id != -1) {
                $("#btnSaveModel").prop('disabled', true);

                for (let i = 0; i < this.colorModels.length; i++) {
                    $("#btnSaveColorModel" + i).prop('disabled', true);
                }
                for (let i = 0; i < this.configurations.length; i++) {
                    $("#btnSaveConfiguration" + i).prop('disabled', true);
                }
            }
        })
    },
    created: function () {
        if (modelId && modelId != -1) {
            Vue.resource("/api/model{/id}").get({id: modelId})
                .then(result => {
                    result.json().then(data => {
                        this.model = Object.assign({}, data);
                        //this.model = data;
                        this.model.colorModels = null;
                        data.colorModels.forEach(colorModel => {
                            let copyColorModel = Object.assign({}, colorModel);
                            copyColorModel.configurations = null;
                            copyColorModel.model = this.model;
                            this.colorModels.push(copyColorModel);
                            copyColorModel.photos.forEach(photo => {
                                photo.url = '/img/' + photo.url;
                            });
                            colorModel.configurations.forEach(configuration => {
                                configuration.colorModel = copyColorModel;
                                this.configurations.push(configuration);
                            })
                        });
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {

                    }
                );
        }
        this.updateData();
    },
    methods: {
        getComponents(components, address) {
            let apiAddress = '/api/' + address;
            Vue.resource(apiAddress).get()
                .then(result => {
                    result.json()
                        .then(data => {
                            data.forEach(object => {
                                components.push(object);
                            })
                        })
                        .finally(() => {
                        })
                })
                .finally(() => {

                });
        },
        updateData() {
            this.getCompanies();
            this.getCpunits();
            this.getGpunits();
            this.getDisplays();
            this.getCameras();
            this.getMaterials();
            this.getColors();
            this.getOss();
        },

        //----------------------------
        getCompanies() {
            this.companies = [];
            this.getComponents(this.companies, 'companies');
        },
        getCpunits() {
            this.cpunits = [];
            this.getComponents(this.cpunits, 'cpunits');
        },
        getGpunits() {
            this.gpunits = [];
            this.getComponents(this.gpunits, 'gpunits');
        },
        getDisplays() {
            this.displays = [];
            this.getComponents(this.displays, 'displays');
        },
        getCameras() {
            this.cameras = [];
            this.getComponents(this.cameras, 'cameras');
        },
        getMaterials() {
            this.materials = [];
            this.getComponents(this.materials, 'materials');
        },
        getColors() {
            this.colors = [];
            this.getComponents(this.colors, 'colors');
        },
        getOss() {
            this.oss = [];
            this.getComponents(this.oss, 'oss');
        },

        //----------------------------

        //----------------------------

        //----------------------------
        getCompanyOptionName(object) {
            let fullname = object.name;
            if (object.country != null) {
                fullname += " (" + object.country + ")";
            }
            return fullname;
        },
        getCpuOptionName(object) {
            let fullname = object.name;
            if (object.beans > 0 && object.frequency > 0) {
                fullname += " (" + object.beans + " x " + object.frequency + " МГц)";
            }
            return fullname;
        },
        getGpuOptionName(object) {
            let fullname = object.name;
            if (object.frequency > 0) {
                fullname += " (" + object.frequency + " МГц)";
            }
            return fullname;
        },
        getDisplayOptionName(object) {
            let fullname = object.name;
            let params = '';
            if (object.diagonal > 0) {
                params += object.diagonal + "\'\'; ";
            }
            if (object.displayType != null) {
                params += object.displayType.name + "; ";
            }
            if (object.resolution != null) {
                params += object.resolution.resolutionX + " x " + object.resolution.resolutionY + "; ";
            }
            if (params.length > 0) {
                fullname += ": " + params;
            }
            return fullname;
        },
        getCameraOptionName(object) {
            let fullname = object.name;
            if (object.resolutionPhoto != null) {
                fullname += " (" + object.resolutionPhoto.resolution + " Мп, " +
                    object.resolutionPhoto.resolutionX + " x " + object.resolutionPhoto.resolutionY + ")";
            }
            return fullname;
        },
        getColorValue(color) {
            if (color == null) {
                return ''
            } else {
                return color.value;
            }
        },
        getColorModels() {
            return this.colorModels.filter(item => {
                return item.id;
            })
        },
        //----------------------------
        add() {

        },

        saveModel() {
            if (!this.isValidModel(this.model)) {
                return;
            }
            enableSpinnerButton(false, $("#spinnerModel"), $("#btnSaveModel"));
            Vue.resource('/api/model').save(this.model)
                .then(result => {
                    result.json().then(id => {
                        this.model.id = id;
                        $("#infoCardModel").html("Модель успешно сохранена!");
                        $("#infoCardModel").prop("class", this.ui.classTextSuccess);
                        $("#btnSaveModel").prop('disabled', true);
                        $("#bodyCardColorModel").collapse('show');
                    });
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                        $("#infoCardModel").html(data.message);
                        $("#infoCardModel").prop("class", this.ui.classTextDanger);
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinnerModel"), $("#btnSaveModel"));
                    }
                );
        },

        onChangeModel() {
            if (this.model.id == -1) {
                return;
            }
            $("#infoCardModel").html("Данные были изменены. Сохраните модель!");
            $("#infoCardModel").prop("class", this.ui.classTextWarning);
            $("#btnSaveModel").prop('disabled', false);
        },
        //----------------------------


        //----------------------------
        addEmptyColorModel() {
            let colorModel = {
                color: {},
                photos: []
            };
            const colorsLength = this.colors.length;
            const modelColorLength = this.colorModels.length;
            if (colorsLength > 0) {
                if (colorsLength > modelColorLength) {
                    colorModel.color = this.colors[modelColorLength];
                } else {
                    colorModel.color = this.colors[0];
                }
            }
            this.colorModels.push(colorModel);
        },
        openFile(colorModel, position) {
            if (colorModel.photos.length >= maxImages) {
                alert("Допустима загрузка до " + maxImages + " фотографий");
                return;
            }

            let id = "#file" + position;
            $(id).click();
        },
        onImagesChange(event, colorModel) {
            for (let i = 0; i < event.target.files.length; i++) {
                if (colorModel.photos.length >= maxImages) {
                    alert("Допустима загрузка до " + maxImages + " фотографий");
                    event.target.value = '';
                    return;
                }
                const file = event.target.files[i];
                // Проверка
                const type = file.name.split('.').pop();
                if (typeImages.indexOf(type) == -1) {
                    alert("Изображение должно быть одним из следующих форматов: jpg, jpeg, gif, bmp, png");
                    continue;
                }
                if (file.size > sizeImage) {
                    alert("Превышен допустимый размер файла: " + sizeImage / 1024 / 1024 + "МБ");
                    continue;
                }
                //
                let photo = {
                    url: '',
                    image: {}
                };
                photo.image = file;
                photo.url = URL.createObjectURL(file);
                colorModel.photos.push(photo);
            }
            this.onChangeColorModel(colorModel)
            event.target.value = '';
        },
        onImageChange(event, colorModel) {
            const file = event.target.files[0];
            if (file != null) {
                // Проверка
                const type = file.name.split('.').pop();
                if (typeImages.indexOf(type) == -1) {
                    alert("Изображение должно быть одним из следующих форматов: jpg, jpeg, gif, bmp, png");
                    return;
                }
                if (file.size > sizeImage) {
                    alert("Превышен допустимый размер файла: " + sizeImage / 1024 / 1024 + "МБ");
                    return;
                }
                //
                let photo = {
                    url: '',
                    image: {}
                };
                photo.image = file;
                photo.url = URL.createObjectURL(file);
                colorModel.photos.push(photo);

                event.target.value = '';
            } else {
                //alert("NULL")
            }
        },
        onColorChange(colorModel, position) {
            this.onChangeColorModel(colorModel);
            for (let i = 0; i < this.colorModels.length; i++) {
                const checkColorModel = this.colorModels[i];
                if (checkColorModel == colorModel) {
                    continue;
                }
                if (checkColorModel.color == colorModel.color) {
                    $("#colorTheme" + position).addClass(this.ui.classInvalid);
                    return;
                }
            }
            $("#colorTheme" + position).removeClass(this.ui.classInvalid);
        },
        onChangeColorModel(colorModel) {
            if (!colorModel.id) {
                return;
            }
            //$("#infoCardColorModel" + position).html("Данные были изменены. Сохраните новые данные!");
            //$("#infoCardColorModel" + position).prop("class", this.ui.classTextWarning);
            $("#btnSaveColorModel" + this.colorModels.indexOf(colorModel)).prop('disabled', false);

        },
        onFileChange(e, photo) {
            const file = e.target.files[0];
            //TODO проверка
            photo.image = file;
            photo.url = URL.createObjectURL(file);
            //photo.url = 'https://c.dns-shop.ru/thumb/st1/fit/190/190/d1760dbbc0217683642cb24d2024bc71/8e66298df43603b23b5e9c9021dc2d84324817d716c1ecc7630292f217132d42.jpg'
//            alert("A: " + photo.url)
            //          alert("B: " + this.colorModels[0].photos[0].url);
        },
        saveColorModel(colorModel, position) {
            //this.model.id = 1;
            colorModel.model = this.model;
            let formData = new FormData();
            let files = [];
            colorModel.photos.forEach(photo => {
                formData.append('files', photo.image);
            });
            formData.append('modelColor', JSON.stringify(colorModel));
            enableSpinnerButton(false, $("#spinnerColorModel" + position), $("#btnSaveColorModel" + position));
            if (colorModel.id) {
                this.updateColorModel(colorModel, position, formData);
                return
            }
            Vue.resource('/api/color-model').save(formData)
                .then(result => {
                    result.json().then(data => {
                        colorModel.id = data.id;
                        data.photos.forEach(function (photo, i) {
                            colorModel.photos[i].id = photo.id;
                            colorModel.photos[i].url = '/img/' + photo.url;
                            colorModel.photos[i].image = {};///////
                        });

                        //TODO
                        $("#btnSaveColorModel" + position).prop('disabled', true);
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinnerColorModel" + position), $("#btnSaveColorModel" + position));
                    }
                );
        },
        updateColorModel(colorModel, position, formData) {
            Vue.resource('/api/color-model-update').update(formData)
                .then(result => {
                    result.json().then(data => {
                        data.photos.forEach(function (photo, i) {
                            colorModel.photos[i].id = photo.id;
                            colorModel.photos[i].url = '/img/' + photo.url;
                            colorModel.photos[i].image = {};
                        });
                        $("#btnSaveColorModel" + position).prop('disabled', true);
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinnerColorModel" + position), $("#btnSaveColorModel" + position));
                    }
                );
        },
        removeColorModel(colorModel, position) {
            if (colorModel.id) {
                Vue.resource('/api/color-model{/id}').delete({id: colorModel.id})
                    .then(result => {
                        this.colorModels.splice(position, 1);
                    })
                    .catch(error => {
                        error.json().then(data => {
                            alert(data.message)
                        });
                    })
                    .finally(() => {
                        }
                    );
            } else {
                this.colorModels.splice(position, 1);
            }
            //Если удалить цветовую схему, нужно удалять и конфигурации
            for (let i = 0; i < this.configurations.length; i++) {
                let configuration = this.configurations[i];
                if (configuration.colorModel == colorModel) {
                    this.configurations.splice(this.configurations.indexOf(configuration), 1);
                    i--;
                }
            }
        },
        removePhoto(colorModel, photo, position) {
            if (photo.id) {
                Vue.resource('/api/color-model-photo{/id}').delete({id: photo.id})
                    .then(result => {
                        colorModel.photos.splice(position, 1);
                    })
                    .catch(error => {
                        error.json().then(data => {
                            alert(data.message)
                        });
                    });
            } else {
                colorModel.photos.splice(position, 1);
            }
        },
        saveColorModelSimple() {

        },


        //----------------------------
        addEmptyConfiguration() {
            let configuration = {
                os: {},
                ram: 1,
                storage: 1,
                colorModel: {},
                photos: []
            };
            if (this.oss.length > 0) {
                configuration.os = this.oss[0];
            }
            if (this.colorModels.length > 0) {
                configuration.colorModel = this.colorModels[0];
                // В коде ниже устанавливается только та цветовая схема, которая уже сохранена.
                // Но с текущей реализацией, используется любая цветовая схема...
                /*for (let i = 0; i < this.colorModels.length; i++) {
                    const colorModel = this.colorModels[i];
                    if (colorModel.id) {
                        configuration.colorModel = colorModel;
                        break;
                    }
                }*/
            }
            this.configurations.push(configuration);
        },
        copyConfiguration(configuration, index) {
            let copyConfiguration = Object.assign({}, configuration);
            copyConfiguration.id = '';
            //copyConfiguration.id = null;
            //alert(copyConfiguration.id);
            //this.configurations.splice(index + 1, 0, copyConfiguration);
            this.configurations.splice(this.configurations.length, 0, copyConfiguration);
        },
        saveConfiguration(configuration, position) {
            if (!this.isValidConfiguration(configuration, position)) {
                alert("Заполните все поля");
                return;
            }
            if (!configuration.colorModel.id) {
                alert("Перед сохранением конфигурации сохраните указанную цветовую схему!");
                return;
            }

            enableSpinnerButton(false, $("#spinnerConfiguration" + position), $("#btnSaveConfiguration" + position));

            if (configuration.id && configuration.id != null) {
                this.updateConfiguration(configuration, position);
                return;
            }
            Vue.resource('/api/configuration').save(configuration)
                .then(result => {
                    result.json().then(data => {
                            // Возвращается только id
                            configuration.id = data;
                            $("#btnSaveConfiguration" + position).prop('disabled', true);
                        }
                    )
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinnerConfiguration" + position), $("#btnSaveConfiguration" + position));
                    }
                );
        },
        updateConfiguration(configuration, position) {
            Vue.resource('/api/configuration').update(configuration)
                .then(result => {
                    showSpinner(false, $("#spinnerConfiguration" + position));
                    $("#btnSaveConfiguration" + position).prop('disabled', true);
                    // Нечего парсить
                    /* result.json().then(data => {
                         }
                     )*/
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                    enableSpinnerButton(true, $("#spinnerConfiguration" + position), $("#btnSaveConfiguration" + position));
                })
                .finally(() => {

                    }
                );
        },
        removeConfiguration(configuration, position) {
            if (configuration.id) {
                Vue.resource('/api/configuration{/id}').delete({id: configuration.id})
                    .then(result => {
                        this.configurations.splice(position, 1);
                    })
                    .catch(error => {
                        error.json().then(data => {
                            alert(data.message)
                        });
                    });
            } else {
                this.configurations.splice(position, 1);
            }
        },
        onConfigurationChange(configuration, position) {
            if (!configuration.id) {
                return;
            }
            //$("#infoCardColorModel" + position).html("Данные были изменены. Сохраните новые данные!");
            //$("#infoCardColorModel" + position).prop("class", this.ui.classTextWarning);
            $("#btnSaveConfiguration" + position).prop('disabled', false);
        },

        //----------------------------
        isValidModel(model) {
            this.isValidated = true;
            if (model.name.isEmpty()) {
                $("#name").addClass(this.ui.classInvalid);
                $("#infoCardModel").html("Исправьте указанные поля");
                $("#infoCardModel").addClass(this.ui.classTextDanger);
                return false;
            }
            $("#name").removeClass(this.ui.classInvalid);
            $("#infoCardModel").html("");
            $("#infoCardModel").removeClass(this.ui.classTextDanger);
            return true;
        },
        isValidConfiguration(configuration, position) {
            let isOk = true;
            if (!configuration.colorModel) {
                isOk = false;
                this.setValidClass($("#confColorModel" + position), false);
            } else {
                this.setValidClass($("#confColorModel" + position), true);
            }
            if (!configuration.os) {
                isOk = false;
                this.setValidClass($("#confOs" + position), false);
            } else {
                this.setValidClass($("#confOs" + position), true);
            }

            if (!configuration.ram) {
                isOk = false;
                this.setValidClass($("#confRam" + position), false);
            } else {
                this.setValidClass($("#confRam" + position), true);
            }

            if (!configuration.storage) {
                isOk = false;
                this.setValidClass($("#confStorage" + position), false);
            } else {
                this.setValidClass($("#confStorage" + position), true);
            }
            if (!configuration.cost) {
                isOk = false;
                this.setValidClass($("#confCost" + position), false);
            } else {
                this.setValidClass($("#confCost" + position), true);
            }

            return isOk;
        },
        setValidClass(view, isOk) {
            if (isOk) {
                view.removeClass(this.ui.classInvalid);
            } else {
                view.addClass(this.ui.classInvalid);
            }
        }
    }
});

function isValid(name, view) {
    let errorClass = 'is-invalid';
    if (name.isEmpty()) {
        view.addClass(errorClass);
        return false;
    } else {
        view.removeClass(errorClass);
        return true;
    }
}

function enableButton(isEnabled, viewSpinner, viewButton) {
    let spinnerClass = 'spinner-border';
    if (!isEnabled) {
        viewButton.prop("disabled", true);
        viewSpinner.addClass(spinnerClass);
    } else {
        viewButton.prop("disabled", false);
        viewSpinner.removeClass(spinnerClass);
    }
}