<#import "parts/common.ftl" as common>

<@common.page true>

<div id="model-manager" class="mb-4">


<#-- Модель телефона -->
    <div class="card mt-4" id="cardModel">
        <div class="card-header bg-white" data-toggle="collapse" href="#bodyCardModel"
             aria-expanded="false"
             aria-controls="bodyCardModel">
            <h5 class="col align-middle mt-2">Модель</h5>
        </div>
    <#-- collapse show -->
        <div class="card-body collapse show" id="bodyCardModel">
        <#--Название-->
            <div class="col-12">
                <label for="name">Название</label>
                <input id="name" class="form-control" type="text"
                       placeholder="Название модели"
                       v-bind:class="{'is-invalid':(model.name == '' && isValidated)}"
                       v-on:change="onChangeModel()"
                       v-model="model.name" required>
            </div>
        <#--Описание-->
            <div class="col-12 mt-2">
                <label for="description">Описание</label>
                <textarea name="description" class="form-control" id="description"
                          placeholder="Описание модели и дополнительная информация"
                          v-on:change="onChangeModel()"
                          v-model="model.description"></textarea>
            </div>
        <#--Параметры (ширина, высота и другие)-->
            <div class="col-12 mt-2">
                <div class="form-row">
                    <div class="col-2">
                        <label for="width">Ширина</label>
                        <input id="width" class="form-control" type="number" min="0" max="1000"
                               placeholder="50 мм."
                               v-on:change="onChangeModel()"
                               v-model="model.width">
                    </div>
                    <div class="col-2">
                        <label for="height">Высота</label>
                        <input id="height" class="form-control" type="number" min="0" max="1000"
                               placeholder="100 мм."
                               v-on:change="onChangeModel()"
                               v-model="model.height">
                    </div>
                    <div class="col-2">
                        <label for="weight">Вес</label>
                        <input id="weight" class="form-control" type="number" min="0" max="10000"
                               placeholder="200 г."
                               v-on:change="onChangeModel()"
                               v-model="model.weight">
                    </div>
                    <div class="col-2">
                        <label for="countSim">Количество SIM-карт</label>
                        <input id="countSim" class="form-control" type="number" min="1" max="4"
                               placeholder="2"
                               v-on:change="onChangeModel()"
                               v-model="model.countSim">
                    </div>
                    <div class="col-4">
                        <label for="power">Емкость аккумулятора</label>
                        <input id="power" class="form-control" type="number" min="0" max="50000"
                               placeholder="4000 mAh"
                               v-on:change="onChangeModel()"
                               v-model="model.power">
                    </div>
                </div>
            </div>
        <#--Производитель-->
            <div class="col-12 mt-2">
                <label for="company">Производитель</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="company" class="custom-select" v-model="model.company"
                                v-on:change="onChangeModel()">
                            <option v-for="company in companies" v-bind:value="company">
                                {{getCompanyOptionName(company)}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateCompanies" class="btn btn-outline-info mr-2"
                                v-on:click="getCompanies">
                            <span class="fas fa-redo"></span>
                        </button>
                    <#--v-on:click="addCompany"-->
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/companies')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerCompany" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--CPU-->
            <div class="col-12 mt-2">
                <label for="cpu">CPU</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="cpu" class="custom-select" v-model="model.cpu"
                                v-on:change="onChangeModel()">
                            <option v-for="cpu in cpunits" v-bind:value="cpu">
                                {{getCpuOptionName(cpu)}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateCpunits" class="btn btn-outline-info mr-2"
                                v-on:click="getCpunits">
                            <span class="fas fa-redo"></span>
                        </button>
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/cpunits')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerCpu" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--GPU-->
            <div class="col-12 mt-2">
                <label for="gpu">GPU</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="gpu" class="custom-select" v-model="model.gpu"
                                v-on:change="onChangeModel()">
                            <option v-for="gpu in gpunits" v-bind:value="gpu">
                                {{getGpuOptionName(gpu)}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateGpunits" class="btn btn-outline-info mr-2"
                                v-on:click="getGpunits">
                            <span class="fas fa-redo"></span>
                        </button>
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/gpunits')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerGpu" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--Дисплей-->
            <div class="col-12 mt-2">
                <label for="display">Дисплей</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="display" class="custom-select" v-model="model.display"
                                v-on:change="onChangeModel()">
                            <option v-for="display in displays" v-bind:value="display">
                                {{getDisplayOptionName(display)}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateDisplays" class="btn btn-outline-info mr-2"
                                v-on:click="getDisplays">
                            <span class="fas fa-redo"></span>
                        </button>
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/displays')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerDisplay" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--Основная камера-->
            <div class="col-12 mt-2">
                <label for="mainCamera">Основная камера</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="mainCamera" class="custom-select" v-model="model.mainCamera"
                                v-on:change="onChangeModel()">
                            <option v-for="camera in cameras" v-bind:value="camera">
                                {{getCameraOptionName(camera)}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateCameras" class="btn btn-outline-info mr-2"
                                v-on:click="getCameras">
                            <span class="fas fa-redo"></span>
                        </button>
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/cameras')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerMainCamera" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--Дополнительная камера-->
            <div class="col-12 mt-2">
                <label for="addCamera">Дополнительная камера</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="addCamera" class="custom-select" v-model="model.addCamera"
                                v-on:change="onChangeModel()">
                            <option v-for="camera in cameras" v-bind:value="camera">
                                {{getCameraOptionName(camera)}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateCameras" class="btn btn-outline-info mr-2"
                                v-on:click="getCameras">
                            <span class="fas fa-redo"></span>
                        </button>
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/cameras')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerAddCamera" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--Корпус-->
            <div class="col-12 mt-2">
                <label for="material">Корпус</label>
                <div class="form-row">
                    <div class="col-10">
                        <select id="material" class="custom-select" v-model="model.material"
                                v-on:change="onChangeModel()">
                            <option v-for="material in materials" v-bind:value="material">
                                {{material.name}}
                            </option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button id="btnUpdateMaterials" class="btn btn-outline-info mr-2"
                                v-on:click="getMaterials">
                            <span class="fas fa-redo"></span>
                        </button>
                        <button class="btn btn-outline-success"
                                onclick="window.open('http://localhost:8080/admin/materials')"
                                target="_blank">
                            <span class="fas fa-plus"></span>
                        </button>
                        <span id="spinnerMaterial" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        <#--Сохранение и обновление-->
            <div class="row mt-4">
                <div class="col-6">
                    <div class="col-auto align-self-center">
                        <span id="infoCardModel"></span>
                    </div>
                </div>
                <div class="col-6">
                    <div class="row justify-content-end">
                        <div class="col-auto">
                            <span id="spinnerModel" class="spinner-border-sm mr-2" role="status"
                                  aria-hidden="true"></span>
                            <button class="btn btn-outline-info" v-on:click="updateData">
                                <span class="fas fa-redo mr-2"></span>Обновить зависимости
                            </button>
                            <button id="btnSaveModel" class="btn btn-outline-success" v-on:click="saveModel"
                                   <#-- :disabled="model.id != -1"-->
                            >
                                <span class="fas fa-save mr-2"></span>Сохранить
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>





<#-- Цветовые схемы -->
    <div class="card  mt-4" id="cardColorModel">
        <div class="card-header bg-white" data-toggle="collapse" href="#bodyCardColorModel" aria-expanded="false"
             aria-controls="bodyCardColorModel">
            <h5 class="col align-middle mt-2">Цветовые схемы</h5>

        </div>
        <div v-if="model.id && model.id != -1" class="card-body collapse show" id="bodyCardColorModel">
            <div class="col">
                <button class="btn btn-outline-dark mr-2" v-on:click="addEmptyColorModel">
                    <span class="fas fa-plus mr-2"></span>Добавить цветовую схему
                </button>
                <button class="btn btn-outline-info mr-2" v-on:click="getColors">
                    <span class="fas fa-redo mr-2"></span>Обновить цвета
                </button>
                <button class="btn btn-outline-success mr-2"
                        onclick="window.open('http://localhost:8080/admin/colors')">
                    <span class="fas fa-plus mr-2"></span>Добавить цвет
                </button>
                <span id="spinnerColor" class="spinner-border-sm mr-2" role="status" aria-hidden="true"></span>
            </div>
            <div class="card  mt-4 mb-2 pt-2 pb-2"
                 v-for="(colorModel, index) in colorModels">
                <div class="col">
                    <h5 class="mt-2">{{colorModel.color.name}}</h5>
                </div>
                <div class="col-12">
                    <div class="form-row">
                        <div class="col-1">
                            <div class="col-12 h-100 rounded"
                                 v-bind:style="{'border-style': 'solid', 'border-width': '1pt', 'border-color':'black',
                            'background-color': getColorValue(colorModel.color)}">
                            </div>
                        </div>
                        <div class="col-8">
                            <select :id="'colorTheme' + index" class="custom-select"
                                    v-model="colorModel.color"
                                    v-on:change="onColorChange(colorModel, index)">
                                <option v-for="color in colors" v-bind:value="color">
                                    {{color.name}}
                                </option>
                            </select>
                        </div>
                        <div class="col-3">
                            <div class="row justify-content-end">
                                <div class="col-12">
                                    <button class="w-100 btn btn-outline-dark" v-on:click="openFile(colorModel, index)">
                                        <span class="fas fa-plus mr-2"></span>Добавить фотографию
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-4" v-for="(photo, indexPhoto) in colorModel.photos">
                        <div class="mt-2 mb-2">
                            <div class="text-right">
                                <span class="fas fa-close text-right mr-4"
                                      v-on:click="removePhoto(colorModel, photo, indexPhoto)"></span>
                            </div>
                            <div>
                                <img v-show="photo.url" :src="photo.url" height="256px"/>
                            </div>
                        </div>
                    </div>
                </div>
            <#--Сохранение и обновление-->
                <div class="col-12">
                    <div class="row justify-content-end">
                        <div class="col-auto">
                            <input :id="'file' + index" type="file" @change="onImagesChange($event, colorModel)"
                                   multiple
                                   style="visibility: hidden">
                            <span :id="'spinnerColorModel' + index" class="spinner-border-sm mr-2" role="status"
                                  aria-hidden="true"></span>
                            <button :id="'btnRemoveColorModel' + index" class="btn btn-outline-danger mr-2"
                                    v-on:click="removeColorModel(colorModel, index)">
                                <span class="fas fa-close mr-2"></span>Удалить
                            </button>
                            <button :id="'btnSaveColorModel' + index" class="btn btn-outline-success"
                                    v-on:click="saveColorModel(colorModel, index)"
                                    <#--:disabled="colorModel.id"-->
                            >
                                <span class="fas fa-save mr-2"></span>Сохранить
                            </button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>








<#-- Конфигурации  -->
    <div class="card mt-4" id="cardConfigurationModel">
        <div class="card-header bg-white" data-toggle="collapse" href="#bodyCardConfigurationModel" aria-expanded="false"
             aria-controls="bodyCardConfigurationModel">
            <h5 class="col align-middle mt-2">Конфигурации</h5>

        </div>
        <div v-if="colorModels.length > 0" class="card-body collapse show" id="bodyCardConfigurationModel">
            <div class="col">
                <button class="btn btn-outline-dark mr-2" v-on:click="addEmptyConfiguration">
                    <span class="fas fa-plus mr-2"></span>Добавить конфигурацию
                </button>
                <button class="btn btn-outline-info mr-2" v-on:click="getOss">
                    <span class="fas fa-redo mr-2"></span>Обновить ОСи
                </button>
                <button class="btn btn-outline-success mr-2"
                        onclick="window.open('http://localhost:8080/oss')">
                    <span class="fas fa-plus mr-2"></span>Добавить ОС
                </button>
                <span id="spinnerConfiguration" class="spinner-border-sm mr-2" role="status" aria-hidden="true"></span>
            </div>
            <div class="card  mt-4 mb-2 pt-2 pb-2"
                 v-for="(configuration, index) in configurations">
            <#--<div class="col">
                <h5 class="mt-2">№ {{index}}: {{configuration.colorModel.color.name}}
                    {{configuration.ram}} ГБ + {{configuration.storage}} ГБ</h5>
            </div>-->
                <div class="col">
                    <h5 class="mt-2">№ {{index + 1}}</h5>
                </div>
            <#--Параметры (ram storage cost)-->
                <div class="col-12 mt-2">
                    <div class="form-row">
                        <div class="col-3">
                            <label :for="'confColorModel'+index">Цветовая схема</label>
                            <select :id="'confColorModel' + index" class="custom-select"
                                    v-model="configuration.colorModel"
                                    v-on:change="onConfigurationChange(configuration, index)">
                            <#--<option v-for="colorModel in getColorModels()" v-bind:value="colorModel"-->
                            <#--:disabled="!colorModel.id"-->
                                <option v-for="colorModel in colorModels"
                                        v-bind:value="colorModel">
                                    {{colorModel.color.name}}
                                </option>
                            </select>
                        </div>
                        <div class="col-3">
                            <label :for="'confOs'+index">ОС</label>
                            <select :id="'confOs' + index" class="custom-select"
                                    v-model="configuration.os"
                                    v-on:change="onConfigurationChange(configuration, index)">
                                <option v-for="os in oss" v-bind:value="os">
                                    {{os.name}}
                                </option>
                            </select>
                        </div>
                        <div class="col-2">
                            <label :for="'confRam'+index">Оперативная память</label>
                            <input :id="'confRam' + index" class="form-control" type="number" min="1" max="20"
                                   placeholder="2 ГБ"
                                   v-model="configuration.ram"
                                   v-on:change="onConfigurationChange(configuration, index)"
                            >
                        </div>
                        <div class="col-2">
                            <label :for="'confStorage'+index">Внутренняя память</label>
                            <input :id="'confStorage'+index" class="form-control" type="number" min="1" max="2000"
                                   placeholder="32 ГБ"
                                   v-model="configuration.storage"
                                   v-on:change="onConfigurationChange(configuration, index)"
                            >
                        </div>
                        <div class="col-2">
                            <label :for="'confCost' + index">Стоимость</label>
                            <input :id="'confCost' + index" class="form-control" type="number" min="1" max="5000000"
                                   placeholder="1000 руб."
                                   v-model="configuration.cost"
                                   v-on:change="onConfigurationChange(configuration, index)"
                            >
                        </div>
                    </div>
                </div>
            <#--Сохранение-->
                <div class="col-12 mt-4">
                    <div class="row justify-content-end">
                        <div class="col-auto">
                            <span :id="'spinnerConfiguration' + index" class="spinner-border-sm mr-2" role="status"
                                  aria-hidden="true"></span>
                            <button :id="'btnCopyConfiguration' + index" class="btn btn-outline-info mr-2"
                                    v-on:click="copyConfiguration(configuration, index)">
                                <span class="fas fa-plus mr-2"></span>Создать копию
                            </button>
                            <button :id="'btnRemoveConfiguration' + index" class="btn btn-outline-danger mr-2"
                                    v-on:click="removeConfiguration(configuration, index)">
                                <span class="fas fa-close mr-2"></span>Удалить
                            </button>
                            <button :id="'btnSaveConfiguration' + index" class="btn btn-outline-success"
                                    v-on:click="saveConfiguration(configuration, index)"
                                    <#--:disabled="configuration.id"-->
                            >
                                <span class="fas fa-save mr-2"></span>Сохранить
                            </button>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>


    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <#if id??>
        <input type="hidden" value="${id}" id="modelId">
    <#else>
        <input type="hidden" value="-1" id="modelId">
    </#if>
    <script src="/js/vue_model.js"></script>
</@common.page>