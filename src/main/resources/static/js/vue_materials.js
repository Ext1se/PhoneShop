const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#material-manager',
    data: {
        material: {
            id: 0,
            name: ''
        },
        materials: [],
        isValidated: false
    },
    created: function () {
        Vue.resource('/api/materials').get().then(result => {
            result.json().then(data => {
                data.forEach(material => {
                    this.materials.push(material);
                })
            })
        });
    },
    methods: {
        add() {
            this.isValidated = true;
            if (!isValid(this.material.name, $("#name"))) {
                return;
            }
            enableSpinnerButton(false, $("#spinner"), $("#btnAdd"));
            Vue.resource('/api/materials').save(this.material)
                .then(result => {
                    this.isValidated = false;
                    this.material.name = '';
                    result.json().then(data => {
                        this.materials.push(data);
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
            Vue.resource('/api/materials{/id}').delete({id: id}).then(result =>
                this.materials.splice(position, 1)
            );
        },
        update(material) {
            if (material.name.isEmpty()) {
                return
            }
            enableSpinnerButton(false, $("#spinner" + material.id), $("#btnUpdate" + material.id));
            Vue.resource('/api/materials{/id}').update({id: material.id}, material)
                .then(result => {
                        enableSpinnerButton(false, $("#btnUpdate" + material.id));
                    }
                )
                .catch(error => {
                    enableSpinnerButton(true, $("#btnUpdate" + material.id));
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        showSpinner(false, $("#spinner" + material.id));
                    }
                );
        },
        onChange(material, position) {
            let id = "btnUpdate" + material.id;
            document.getElementById(id).disabled = false;
        }
    }
});