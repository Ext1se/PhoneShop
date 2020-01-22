<#include "parts/security.ftl">
<#import "parts/common.ftl" as common>
<@common.page true>
<div id="bucket-manager" class="offset-1 col-10">
    <div class="col-12 card mt-4 pt-4 pb-4">
        <div class="col-12 mt-2">
            <h3 class="col text-info">Корзина</h3>
            <div class="col" v-for="(productLine, indexPhone) in preOrder.productLines">
                <div class="row mt-2 mb-2 align-items-center">
                <#--<div class="col-1">
                    <span># {{indexPhone + 1}}</span>
                </div>-->
                    <div class="col-6">
                        <a :href="'/phone/' + productLine.smartPhone.id" class="text-dark" target="_blank">
                            {{getPhoneName(productLine.smartPhone)}}
                        </a>
                    </div>
                    <div class="col-2">
                        <input type="number" class="form-control" min="1" max="10" onkeydown="return false"
                               v-model="productLine.count">
                    </div>
                    <div class="col-2">
                        <h4 class="text-secondary">{{productLine.smartPhone.cost * productLine.count}} &#8381</h4>
                    </div>
                    <div class="col">
                        <button class="btn btn-outline-secondary"
                                v-on:click="removePhone(productLine.smartPhone, indexPhone)">
                            <span class="fas fa-close mr-2"></span>Удалить
                        </button>
                    </div>
                </div>
            </div>
        <#--<div class="offset-8 col">
            <h4 class="text-dark">{{getFullSum()}} &#8381</h4>
        </div>-->
            <div class="col">
                <h3 class="text-dark">Итог: {{getFullSum()}} &#8381</h3>
            </div>
        </div>
    </div>

    <div v-show="preOrder.productLines.length > 0" class="col-12 card mt-4 mb-4 pt-4 pb-4">
        <div class="col-12 mt-2">
            <h3 class="col text-info">Оформление заказа</h3>
            <div class="col form-group">
                <label>Контактный телефон</label>
                <input type="text" class="form-control" id="phoneNumber" placeholder="8-800-555-33-22"
                       v-model="preOrder.phoneNumber">
            </div>
            <div class="col">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="radioShop" name="delivery"
                           value="0" checked
                           v-model="preOrder.typeDelivery"
                           v-on:click="onShopRadioClick()">
                    <label class="form-check-label" for="radioShop">Самовывоз</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="radioDelivery" name="delivery"
                           value="1"
                           v-model="preOrder.typeDelivery"
                           v-on:click="onDeliveryRadioClick()">
                    <label class="form-check-label" for="radioDelivery">Доставка</label>
                </div>
            </div>
            <div class="col mt-2 collapse" id="cardDelivery">
                <div class="row">
                    <div class="form-group col-4">
                        <label>Город</label>
                        <input type="text" name="address.city"
                               v-model="preOrder.address.city"
                               class="form-control"
                               id="addressCity" maxlength="40">
                    </div>

                    <div class="form-group col-4">
                        <label>Улица</label>
                        <input type="text" name="address.street"
                               v-model="preOrder.address.street"
                               class="form-control"
                               id="addressStreet" maxlength="40">
                    </div>

                    <div class="form-group col-2">
                        <label>Дом</label>
                        <input type="text" name="address.house"
                               v-model="preOrder.address.house"
                               class="form-control"
                               id="addressHouse" maxlength="40">
                    </div>

                    <div class="form-group col-2">
                        <label>Квартира</label>
                        <input type="text" name="address.apartment"
                               v-model="preOrder.address.apartment"
                               class="form-control"
                               id="addressApartment" maxlength="40">
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-4">
                        <label>Дата доставка</label>
                        <input type="date"
                               v-model="dateDelivery"
                               class="form-control"
                               id="dateDelivery">
                    </div>

                    <div class="form-group col-4">
                        <label>Время доставки</label>
                        <input type="time"
                               v-model="timeDelivery"
                               class="form-control"
                               id="timeDelivery">
                    </div>
                </div>
            </div>

            <div class="col mt-2">
                <h3 class="text-dark">Итог: {{getFullSumWithDelivery()}} &#8381</h3>
                <button class="btn btn-info mt-2" v-on:click="saveOrder()" id="btnSave">
                    <span class="fas fa-check mr-2"></span>
                    Подтвердить заказ
                </button>
                <span id="spinner" class="spinner-border-sm ml-2 text-primary " role="status"
                      aria-hidden="true"></span>
            </div>
        </div>
    </div>

    <input type="hidden" value="${currentUserId}" id="userId">
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_bucket.js"></script>
</@common.page>