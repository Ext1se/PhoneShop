const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#resolution-manager',
    data: {
        resolution: {
            id: 0,
            resolution: '',
            resolutionX: '',
            resolutionY: ''
        },
        resolutions: []
    },
    created: function () {
        Vue.resource('/api/resolutions').get().then(result => {
            result.json().then(data => {
                data.forEach(resolution => {
                    this.resolutions.push(resolution);
                })
            })
        });
    },
    methods: {
        add() {
            if (this.resolution.resolutionX == 0 || this.resolution.resolutionY == 0) {
                return;
            }
            calcResolution(this.resolution);
            Vue.resource('/api/resolutions').save(this.resolution)
                .then(result => {
                    this.resolution.resolutionX = '';
                    this.resolution.resolutionY = '';
                    result.json().then(data => {
                        this.resolutions.push(data);
                    })
                })
                .catch(error => {

                })
                .finally(() => {

                    }
                );
        },
        remove(id, position) {
            Vue.resource('/api/resolutions{/id}').delete({id: id}).then(result =>
                this.resolutions.splice(position, 1)
            );
        },
        update(resolution) {
            if (resolution.resolutionX == 0 || resolution.resolutionY == 0) {
                return;
            }
            calcResolution(resolution);
            Vue.resource('/api/resolutions{/id}').update({id: resolution.id}, resolution).then(result => {
                    let id = "btnUpdate" + resolution.id;
                    document.getElementById(id).disabled = true;
                }
            );
        },
        onChange(resolution, position) {
            let id = "btnUpdate" + resolution.id;
            document.getElementById(id).disabled = false;
        }
    }
});

function calcResolution(resolution) {
    resolution.resolution = Math.ceil((resolution.resolutionX * resolution.resolutionY) / 1000000);
    if (resolution.resolution <= 0) {
        resolution.resolution = 1;
    }
};