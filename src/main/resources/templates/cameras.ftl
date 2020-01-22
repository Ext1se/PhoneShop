<#import "parts/common.ftl" as common>

<@common.page true>

<div id="camera-manager">
    <div class="col card pt-4 pb-2">
        <h3 class="col">Камеры</h3>
        <div class="card-body">
        <#--<h5>Создание новой камеры</h5>-->
            <div class="form-row">
                <div class="col-6">
                    <label for="name">Название</label>
                    <input id="name" class="form-control" type="text" placeholder=""
                           v-bind:class="{'is-invalid':(camera.name == '' && isValidated)}"
                           v-model="camera.name" required>
                </div>
                <div class="col-3">
                    <label for="resolutionPhoto">Разрешение фото</label>
                    <select id="resolutionPhoto" class="custom-select" v-model="camera.resolutionPhoto">
                        <option v-for="resolution in resolutions" v-bind:value="resolution">
                            {{resolution.resolutionX}} x {{resolution.resolutionY}}
                        </option>
                    </select>
                </div>
                <div class="col-3">
                    <label for="resolutionVideo">Разрешение видео</label>
                    <select id="resolutionVideo" class="custom-select" v-model="camera.resolutionVideo">
                        <option v-for="resolution in resolutions" v-bind:value="resolution">
                            {{resolution.resolutionX}} x {{resolution.resolutionY}}
                        </option>
                    </select>
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

        <table class="table mt-4 col-12">
            <thead>
            <tr>
            <#--<th>№</th>-->
                <th style="width: 40%;">Название</th>
                <th style="width: 20%">Разрешение фото</th>
                <th style="width: 20%">Разрешение видео</th>
                <th style="width: 20%"></th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(camera, index) in cameras">
            <#--<td>
                <h5 class="text-center">{{index + 1}}</h5>
            </td>-->
                <td>
                    <input :id="'name'+camera.id" class="form-control" type="text"
                           v-bind:class="{'is-invalid':(camera.name == '')}"
                           placeholder=""
                           v-model="camera.name" required>
                </td>
                <td>
                    <select :id="'resolutionPhoto'+camera.id" class="custom-select"
                            v-model="camera.resolutionPhoto">
                        <option v-for="resolution in resolutions" v-bind:value="resolution">
                            {{resolution.resolutionX}} x {{resolution.resolutionY}}
                        </option>
                    </select>
                </td>
                <td>
                    <select :id="'resolutionVideo'+camera.id" class="custom-select"
                            v-model="camera.resolutionVideo">
                        <option v-for="resolution in resolutions" v-bind:value="resolution">
                            {{resolution.resolutionX}} x {{resolution.resolutionY}}
                        </option>
                    </select>
                </td>

                <td>
                    <div class="row">
                        <div class="col-auto">
                            <button :id="'btnUpdate'+camera.id" class="btn btn-outline-success mr-2"
                                    v-on:click="update(camera)"><span class="fas fa-save"></span>
                            </button>
                            <button class="btn btn-outline-danger" v-on:click="remove(camera.id, index)">
                                <span class="fas fa-close"></span></button>
                            <span :id="'spinner'+camera.id" class="spinner-border-sm ml-2" role="status"
                                  aria-hidden="true"></span>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_cameras.js"></script>
</@common.page>