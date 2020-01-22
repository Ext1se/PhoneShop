const token = document.getElementById("_csrf").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#display-manager',
    data: {
        display: {
            id: 0,
            name: '',
            diagonal: '',
            density: '',
            idDisplayType: 0,
            idResolution: 0
        },
        displays: [],
        resolutions: [],
        displayTypes: [],
        isValidated: false,
        spinnerClass: 'spinner-border'
    },
    created: function () {
        Vue.resource('/api/displays').get().then(result => {
            result.json().then(data => {
                data.forEach(display => {
                    this.displays.push(display);
                })
            })
        });
        this.getResolutions();
        this.getDisplayTypes();
    },
    methods: {
        updateData() {
            this.getDisplayTypes();
            this.getResolutions();
        },
        getDisplayTypes() {
            this.displayTypes = [];
            Vue.resource('/api/display-types').get().then(result => {
                result.json().then(data => {
                    if (data.length > 0) {
                        this.display.displayType = data[0];
                    }
                    data.forEach(displayType => {
                        this.displayTypes.push(displayType);
                    })
                })
            });
        },
        getResolutions() {
            this.resolutions = [];
            Vue.resource('/api/resolutions').get().then(result => {
                result.json().then(data => {
                    if (data.length > 0) {
                        this.display.resolution = data[0];
                    }
                    data.forEach(resolution => {
                        this.resolutions.push(resolution);
                    })
                })
            });
        },
        add() {
            this.isValidated = true;
            if (!isValid(this.display.name, $("#name"))) {
                return;
            }
            enableButton(false, $("#spinner"), $("#btnAdd"));
            Vue.resource('/api/displays').save(this.display)
                .then(result => {
                    this.isValidated = false;
                    this.display.name = '';
                    this.display.density = '';
                  //  this.display.diagonal = '';
                    result.json().then(data => {
                        this.displays.push(data);
                    });
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableButton(true, $("#spinner"), $("#btnAdd"));
                    }
                );
        },
        remove(id, position) {
            Vue.resource('/api/displays{/id}').delete({id: id}).then(result =>
                this.displays.splice(position, 1)
            );
        },
        update(display) {
            if (display.name.isEmpty()) {
                return
            }
            enableButton(false, $("#spinner" + display.id), $("#btnUpdate" + display.id));
            Vue.resource('/api/displays{/id}').update({id: display.id}, display)
                .then(result => {

                    }
                )
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message)
                    });
                })
                .finally(() => {
                        enableButton(true, $("#spinner" + display.id), $("#btnUpdate" + display.id));
                    }
                );
        },
        onChange(display, position) {
            //let id = "btnUpdate" + display.id;
            //document.getElementById(id).disabled = false;
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

function enableButton(isEnabled, viewSpinner, viewButton) {
    let spinnerClass = 'spinner-border';
    if (!isEnabled) {
        viewButton.prop("disabled", true);
        viewSpinner.addClass(spinnerClass);
    } else {
        viewButton.prop("disabled", false);
        viewSpinner.removeClass(spinnerClass);
    }
}