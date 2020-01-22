const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#gpu-manager',
    data: {
        gpu: {
            id: 0,
            name: ''
        },
        gpunits: [],
        isValidated: false
    },
    created: function () {
        Vue.resource('/api/gpunits').get().then(result => {
            result.json().then(data => {
                data.forEach(gpu => {
                    this.gpunits.push(gpu);
                })
            })
        });
    },
    methods: {
        add() {
            this.isValidated = true;
            if (!isValid(this.gpu.name, $("#name"))) {
                return;
            }
            enableSpinnerButton(false, $("#spinner"), $("#btnAdd"));
            Vue.resource('/api/gpunits').save(this.gpu)
                .then(result => {
                    this.isValidated = false;
                    this.gpu = {};
                    result.json().then(data => {
                        this.gpunits.push(data);
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
            Vue.resource('/api/gpunits{/id}').delete({id: id}).then(result =>
                this.gpunits.splice(position, 1)
            );
        },
        update(gpu) {
            if (gpu.name.isEmpty()) {
                return
            }
            enableSpinnerButton(false, $("#spinner" + gpu.id), $("#btnUpdate" + gpu.id));
            Vue.resource('/api/gpunits{/id}').update({id: gpu.id}, gpu)
                .then(result => {
                        enableSpinnerButton(false, $("#btnUpdate" + gpu.id));
                    }
                )
                .catch(error => {
                    enableSpinnerButton(true, $("#btnUpdate" + gpu.id));
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        showSpinner(false, $("#spinner" + gpu.id));
                    }
                );
        },
        onChange(gpu, position) {
            let id = "btnUpdate" + gpu.id;
            document.getElementById(id).disabled = false;
        }
    }
});