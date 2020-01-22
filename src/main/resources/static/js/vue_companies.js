const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#company-manager',
    data: {
        company: {
            id: 0,
            name: ''
        },
        companies: [],
        isValidated: false
    },
    created: function () {
        Vue.resource('/api/companies').get().then(result => {
            result.json().then(data => {
                data.forEach(company => {
                    this.companies.push(company);
                })
            })
        });
    },
    methods: {
        add() {
            this.isValidated = true;
            if (!isValid(this.company.name, $("#name"))) {
                return;
            }
            enableSpinnerButton(false, $("#spinner"), $("#btnAdd"));
            Vue.resource('/api/companies').save(this.company)
                .then(result => {
                    this.isValidated = false;
                    this.company = {};
                    result.json().then(data => {
                        this.companies.push(data);
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
            Vue.resource('/api/companies{/id}').delete({id: id}).then(result =>
                this.companies.splice(position, 1)
            );
        },
        update(company) {
            if (company.name.isEmpty()) {
                return
            }
            enableSpinnerButton(false, $("#spinner" + company.id), $("#btnUpdate" + company.id));
            Vue.resource('/api/companies{/id}').update({id: company.id}, company)
                .then(result => {
                        enableSpinnerButton(false, $("#btnUpdate" + company.id));
                    }
                )
                .catch(error => {
                    enableSpinnerButton(true, $("#btnUpdate" + company.id));
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        showSpinner(false, $("#spinner" + company.id));
                    }
                );
        },
        onChange(company, position) {
            let id = "btnUpdate" + company.id;
            document.getElementById(id).disabled = false;
        }
    }
});