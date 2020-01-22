const token = document.getElementById("_csrf").value;
const userId = document.getElementById("userId").value;
const orderId = document.getElementById("orderId").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#order-manager',
    data: {
        stateClass: 'text-secondary',
        order: {
            user:{
                firstName:'',
                lastName:''
            },
            delivery:{
                name:''
            },
            dateOrder: ''
        }
    },
    created: function () {
        this.getOrder();
    },
    mounted: function () {

    },
    methods: {
        getOrderName() {
            return "#" + this.order.id + this.order.dateOrder.replaceAll('.', '').replaceAll(' ', '').replaceAll(':', '');
        },
        getPhoneName(phone) {
            return phone.colorModel.model.name + ", " + phone.os.name + ", " + phone.ram + " Гб х " + phone.storage + " Гб"
        },
        getSum(product) {
            return product.smartPhone.cost * product.count;
        },
        getState(order) {
            let state = order.state;
            let stateName = '';
            switch (state){
                case 'IDLE':
                    this.stateClass = 'text-secondary';
                    stateName = 'Обрабатывается';
                    break;
                case 'PROGRESS':
                    this.stateClass = 'text-info';
                    stateName = 'Выполняется';
                    break;
                case 'COMPLETED':
                    this.stateClass = 'text-success';
                    stateName = 'Завершен';
                    break;
                case 'NEGATIVE':
                    this.stateClass = 'text-danger';
                    stateName = 'Отклонен';
                    break;
                case 'POSITIVE':
                    this.stateClass = 'text-success';
                    stateName = 'Одобрен';
                    break;
                default:
                    this.stateClass = 'text-secondary';
                    stateName = 'Обрабатывается';
                    break;
            }
            return stateName;
        },
        getOrder() {
            Vue.resource('/api/orders{/id}').get({id: orderId})
                .then(result => {
                    result.json().then(data => {
                        this.order = data;
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

        saveOrder(){
            let url = "/api/order/" + this.order.id + "/state/" + this.order.state;
            //Vue.resource('/api/order{/id}/state{/state}').update({id: this.order.id, state: this.order.state})
            //enableSpinnerButton(false, $("#spinner"), $("#btnSave"));
            Vue.resource(url).update()
                .then(result => {
                    alert("Оповещение отправлено пользователю.")
                })
                .catch(error => {
                    error.json().then(data => {
                        alert(data.message);
                    });
                    //enableSpinnerButton(true, $("#spinner"), $("#btnSave"));
                })
                .finally(() => {
                    //enableSpinnerButton(true, $("#spinner"), $("#btnSave"));
                })
        }
    }
});