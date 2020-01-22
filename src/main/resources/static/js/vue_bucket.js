const token = document.getElementById("_csrf").value;
const userId = document.getElementById("userId").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#bucket-manager',
    data: {
        invalidClass: 'is-invalid',
        preOrder: {
            productLines: [],
            address: {
                city: '',
                street: '',
                house: '',
                apartment: ''
            },
            typeDelivery: 0,
            phoneNumber: '',
            sum: '',
            dateDelivery: ''
        },
        dateDelivery: '',
        timeDelivery: ''
    },
    created: function () {
        this.getAllPhones();
        this.getUser();
    },
    mounted: function () {

    },
    methods: {
        /////////////////
        getPhoneName(phone) {
            return phone.colorModel.model.name + ", " + phone.os.name + ", " + phone.ram + " Гб х " + phone.storage + " Гб"
        },
        getFullSum() {
            let sum = 0;
            for (let i = 0; i < this.preOrder.productLines.length; i++) {
                const productLine = this.preOrder.productLines[i];
                sum += productLine.smartPhone.cost * productLine.count;
            }
            return sum;
        },
        getFullSumWithDelivery() {
            let sum = this.getFullSum();
            if (this.preOrder.typeDelivery > 0) {
                sum += 300;
            }
            return sum;
        },
        getImage(photo) {
            return "/img/" + photo.url;
        },
        /////////////////////////////////////////////////////////////////////////////////
        getUser() {
            Vue.resource('/api/user/').get()
                .then(result => {
                    result.json().then(user => {
                        if (user.address != null) {
                            this.preOrder.address = user.address;
                        }
                        if (user.phoneNumber != null) {
                            this.preOrder.phoneNumber = user.phoneNumber;
                        }
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {

                });
        },

        getAllPhones() {
            Vue.resource('/api/order-products/').get()
                .then(result => {
                    result.json().then(data => {
                        data.forEach(phone => {
                            this.preOrder.productLines.push({
                                smartPhone: phone,
                                count: 1
                            });
                            //this.phones.push(phone);
                        })
                    })
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {

                });
        },
        saveOrder() {
            if (!this.isValid()) {
                return;
            }
            if (this.preOrder.typeDelivery > 0) {
                var dateArray = this.dateDelivery.split("-");
                let date = dateArray[2] + "." + dateArray[1] + "." + dateArray[0];
                this.preOrder.dateDelivery = date + " " + this.timeDelivery;
            }
            enableSpinnerButton(false, $("#spinner"), $("#btnSave"));
            this.preOrder.sum = this.getFullSumWithDelivery();
            Vue.resource('/api/order/').save(this.preOrder)
                .then(result => {
                    location.href = 'http://localhost:8080/orders-user/';
                    //this.phones.splice(position, 1);
                    //this.preOrder.productLines.splice(position, 1);
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                    enableSpinnerButton(true, $("#spinner"), $("#btnSave"));
                })
                .finally(() => {
                    enableSpinnerButton(true, $("#spinner"), $("#btnSave"));
                });
        },
        removePhone(phone, position) {
            Vue.resource('/api/order-products{/id}').remove({id: phone.id})
                .then(result => {
                    //this.phones.splice(position, 1);
                    this.preOrder.productLines.splice(position, 1);
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                })
                .finally(() => {

                });
        },

        ////////////////////////////////////
        onDeliveryRadioClick() {
            $('#cardDelivery').collapse('show');
        },

        onShopRadioClick() {
            $('#cardDelivery').collapse('hide');
        },

        isValid() {
            let isValid = true;
            if (this.preOrder.phoneNumber.isEmpty()) {
                $("#phoneNumber").addClass(this.invalidClass);
                isValid = false;
            } else {
                $("#phoneNumber").removeClass(this.invalidClass);
            }

            if (this.preOrder.typeDelivery > 0) {
                if (this.preOrder.address.city.isEmpty()) {
                    $("#addressCity").addClass(this.invalidClass);
                    isValid = false;
                } else {
                    $("#addressCity").removeClass(this.invalidClass);
                }

                if (this.preOrder.address.street.isEmpty()) {
                    $("#addressStreet").addClass(this.invalidClass);
                    isValid = false;
                } else {
                    $("#addressStreet").removeClass(this.invalidClass);
                }

                if (this.preOrder.address.house.isEmpty()) {
                    $("#addressHouse").addClass(this.invalidClass);
                    isValid = false;
                } else {
                    $("#addressHouse").removeClass(this.invalidClass);
                }

                if (this.preOrder.address.apartment.isEmpty()) {
                    $("#addressApartment").addClass(this.invalidClass);
                    isValid = false;
                } else {
                    $("#addressApartment").removeClass(this.invalidClass);
                }

                if (this.dateDelivery.isEmpty()) {
                    $("#dateDelivery").addClass(this.invalidClass);
                    isValid = false;
                } else {
                    $("#dateDelivery").removeClass(this.invalidClass);
                }

                if (this.timeDelivery.isEmpty()) {
                    $("#timeDelivery").addClass(this.invalidClass);
                    isValid = false;
                } else {
                    $("#timeDelivery").removeClass(this.invalidClass);
                }


            }

            return isValid;
        },
    }
});