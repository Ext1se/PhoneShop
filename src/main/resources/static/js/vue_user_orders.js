const token = document.getElementById("_csrf").value;
const userId = document.getElementById("userId").value;
Vue.http.headers.common['X-CSRF-TOKEN'] = token;

var app = new Vue({
    el: '#orders-manager',
    data: {
        stateClass: 'text-secondary',
        orders: []
    },
    created: function () {
        this.getOrders();
    },
    mounted: function () {

    },
    methods: {
        getOrderName(order) {
            return "#" + order.id + order.dateOrder.replaceAll('.', '').replaceAll(' ', '').replaceAll(':', '');
        },
        getPhoneName(phone) {
            return phone.colorModel.model.name + ", " + phone.os.name + ", " + phone.ram + " Гб х " + phone.storage + " Гб"
        },
        getSum(product) {
            return product.smartPhone.cost * product.count;
        },
        getState(order) {
            /*IDLE("Не активен"),
                PROGRESS("Выполняется"),
                COMPLETED("Завершен"),
                NEGATIVE("Отклонен"),
                POSITIVE("Одобрен");*/
            let stateClass = 'text-secondary';
            let state = order.state;
            let stateName = '';
            let attributes = [];
            switch (state) {
                case 'IDLE':
                    stateClass = 'text-secondary';
                    stateName = 'Обрабатывается';
                    break;
                case 'PROGRESS':
                    stateClass = 'text-info';
                    stateName = 'Выполняется';
                    break;
                case 'COMPLETED':
                    stateClass = 'text-success';
                    stateName = 'Завершен';
                    break;
                case 'NEGATIVE':
                    stateClass = 'text-danger';
                    stateName = 'Отклонен';
                    break;
                case 'POSITIVE':
                    stateClass = 'text-success';
                    stateName = 'Одобрен';
                    break;
                default:
                    stateClass = 'text-secondary';
                    stateName = 'Обрабатывается';
                    break;
            }
            attributes.push(stateClass);
            attributes.push(stateName);
            return attributes;
        },
        getOrders() {
            Vue.resource('/api/orders-user/').get()
                .then(result => {
                    result.json().then(data => {
                        data.forEach(order => {
                            this.orders.push(order);
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
    }
});