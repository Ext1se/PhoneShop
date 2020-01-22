<#include "parts/security.ftl">
<#import "parts/common.ftl" as common>
<@common.page true>
<div id="orders-manager" class="offset-1 col-10">
    <div class="col-12 card mt-4 pt-4 pb-4">
        <div class="col-12 mt-2">
            <h3 class="col ml-3">Все заказы</h3>
            <span v-show="orders.length == 0" class="col ml-3">Пока ничего нет</span>
            <div v-for="(order, indexOrder) in orders" class="col mt-4 mb-4">
                <a :href="'/orders/' + order.id"><h4 class="col">{{getOrderName(order)}}</h4></a>
                <div class="col">
                    <span>{{order.user.username}}, {{order.user.firstName}} {{order.user.lastName}}</span>
                </div>
                <div class="col row" v-for="(productLine, indexProductLine) in order.products">
                    <div class="col-9">
                        {{indexProductLine + 1}}. {{getPhoneName(productLine.smartPhone)}}
                    </div>
                    <div class="col-1">
                        x {{productLine.count}}
                    </div>
                    <div class="col">
                        {{getSum(productLine)}} &#8381
                    </div>
                </div>
                <h5 class="col text-dark mb-0">Итог: {{order.fullSum}} &#8381</h5>
                <span :class="['col', getState(order)[0]]">{{getState(order)[1]}}</span>
            <#--<div class="col">
                <span style="font-size: 140%" class=" text-dark">Итог: {{order.fullSum}} &#8381</span>
            </div>
            <div class="col">
                <span class=" text-secondary">Статус: не активен</span>
            </div>-->
                <div class="dropdown-divider mt-2"></div>
            </div>
        </div>
    </div>


    <input type="hidden" value="${currentUserId}" id="userId">
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_orders.js"></script>
</@common.page>