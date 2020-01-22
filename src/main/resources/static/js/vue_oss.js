const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#os-manager',
    data: {
        os: {
            id: 0,
            name: ''
        },
        oss: []
    },
    created: function () {
        Vue.resource('/api/oss').get().then(result => {
            result.json().then(data => {
                data.forEach(os => {
                    this.oss.push(os);
                })
            })
        });
    },
    methods: {
        add() {
            /*   if (this.os.name.isEmpty()) {
                   return
               }*/
            //if (isError(name, document.getElementById("name"))) {
            if (!isValid(this.os.name, $("#name"))) {
                return;
            }
            Vue.resource('/api/oss').save(this.os)
                .then(result => {
                    this.os.name = '';
                    result.json().then(data => {
                        this.oss.push(data);
                    });
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
        remove(id, position) {
            Vue.resource('/api/oss{/id}').delete({id: id}).then(result =>
                this.oss.splice(position, 1)
            );
        },
        update(os) {
            if (os.name.isEmpty()) {
                return
            }
            Vue.resource('/api/oss{/id}').update({id: os.id}, os)
                .then(result => {
                        let id = "btnUpdate" + os.id;
                        document.getElementById(id).disabled = true;
                    }
                )
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {

                    }
                );
        },
        onChange(os, position) {
            let id = "btnUpdate" + os.id;
            document.getElementById(id).disabled = false;
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