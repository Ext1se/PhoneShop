const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#models-manager',
    data: {
        urlNoImage: "/images/no_image.png",
        models: [],
        ////
        companies: [],
        cpunits: [],
        gpunits: [],
        displays: [],
        displayTypes: [],
        cameras: [],
        materials: [],
        colors: [],
        oss: [],
        ///
        searchName: ''
    },
    created: function () {
        this.getAllModels();
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
        //----------------------------
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

        getModelName(object) {
            let fullname = object.name;
            let params = '';
            if (object.cpu != null) {
                params += object.cpu.name + "; ";
            }
            if (object.display != null) {
                if (object.display.displayType != null) {
                    params += object.display.displayType.name + "; ";
                }
                if (object.display.resolution != null) {
                    params += object.display.resolution.resolutionX + " x " + object.display.resolution.resolutionY + "; ";
                }
            }
            if (params.length > 0) {
                fullname += ": " + params;
            }
            return fullname;
        },
        getImage(model) {
            for (let i = 0; i < model.colorModels.length; i++) {
                const colorModel = model.colorModels[i];
                for (let j = 0; j < colorModel.photos.length; j++) {
                    return "/img/" + colorModel.photos[j].url;
                }
            }
            return this.urlNoImage;
        },
        openUrl(model) {
            location.href = 'http://localhost:8080/admin/model/' + model.id;
            //window.open('http://localhost:8080/admin/model/' + model.id);
        },

        getAllModels(){
            Vue.resource('/api/models').get().then(result => {
                result.json().then(data => {
                    this.models = [];
                    data.forEach(model => {
                        this.models.push(model);
                    })
                })
            });
        },

        getPhonesByName() {
            Vue.resource('/api/models{/name}').get({name: this.searchName}).then(result => {
                result.json().then(data => {
                    this.models = [];
                    data.forEach(model => {
                        this.models.push(model);
                    })
                })
            })
        },

        remove(model, position) {
            Vue.resource('/api/model{/id}').remove({id: model.id}).then(result =>
                this.models.splice(position, 1)
            );
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