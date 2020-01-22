<#import "parts/common.ftl" as common>

<@common.page true>

<div id="cpu-manager">
    <div class="col card pt-4 pb-2">
        <h3 class="col">CPU</h3>
        <div class="card-body">
        <#--     <h5>Создание CPU</h5>-->
            <div class="form-row">
                <div class="col-8">
                    <label for="name">Название</label>
                    <input id="name" class="form-control" type="text"
                           placeholder=""
                           v-bind:class="{'is-invalid':(cpu.name == '' && isValidated)}"
                           v-model="cpu.name" required>
                </div>
                <div class="col-4">
                    <label for="beans">Количество ядер</label>
                    <input id="beans" class="form-control" type="number" min="1" max="20" placeholder=""
                           v-model="cpu.beans">
                </div>
            </div>
            <div class="form-row mt-4">
                <div class="col-4">
                    <label for="frequency">Тактовая частота</label>
                    <input id="frequency" class="form-control" type="number" placeholder=""
                           v-model="cpu.frequency">
                </div>
                <div class="col-4">
                    <label for="bit">Разрядность</label>
                    <select id="bit" class="custom-select" v-model="cpu.bit">
                        <option value="32">32</option>
                        <option value="64" selected>64</option>
                    </select>
                </div>
                <div class="col-4">
                    <label for="size">Технологический процесс</label>
                    <input id="size" class="form-control" type="number" placeholder=""
                           v-model="cpu.size">
                </div>
            </div>

            <div class="row mt-4 justify-content-end">
                <div class="col-auto">
                    <span id="spinner" class="spinner-border-sm mr-3" role="status" aria-hidden="true"></span>
                    <button id="btnAdd" class="btn btn-outline-secondary" v-on:click="add">
                        <span class="fas fa-plus mr-2"></span>Добавить
                    </button>
                </div>
            </div>
        </div>

        <table class="table col-12 mt-4">
            <thead>
            <tr>
                <th style="width: 40%">Название</th>
                <th style="width: 5%">Количество ядер</th>
                <th style="width: 10%">Тактовая частота</th>
                <th style="width: 10%">Разрядность</th>
                <th style="width: 10%">Технологический процесс</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(cpu, index) in cpunits">
                <td>
                    <input :id="'name'+cpu.id" class="form-control" type="text"
                           v-bind:class="{'is-invalid':(cpu.name == '')}"
                           placeholder=""
                           v-model="cpu.name" required>
                </td>
                <td>
                    <input :id="'beans'+cpu.id" class="form-control" type="number" min="1" max="40"
                           placeholder=""
                           v-model="cpu.beans">
                </td>
                <td>
                    <input :id="'frequency'+cpu.id" class="form-control" type="number" placeholder=""
                           v-model="cpu.frequency">
                </td>
                <td>
                    <select id="'bit'+cpu.id" class="custom-select" v-model="cpu.bit">
                        <option value="32">32</option>
                        <option value="64">64</option>
                    </select>
                </td>
                <td>
                    <input :id="'size'+cpu.id" class="form-control" type="number"
                           placeholder=""
                           v-model="cpu.size">
                </td>
                <td>
                    <div class="row ">
                        <div class="col-auto">
                            <button :id="'btnUpdate'+cpu.id" class="btn btn-outline-success mr-2"
                                    v-on:click="update(cpu)">
                                <span class="fas fa-save"></span>
                            </button>
                            <button class="btn btn-outline-danger" v-on:click="remove(cpu.id, index)">
                                <span class="fas fa-close"></span>
                            </button>
                            <span :id="'spinner'+cpu.id" class="spinner-border-sm ml-2" role="status"
                                  aria-hidden="true"></span>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>

    </div>
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_cpunits.js"></script>
</@common.page>