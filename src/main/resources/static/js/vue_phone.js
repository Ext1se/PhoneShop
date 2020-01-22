const token = document.getElementById("_csrf").value;
const phoneId = document.getElementById("phoneId").value;
const modelId = document.getElementById("modelId").value;
const userId = document.getElementById("userId").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#phone-manager',
    data: {
        urlNoImage: "/images/no_image.png",
        phone: {
            id: '',
            os: {
                id: '',
                name: ''
            },
            colorModel: {
                id: '',
                model: {
                    id: '',
                    name: '',
                    company: {
                        id: '',
                        name: '',
                        country: ''
                    },
                    cpu: {
                        id: 1,
                        name: '',
                        beans: '',
                        frequency: '',
                        size: '',
                        bit: ''
                    },
                    gpu: {
                        id: '',
                        name: '',
                        frequency: ''
                    },
                    mainCamera: {
                        id: '',
                        name: '',
                        resolutionPhoto: {
                            id: '',
                            resolution: '',
                            resolutionX: '',
                            resolutionY: ''
                        },
                        resolutionVideo: {
                            id: '',
                            resolution: '',
                            resolutionX: '',
                            resolutionY: ''
                        }
                    },
                    addCamera: {
                        id: '',
                        name: '',
                        resolutionPhoto: {
                            id: '',
                            resolution: '',
                            resolutionX: '',
                            resolutionY: ''
                        },
                        resolutionVideo: {
                            id: '',
                            resolution: '',
                            resolutionX: '',
                            resolutionY: ''
                        }
                    },
                    display: {
                        id: '',
                        name: '',
                        displayType: {
                            id: '',
                            name: ''
                        },
                        resolution: {
                            id: '',
                            resolution: '',
                            resolutionX: '',
                            resolutionY: ''
                        },
                        diagonal: '',
                        density: ''
                    },
                    material: {
                        id: '',
                        name: ''
                    },
                    weight: '',
                    height: '',
                    width: '',
                    countSim: '',
                    power: '',
                    description: ''
                },
                color: {
                    id: '',
                    name: '',
                    value: ''
                },
                photos: []
            },
            storage: '',
            ram: '',
            cost: '',
            count: ''
        },
        phones: [],
        model: {},
        comment: {
            rating: 0
        },
        comments: [],

        idSelectedPhones: []
    },
    created: function () {
        this.getPhone();
        if (userId != -1) {
            this.getUserComment();
            this.getSelectedPhones();
        }
        this.getAllPhones();
        this.getModel();
        this.getComments();
    },
    mounted: function () {

    },
    methods: {
        //----------------------------

        checkExistPhone(){
            return this.idSelectedPhones.includes(this.phone.id);
        },
        openUrl() {
            location.href = 'http://localhost:8080/bucket/';
            //window.open('http://localhost:8080/admin/model/' + model.id);
        },

        //----------------------------
        getCompanyName() {
            const company = this.phone.colorModel.model.company;
            if (company == null) {
                return;
            }
            let fullname = company.name;
            if (company.country != null) {
                fullname += ", " + company.country;
            }
            return fullname;
        },
        getCpuName() {
            const cpu = this.phone.colorModel.model.cpu;
            if (cpu == null) {
                return;
            }
            let fullname = cpu.name;
            if (cpu.beans > 0 && cpu.frequency > 0) {
                fullname += " (" + cpu.beans + " x " + cpu.frequency + " МГц)";
            }
            return fullname;
        },
        getGpuName() {
            const gpu = this.phone.colorModel.model.gpu;
            if (gpu == null) {
                return;
            }
            let fullname = gpu.name;
            if (gpu.frequency > 0) {
                fullname += " (" + gpu.frequency + " МГц)";
            }
            return fullname;
        },
        getDisplayName() {
            const display = this.phone.colorModel.model.display;
            if (display == null) {
                return;
            }
            //let fullname = display.name;
            let fullname = '';
            if (display.diagonal > 0) {
                fullname += display.diagonal + "\'\'";
            }
            if (display.resolution != null) {
                if (display.diagonal > 0) {
                    fullname += ', ';
                }
                fullname += display.resolution.resolutionX + " x " + display.resolution.resolutionY;
            }
            return fullname;
        },
        getDisplayTypeName() {
            const displayType = this.phone.colorModel.model.display.displayType;
            if (displayType == null) {
                return;
            }
            return displayType.name;
        },
        getCameraName() {
            const cameraMain = this.phone.colorModel.model.mainCamera;
            const cameraAdd = this.phone.colorModel.model.addCamera;
            let fullname = '';
            if (cameraMain.resolutionPhoto != null) {
                fullname += cameraMain.resolutionPhoto.resolution + " МП ";
            }
            if (cameraAdd.resolutionPhoto != null) {
                if (cameraMain.resolutionPhoto != null) {
                    fullname += "x ";
                }
                fullname += cameraAdd.resolutionPhoto.resolution + " МП ";
            }
            return fullname;
        },
        /////////////////

        getModel() {
            Vue.resource("/api/model{/id}").get({id: modelId})
                .then(result => {
                    result.json().then(data => {
                        this.model = data;
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
        },

        /////////////////
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
            let fullname = phone.os.name + ", " +
                phone.ram + " Гб х " +
                phone.storage + " Гб, " +
                model.mainCamera.resolutionPhoto.resolution + " Мп, " +
                model.power + " мА/ч";
            return fullname;
        },
        getImage(photo) {
            return "/img/" + photo.url;
        },
        getPhone() {
            Vue.resource('/api/phone{/id}').get({id: phoneId})
                .then(result => {
                    result.json().then(data => {
                        //this.phone = {};
                        this.phone = data;
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
        getAllPhones() {
            // Vue.resource('/api/smartphones{/id}')
            //alert("idModel " + this.phone.colorModel.model.id);
            Vue.resource('/api/phones-model{/id}').get({id: modelId})
                .then(result => {
                    result.json().then(data => {
                        this.phones = [];
                        data.forEach(phone => {
                            this.phones.push(phone);
                        })
                    })
                });
        },
        setPhone(selectedPhone) {
            for (let i = 0; i < this.phones.length; i++) {
                let phone = this.phones[i];
                if (phone.id == selectedPhone.id) {
                    this.phone = phone;
                    $('.carousel').carousel(0)
                    return;
                }
            }
        },
        getUserComment() {
            Vue.resource('/api/comment-user{/id}').get({id: modelId})
                .then(result => {
                    result.json().then(data => {
                        this.comment = data;
                        this.comment.model = this.model;
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
        getComments() {
            Vue.resource('/api/comments{/id}').get({id: modelId})
                .then(result => {
                    result.json().then(data => {
                        this.comments = [];
                        this.comments = data;
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
        saveComment() {
            this.comment.model = this.model;
            enableSpinnerButton(false, $("#spinnerComment"), $("#btnSaveComment"));
            Vue.resource('/api/comment').save(this.comment)
                .then(result => {
                    result.json().then(data => {
                        this.comment.user = data.user;
                        this.comment.dateCreated = data.dateCreated;
                        this.comment.dateUpdated = data.dateUpdated;

                        if (this.comment.id) {
                            for (let i = 0; i < this.comments.length; i++) {
                                const comment = this.comments[i];
                                if (comment.id == this.comment.id) {
                                    this.comments.splice(i, 1, Object.assign({}, this.comment));
                                    break;
                                }
                            }
                        } else {
                            this.comment.id = data.id;
                            this.comments.unshift(Object.assign({}, this.comment));
                            //this.comments.splice(0, 0, Object.assign({}, this.comment));
                        }

                        $("#btnSaveComment").html('Редактировать');
                        $("#btnRemoveComment").show();
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {
                    enableSpinnerButton(true, $("#spinnerComment"), $("#btnSaveComment"));
                });
        },
        removeComment(id, position) {
            Vue.resource('/api/comment{/id}').remove({id: id})
                .then(result => {
                    this.comment = {};
                    this.comment.rating = 0;
                    if (position == -1) {
                        for (let i = 0; i < this.comments.length; i++) {
                            const comment = this.comments[i];
                            if (comment.id == id) {
                                this.comments.splice(i, 1);
                                break;
                            }
                        }
                        $("#btnSaveComment").html('Опубликовать');
                        $("#btnRemoveComment").hide();
                    } else {
                        this.comments.splice(position, 1);
                    }

                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {

                });
        },
        /////////////////////////////////////////////////////////////////////////////////
        buyPhone() {
            Vue.resource('/api/bucket-product/').save(this.phone)
                .then(result => {
                    result.json().then(data => {
                        this.idSelectedPhones = [];
                        data.forEach(id =>{
                            this.idSelectedPhones.push(id);
                        });
                        //$("#btnBuy").hide();
                        //$("#btnBucket").show();
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