const token = document.getElementById("_csrf").value;
const userId = document.getElementById("userId").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var emptyFilter = {
    companies: [],
    cpunits: [],
    displays: [], // Диагональ
    displayTypes: [],
    cameras: [], // Качество в МП
    materials: [],
    colors: [],
    oss: [],
    resolutions: [],
    ramFrom: 0,
    ramTo: 16,
    storageFrom: 0,
    storageTo: 512,
    costFrom: 0,
    costTo: 1000000
};

var app = new Vue({
    el: '#models-manager',
    data: {
        urlNoImage: "/images/no_image.png",
        phones: [],
        ////
        companies: [],
        cpunits: [],
        gpunits: [],
        displays: [],
        displayTypes: [],
        resolutions: [],
        cameras: [],
        materials: [],
        colors: [],
        oss: [],
        ///
        searchName: '',
        filters: [],
        filter: Object.assign({}, emptyFilter),

        ///
        idSelectedPhones: []
    },
    created: function () {
        if (userId != -1) {
            this.getSelectedPhones();
        }
        this.getAllPhones();
        this.updateData();
    },
    methods: {
        initFilter() {
            return {
                companies: [],
                cpunits: [],
                displays: [], // Диагональ
                displayTypes: [],
                cameras: [], // Качество в МП
                materials: [],
                colors: [],
                oss: [],
                resolutions: [],
                ramFrom: 0,
                ramTo: 16,
                storageFrom: 0,
                storageTo: 512,
                costFrom: 0,
                costTo: 1000000
            }
        },
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
        //----------------------------
        updateData() {
            this.getCompanies();
            this.getCpunits();
            this.getGpunits();
            this.getDisplays();
            this.getDisplayTypes();
            this.getResolutions();
            this.getCameras();
            this.getMaterials();
            this.getColors();
            this.getOss();
        },
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
        getDisplayTypes() {
            this.displayTypes = [];
            this.getComponents(this.displayTypes, 'display-types');
        },
        getResolutions() {
            this.resolutions = [];
            this.getComponents(this.resolutions, 'resolutions');
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

        checkExistPhone(phone){
            return this.idSelectedPhones.includes(phone.id);
        },
        openUrl() {
            location.href = 'http://localhost:8080/bucket/';
            //window.open('http://localhost:8080/admin/model/' + model.id);
        },

        //----------------------------

        getModelName(object) {
            const model = object.colorModel.model;
            let fullname = model.name;
            let params = '';
            /* if (model.cpu != null) {
                 params += model.cpu.name + " ";
             }*/
            if (model.display != null) {
                if (model.display.displayType != null) {
                    params += model.display.displayType.name + ", ";
                }
                if (object.diagonal > 0) {
                    params += object.diagonal + "\'\', ";
                }
                if (model.display.resolution != null) {
                    params += model.display.resolution.resolutionX + " x " + model.display.resolution.resolutionY + ", ";
                }
            }
            if (params.length > 0) {
                fullname += ", " + params + object.colorModel.color.name;
            } else {
                fullname += " " + object.colorModel.color.name;
            }
            return fullname;
        },
        getModelDescription(phone) {
            const model = phone.colorModel.model;
            let fullname = phone.os.name + " " + phone.ram + " Гб х " +
                phone.storage + " Гб ";
            if (model.mainCamera != null) {
                fullname += model.mainCamera.resolutionPhoto.resolution + " Мп "
            }
            if (model.power != null && model.power > 0) {
                fullname += model.power + " мА/ч";
            }
            return fullname;
        },
        getImage(phone) {
            for (let i = 0; i < phone.colorModel.photos.length; i++) {
                return "/img/" + phone.colorModel.photos[i].url;
            }
            return this.urlNoImage;
        },
       /* openUrl(phone) {
            location.href = 'http://localhost:8080/admin/model/' + phone.colorModel.model.id;
            //window.open('http://localhost:8080/admin/model/' + model.id);
        },*/

        getAllPhones() {
            Vue.resource('/api/smartphones').get().then(result => {
                result.json().then(data => {
                    this.phones = [];
                    data.forEach(phone => {
                        this.phones.push(phone);
                    })
                })
            });
        },

        /////////////////////////////////////////////////////////////////////////////////////
        getPhonesByFilter() {
            Vue.resource('/api/smartphones').save(this.filter).then(result => {
                result.json().then(data => {
                    this.phones = [];
                    data.forEach(phone => {
                        this.phones.push(phone);
                    })
                })
            });
        },

        getPhonesByName() {
            Vue.resource('/api/smartphones{/name}').get({name: this.searchName}).then(result => {
                result.json().then(data => {
                    this.phones = [];
                    data.forEach(phone => {
                        this.phones.push(phone);
                    })
                })
            })
            //Поиск по названию
            //this.searchName;
        },

        clearFilters() {
            this.filter = Object.assign({}, emptyFilter);
            this.getAllPhones();
        },

        /////////////////////////////////////////////////////////////////////////////////
        remove(model, position) {
            Vue.resource('/api/model{/id}').remove({id: model.id}).then(result =>
                this.models.splice(position, 1)
            );
        },


        /////////////////////////////////////////////////////////////////////////////////
        buyPhone(phone) {
            Vue.resource('/api/bucket-product/').save(phone)
                .then(result => {
                    result.json().then(data => {
                        this.idSelectedPhones = [];
                        data.forEach(id =>{
                            this.idSelectedPhones.push(id);
                        });
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {

                });
        },
        getSelectedPhones() {
            Vue.resource('/api/bucket-product/').get()
                .then(result => {
                    result.json().then(data => {
                        data.forEach(id => {
                            this.idSelectedPhones.push(id);
                        })
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {

                });
        },
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