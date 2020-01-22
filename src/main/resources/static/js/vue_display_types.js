const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#display-type-manager',
    data: {
        displayType: {
            id: 0,
            name: ''
        },
        displayTypes: []
    },
    created: function () {
        Vue.resource('/api/display-types').get().then(result => {
            result.json().then(data => {
                data.forEach(displayType => {
                    this.displayTypes.push(displayType);
                })
            })
        });
    },
    methods: {
        addDisplayType() {
            if (this.displayType.name.isEmpty()){
                return
            }
            Vue.resource('/api/display-types').save(this.displayType)
                .then(result => {
                    this.displayType.name = '';
                    result.json().then(data => {
                        this.displayTypes.push(data);
                    })
                })
                .catch(error => {

                })
                .finally(() => {

                    }
                );
        },
        removeDisplayType(id, position) {
            Vue.resource('/api/display-types{/id}').delete({id: id}).then(result =>
                this.displayTypes.splice(position, 1)
            );
        },
        updateDisplayType(displayType) {
            if (displayType.name.isEmpty()){
                return
            }
            Vue.resource('/api/display-types{/id}').update({id: displayType.id}, displayType).then(result => {
                    let id = "btnUpdate" + displayType.id;
                    document.getElementById(id).disabled = true;
                }
            );
        },
        onChange(displayType, position) {
            let id = "btnUpdate" + displayType.id;
            document.getElementById(id).disabled = false;
        }
    }
});