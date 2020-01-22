<#import "parts/common.ftl" as common>

<@common.page true>

<div id="display-manager">
    <div class="col card pt-4 pb-2">

        <h3 class="col">Дисплеи</h3>
        <div class="card-body">
        <#--       <h5>Создание нового дисплея</h5>-->
            <div class="form-row">
                <div class="col-10">
                    <label for="name">Название</label>
                    <input id="name" class="form-control" type="text" placeholder="Название"
                           v-bind:class="{'is-invalid':(display.name == '' && isValidated)}"
                           v-model="display.name" required>
                </div>
                <div class="col-2">
                    <label for="diagonal">Диагональ</label>
                    <input id="diagonal" class="form-control" type="number" min="1" max="20" placeholder="5.5 inch"
                           v-model="display.diagonal">
                </div>
            </div>
            <div class="form-row mt-4">
                <div class="col-4">
                    <label for="displayType">Тип дисплея</label>
                    <select id="(displayType, index)" class="custom-select" v-model="display.displayType">
                        <option v-for="displayType in displayTypes" v-bind:value="displayType">
                            {{displayType.name}}
                        </option>
                    </select>
                </div>
                <div class="col-4">
                    <label for="resolution">Разрешение</label>
                    <select id="resolution" class="custom-select" v-model="display.resolution">
                        <option v-for="resolution in resolutions" v-bind:value="resolution">
                            {{resolution.resolutionX}} x {{resolution.resolutionY}}
                        </option>
                    </select>
                </div>
                <div class="col-4">
                    <label for="density">Плотность пикселей</label>
                    <input id="density" class="form-control" type="number" min="10" max="2000"
                           placeholder="400 px/inch"
                           v-model="display.density">
                </div>
            </div>

            <div class="row mt-4 justify-content-end">
                <div class="col-auto">
                    <span id="spinner" class="spinner-border-sm mr-3" role="status" aria-hidden="true"></span>
                    <button class="btn btn-outline-info" v-on:click="updateData">
                        <span class="fas fa-redo mr-2"></span>Обновить зависимости
                    </button>
                    <button id="btnAdd" class="btn btn-outline-secondary" v-on:click="add">
                        <span class="fas fa-plus mr-2"></span>Добавить
                    </button>
                </div>
            </div>
        </div>

        <table class="table col-12 mt-4">
            <thead>
            <tr>
            <#--<th class="align-middle">№</th>-->
                <th style="width: 30%">Название</th>
                <th style="width: 5%">Диагональ</th>
                <th style="width: 20%">Тип дисплея</th>
                <th style="width: 15%">Разрешение</th>
                <th style="width: 5%">Плотность пикселей</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(display, index) in displays">
            <#--<td >
                <h5 class="text-center">{{index + 1}}</h5>
            </td>-->
                <td>
                    <input :id="'name'+display.id" class="form-control" type="text"
                           v-bind:class="{'is-invalid':(display.name == '')}"
                           placeholder="Название модели дисплея"
                           v-model="display.name" required>
                </td>
                <td>
                    <input :id="'diagonal'+display.id" class="form-control" type="number" min="1" max="20"
                           placeholder="5.5 inch"
                           v-model="display.diagonal">
                </td>
                <td>
                    <select :id="'displayType'+display.id" class="custom-select" v-model="display.displayType">
                        <option v-for="displayType in displayTypes" v-bind:value="displayType">
                            {{displayType.name}}
                        </option>
                    </select>
                </td>
                <td>
                    <select :id="'resolution'+display.id" class="custom-select" v-model="display.resolution">
                        <option v-for="resolution in resolutions" v-bind:value="resolution">
                            {{resolution.resolutionX}} x {{resolution.resolutionY}}
                        </option>
                    </select>
                </td>
                <td>
                    <input :id="'density'+display.id" class="form-control" type="number" min="10" max="2000"
                           placeholder="400 px/inch"
                           v-model="display.density">
                </td>
                <td>
                    <div class="row">
                        <div class="col-auto">
                            <button :id="'btnUpdate'+display.id" class="btn btn-outline-success mr-2"
                                    v-on:click="update(display)">
                                <span class="fas fa-save"></span>
                            </button>
                            <button class="btn btn-outline-danger" v-on:click="remove(display.id, index)">
                                <span class="fas fa-close"></span>
                            </button>
                            <span :id="'spinner'+display.id" class="spinner-border-sm ml-2" role="status"
                                  aria-hidden="true"></span>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_displays.js"></script>
</@common.page>