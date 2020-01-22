<#include "parts/security.ftl">
<#import "parts/common.ftl" as common>
<@common.page true>
<div id="order-manager" class="offset-1 col-10">
    <div class="col-12 card mt-4 mb-4 pt-4 pb-4">
        <div class="col-12 mt-2">
            <h4 class="col text-primary">{{getOrderName(order)}}</h4>
            <h5 class="col">Список товаров</h5>
            <div class="col" v-for="(productLine, indexProductLine) in order.products">
                <div class="row mt-2 mb-2 align-items-center">
                    <div class="col-9">
                        {{indexProductLine + 1}}.
                        <a :href="'/phone/' + productLine.smartPhone.id" class="text-dark" target="_blank">
                            {{getPhoneName(productLine.smartPhone)}}
                        </a>
                    </div>
                    <div class="col-1">
                        x {{productLine.count}}
                    </div>
                    <div class="col">
                        {{getSum(productLine)}} &#8381
                    </div>
                </div>
            </div>
            <div class="col">
                <h3 class="text-secondary">Итог: {{order.fullSum}} &#8381</h3>
            </div>

            <div class="dropdown-divider mt-4 mb-4"></div>

            <h5 class="col">Детали заказы</h5>

            <div class="form-group col">
                <label>Дата заказа</label>
                <span class="form-control">{{order.dateOrder}}</span>
            </div>

            <div class="col">
                <div class="row">
                    <div class="form-group col">
                        <label>Имя</label>
                        <span class="form-control">{{order.user.firstName}}</span>
                    </div>
                    <div class="form-group col">
                        <label>Фамилия</label>
                        <span class="form-control">{{order.user.lastName}}</span>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="row">
                    <div class="form-group col">
                        <label>Электронный адрес</label>
                        <span class="form-control">{{order.user.email}}</span>
                    </div>
                    <div class="form-group col">
                        <label>Контактный телефон</label>
                        <span class="form-control" id="phoneNumber"
                              placeholder="8-800-555-33-22">{{order.phoneNumber}} </span>
                    </div>
                </div>
            </div>

            <div class="col form-group">
                <label>Тип доставки</label>
                <span class="form-control">{{order.delivery.name}}</span>
            </div>
            <div v-if="order.address != null" class="col mt-2" id="cardDelivery">
                <div class="row">
                    <div class="form-group col-4">
                        <label>Город</label>
                        <span name="address.city" class="form-control"
                              id="addressCity">{{order.address.city}}</span>
                    </div>

                    <div class="form-group col-4">
                        <label>Улица</label>
                        <span name="address.street" class="form-control" id="addressStreet">
                            {{order.address.street}}</span>
                    </div>

                    <div class="form-group col-2">
                        <label>Дом</label>
                        <span name="address.house" class="form-control"
                              id="addressHouse">{{order.address.house}}</span>
                    </div>

                    <div class="form-group col-2">
                        <label>Квартира</label>
                        <span name="address.apartment" class="form-control"
                              id="addressApartment">{{order.address.apartment}}</span>
                    </div>
                </div>
                <div class="form-group">
                    <label>Дата доставка</label>
                    <span class="form-control"
                          id="dateDelivery">{{order.dateDelivery}}</span>
                </div>
            </div>
            <#if isAdmin>
            <div class="col">
                <div class="form-group">
                    <label>Статус заказа</label>
                    <div class="row">
                        <div class="col-8">
                            <select class="custom-select" v-model="order.state">
                                <option value="IDLE">Обработать</option>
                                <option value="PROGRESS">Одобрить</option>
                                <option value="NEGATIVE">Отказать</option>
                                <option value="COMPLETED">Завершить</option>
                            </select>
                        </div>
                        <div class="col row">
                            <button class="col btn btn-outline-primary" id="btnSave" v-on:click="saveOrder()">
                                Изменить статус
                            </button>
                            <span id="spinner" class="spinner-border-sm ml-2 text-primary" role="status"
                                  aria-hidden="true"></span>
                        </div>

                    </div>
                </div>
            </#if>
            </div>
        </div>


        <input type="hidden" value="${order.id}" id="orderId">
        <input type="hidden" value="${currentUserId}" id="userId">
        <input type="hidden" value="${_csrf.token}" id="_csrf">
        <script src="/js/vue_order.js"></script>
</@common.page>