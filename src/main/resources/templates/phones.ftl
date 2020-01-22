<#include "parts/security.ftl">
<#import "parts/common.ftl" as common>
<@common.page true>
<div id="models-manager">

<#-- <div class="offset-2 col-10 input-group">
     <input type="text" class="form-control" placeholder="Название модели"
            v-model="searchName"
            aria-describedby="buttons">
     <div class="input-group-append" id="buttons">
         <button class="btn btn-outline-primary"
                 v-on:click="getPhonesByName">
             <span class="fas fa-search mr-2"></span>Найти
         </button>
     </div>
 </div>-->

<#--    <div class="mt-4 form-row">
        <div>
            <button class="btn btn-outline-secondary"
                    onclick="window.open('http://localhost:8080/admin/model')">
                <span class="fas fa-plus mr-2"></span>Добавить новую модель
            </button>
        </div>
    </div>-->

    <div class="row mt-4 align-self-start">
        <div class="card  col-3 mt-2 mb-2 align-self-baseline">
            <div class="mt-2">
                <span class="fas fa-sm fa-filter mr-2 text-secondary"></span>
                <span class="text-secondary" style="font-size: 110%;">Фильтры</span>
                <div class="dropdown-divider"></div>
            </div>
        <#--Компании-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#companyFilter"
                     aria-expanded="false" aria-controls="companyFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Производитель</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="companyFilter" class="overflow-auto collapse" style="max-height: 200px;">
                <#--  <div class="form-group form-check">
                      <input type="checkbox" class="form-check-input" id="companyAll"
                             :value="companies"
                             v-model="filter.companies">
                      <label class="form-check-label" for="companyAll">Все</label>
                  </div>-->
                    <div class="form-group form-check" v-for="(company, index) in companies">
                        <input type="checkbox" class="form-check-input" :id="'company' + index"
                               :value="company"
                               v-model="filter.companies">
                        <label class="form-check-label" :for="'company' + index">{{company.name}}</label>
                    </div>
                </div>
            </div>
        <#--<span>{{filter.companies}}</span>-->
        <#--ОСи-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#osFilter"
                     aria-expanded="false" aria-controls="osFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Операционная система</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="osFilter" class="overflow-auto collapse" style="max-height: 200px;">
                    <div class="form-group form-check" v-for="(os, index) in oss">
                        <input type="checkbox" class="form-check-input" :id="'os' + index"
                               :value="os"
                               v-model="filter.oss">
                        <label class="form-check-label" :for="'os' + index">{{os.name}}</label>
                    </div>
                </div>
            </div>
        <#--Цвета-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#colorFilter"
                     aria-expanded="false" aria-controls="colorFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Цвет</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="colorFilter" class="overflow-auto collapse" style="max-height: 200px;">
                    <div class="form-group form-check" v-for="(color, index) in colors">
                        <input type="checkbox" class="form-check-input" :id="'color' + index"
                               :value="color"
                               v-model="filter.colors">
                        <img src="" class="rounded-circle" width="10" height="10"
                             :style="{'background-color': color.value}">

                        <label class="form-check-label" :for="'color' + index">{{color.name}}</label>
                    </div>
                </div>
            </div>
        <#--ЦП-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#cpuFilter"
                     aria-expanded="false" aria-controls="cpuFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Процессор</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="cpuFilter" class="overflow-auto collapse" style="max-height: 200px;">
                    <div class="form-group form-check" v-for="(cpu, index) in cpunits">
                        <input type="checkbox" class="form-check-input" :id="'cpu' + index"
                               :value="cpu"
                               v-model="filter.cpunits">
                        <label class="form-check-label" :for="'cpu' + index">{{cpu.name}}</label>
                    </div>
                </div>
            </div>
        <#--Типы дисплеев-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#typeDisplayFilter"
                     aria-expanded="false" aria-controls="typeDisplayFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Тип дисплея</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="typeDisplayFilter" class="overflow-auto collapse" style="max-height: 200px;">
                    <div class="form-group form-check" v-for="(typeDisplay, index) in displayTypes">
                        <input type="checkbox" class="form-check-input" :id="'typeDisplay' + index"
                               :value="typeDisplay"
                               v-model="filter.displayTypes">
                        <label class="form-check-label" :for="'typeDisplay' + index">{{typeDisplay.name}}</label>
                    </div>
                </div>
            </div>
        <#--Разрешение экрана-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#resolutionDisplayFilter"
                     aria-expanded="false" aria-controls="resolutionDisplayFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Разрешение дисплея</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="resolutionDisplayFilter" class="overflow-auto collapse" style="max-height: 200px;">
                    <div class="form-group form-check" v-for="(resolutionDisplay, index) in resolutions">
                        <input type="checkbox" class="form-check-input" :id="'resolutionDisplay' + index"
                               :value="resolutionDisplay"
                               v-model="filter.resolutions">
                        <label class="form-check-label" :for="'resolutionDisplay' + index">{{resolutionDisplay.resolutionX}}
                            x {{resolutionDisplay.resolutionY}}</label>
                    </div>
                </div>
            </div>
        <#--Материал-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#materialFilter"
                     aria-expanded="false" aria-controls="materialFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Корпус</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="materialFilter" class="overflow-auto collapse" style="max-height: 200px;">
                    <div class="form-group form-check" v-for="(material, index) in materials">
                        <input type="checkbox" class="form-check-input" :id="'material' + index"
                               :value="material"
                               v-model="filter.materials">
                        <label class="form-check-label" :for="'material' + index">{{material.name}}</label>
                    </div>
                </div>
            </div>
        <#--Оперативная память-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#ramFilter"
                     aria-expanded="false" aria-controls="ramFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Оперативная память</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="ramFilter" class="row justify-content-center collapse show">
                    <div class="col-6 form-group">
                        <label>От</label>
                        <input type="number" class="form-control" min="1" max="32" placeholder="1 ГБ"
                               v-model="filter.ramFrom">
                    </div>

                    <div class="col-6 form-group">
                        <label>До</label>
                        <input type="number" class="form-control" min="1" max="32" placeholder="8 ГБ"
                               v-model="filter.ramTo">
                    </div>
                </div>
            </div>
        <#--Основная память-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#storageFilter"
                     aria-expanded="false" aria-controls="storageFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Основная память</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="storageFilter" class="row justify-content-center collapse show">
                    <div class="col-6 form-group">
                        <label>От</label>
                        <input type="number" class="form-control" min="1" max="1024" placeholder="1 ГБ"
                               v-model="filter.storageFrom">
                    </div>

                    <div class="col-6 form-group">
                        <label>До</label>
                        <input type="number" class="form-control" min="1" max="1024" placeholder="32 ГБ"
                               v-model="filter.storageTo">
                    </div>
                </div>
            </div>
        <#--Стоимость-->
            <div class="mt-2">
                <div data-toggle="collapse" href="#costFilter"
                     aria-expanded="false" aria-controls="costFilter">
                    <label>
                        <span class="fas fa-sm fa-list mr-2 text-secondary"></span>
                        <span class="text-secondary">Стоимость</span>
                    </label>
                    <div class="dropdown-divider"></div>
                </div>
                <div id="costFilter" class="row justify-content-center collapse show">
                    <div class="col-6 form-group">
                        <label>От</label>
                        <input type="number" class="form-control" min="1" placeholder="1 руб" v-model="filter.costFrom">
                    </div>

                    <div class="col-6 form-group">
                        <label>До</label>
                        <input type="number" class="form-control" min="1" placeholder="1000000 руб"
                               v-model="filter.costTo">
                    </div>
                </div>
            </div>
        <#--<span>{{filter.oss}}</span>-->
            <button class="w-100 btn btn-sm btn-outline-secondary mt-2"
                    v-on:click="getPhonesByFilter">Применить
            </button>
            <button class="w-100 btn btn-sm btn-outline-danger mt-2 mb-4"
                    v-on:click="clearFilters">Очистить
            </button>
        </div>

        <div class="col-9 align-self-start">
            <div class="w-100 mt-2 input-group">
                <input type="text" class="form-control" placeholder="Название модели"
                       v-model="searchName"
                       aria-describedby="buttons">
                <div class="input-group-append" id="buttons">
                    <button class="btn btn-primary"
                            v-on:click="getPhonesByName">
                        <span class="fas fa-search mr-2"></span>Найти
                    </button>
                </div>
            </div>

            <div class="card mt-2 mb-2 col-12" v-for="(phone, indexPhone) in phones">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-2">
                            <img class="card-img-top"
                                 :src="getImage(phone)">
                        </div>
                        <div class="col-10">
                            <div>
                                <h5>
                                    <a v-bind:href="'phone/' + phone.id">{{getModelName(phone)}}</a>
                                </h5>
                            </div>
                            <div>
                                <span>{{getModelDescription(phone)}}
                                </span>
                            </div>
                            <div class="row mt-2">
                                <div class="col-6">
                                    <span class="text-secondary" style="font-size: 120%;">
                                        {{phone.cost}} &#8381
                                    </span>
                                </div>
                                <#if user??>
                                <div class="row col-6 justify-content-end">
                                    <button :id="'btnBuy' + indexPhone" class="btn btn-sm btn-outline-info"
                                            v-if="!checkExistPhone(phone)"
                                            v-on:click="buyPhone(phone)">
                                        <span class="fas fa-plus mr-1"></span>
                                        Добавить в корзину
                                    </button>

                                    <button id="btnBucket" class="btn btn-sm btn-info"
                                            v-else
                                            v-on:click="openUrl()">
                                        <span class="fas fa-check mr-1"></span>
                                        Перейти в корзину
                                    </button>
                                </div>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <input type="hidden" value="${currentUserId}" id="userId">
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_phones.js"></script>
</@common.page>