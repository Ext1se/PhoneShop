const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#color-manager',
    data: {
        color: {
            id: 0,
            value: '#000a12',
            name: ''
        },
        colors: []
    },
    created: function () {
        Vue.resource('/api/colors').get().then(result => {
            result.json().then(data => {
                data.forEach(color => {
                    this.colors.push(color);
                })
            })
        });
    },
    methods: {
        addColor() {
            if (this.color.name.isEmpty()){
                return
            }
            Vue.resource('/api/colors').save(this.color)
                .then(result => {
                    this.color.name = '';
                    result.json().then(data => {
                        this.colors.push(data);
                    })
                })
                .catch(error => {

                })
                .finally(() => {

                    }
                );
        },
        removeColor(id, position) {
            Vue.resource('/api/colors{/id}').delete({id: id}).then(result =>
                this.colors.splice(position, 1)
            );
        },
        updateColor(color) {
            if (color.name.isEmpty()){
                return
            }
            Vue.resource('/api/colors{/id}').update({id: color.id}, color).then(result => {
                    let id = "btnUpdate" + color.id;
                    document.getElementById(id).disabled = true;
                }
            );
        },
        onChange(color, position) {
            let id = "btnUpdate" + color.id;
            document.getElementById(id).disabled = false;
        }
    }
});