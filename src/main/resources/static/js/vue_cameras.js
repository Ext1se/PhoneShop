const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#camera-manager',
    data: {
        camera: {
            id: 0,
            name: ''
        },
        cameras: [],
        resolutions: [],
        isValidated: false
    },
    created: function () {
        Vue.resource('/api/cameras').get().then(result => {
            result.json().then(data => {
                data.forEach(camera => {
                    this.cameras.push(camera);
                })
            })
        });
        this.getResolutions();
    },
    methods: {
        updateData() {
            this.getResolutions();
        },
        getResolutions() {
            this.resolutions = [];
            Vue.resource('/api/resolutions').get().then(result => {
                result.json().then(data => {
                    if (data.length > 0) {
                        this.camera.resolutionPhoto = data[0];
                        this.camera.resolutionVideo = data[0];
                    }
                    data.forEach(resolution => {
                        this.resolutions.push(resolution);
                    })
                })
            });
        },
        add() {
            this.isValidated = true;
            if (!isValid(this.camera.name, $("#name"))) {
                return;
            }
            enableSpinnerButton(false, $("#spinner"), $("#btnAdd"));
            Vue.resource('/api/cameras').save(this.camera)
                .then(result => {
                    this.isValidated = false;
                    this.camera = {};
                    result.json().then(data => {
                        this.cameras.push(data);
                    });
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinner"), $("#btnAdd"));
                    }
                );
        },
        remove(id, position) {
            Vue.resource('/api/cameras{/id}').delete({id: id}).then(result =>
                this.cameras.splice(position, 1)
            );
        },
        update(camera) {
            if (camera.name.isEmpty()) {
                return
            }
            enableSpinnerButton(false, $("#spinner" + camera.id), $("#btnUpdate" + camera.id));
            Vue.resource('/api/cameras{/id}').update({id: camera.id}, camera)
                .then(result => {

                    }
                )
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinner" + camera.id), $("#btnUpdate" + camera.id));
                    }
                );
        },
    }
});