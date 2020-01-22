const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#cpu-manager',
    data: {
        cpu: {
            id: 0,
            name: '',
            frequency: '',
            beans: '',
            size: '',
            bit: 64
        },
        cpunits: [],
        isValidated: false
    },
    created: function () {
        Vue.resource('/api/cpunits').get().then(result => {
            result.json().then(data => {
                data.forEach(cpu => {
                    this.cpunits.push(cpu);
                })
            })
        });
    },
    methods: {
        add() {
            this.isValidated = true;
            if (!isValid(this.cpu.name, $("#name"))) {
                return;
            }
            enableSpinnerButton(false, $("#spinner"), $("#btnAdd"));
            Vue.resource('/api/cpunits').save(this.cpu)
                .then(result => {
                    this.isValidated = false;
                    this.cpu = {};
                    this.cpu.bit = 64;
                    result.json().then(data => {
                        this.cpunits.push(data);
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
            Vue.resource('/api/cpunits{/id}').delete({id: id}).then(result =>
                this.cpunits.splice(position, 1)
            );
        },
        update(cpu) {
            if (cpu.name.isEmpty()) {
                return
            }
            enableSpinnerButton(false, $("#spinner" + cpu.id), $("#btnUpdate" + cpu.id));
            Vue.resource('/api/cpunits{/id}').update({id: cpu.id}, cpu)
                .then(result => {

                    }
                )
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableSpinnerButton(true, $("#spinner" + cpu.id), $("#btnUpdate" + cpu.id));
                    }
                );
        }
    }
});