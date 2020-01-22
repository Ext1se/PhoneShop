<#import "parts/common.ftl" as common>

<@common.page true>

<div id="gpu-manager">
    <div class="offset-2 col-8 card pt-4 pb-4 mb-4">

        <h3 class="col">GPU</h3>
        <div class="col mt-4 form-row">
            <div class="col-7">
                <input id="name" class="form-control" type="text" placeholder="Название"
                       v-bind:class="{'is-invalid':(gpu.name == '' && isValidated)}"
                       v-model="gpu.name" required>
            </div>
            <div class="col-2">
                <input id="frequency" class="form-control" type="number" placeholder="Частота"
                       v-model="gpu.frequency">
            </div>
            <div class="col">
                <button id="btnAdd" class="btn btn-outline-secondary" v-on:click="add">
                    <span class="fas fa-plus mr-2"></span>Добавить
                </button>
                <span id="spinner" class="spinner-border-sm mr-3" role="status" aria-hidden="true"></span>
            </div>
        </div>

        <div class="dropdown-divider mt-2"></div>

        <div class="col mt-2" v-for="(gpu, index) in gpunits">
            <div class="align-middle">
                <div class="form-row">
                    <div class="col-7">
                        <input :id="'name' + gpu.id" class="form-control" type="text" placeholder="Название"
                               v-bind:class="{'is-invalid':(gpu.name == '')}"
                               v-model.lazy="gpu.name"
                               v-on:change="onChange(gpu, index)" required>
                    </div>
                    <div class="col-2">
                        <input class="form-control" type="number" placeholder="Частота"
                               v-model="gpu.frequency"
                               v-on:change="onChange(gpu, index)">
                    </div>
                    <div class="col">
                        <button type="submit" :id="'btnUpdate' + gpu.id"
                                class="btn btn-outline-success mr-2"
                                v-on:click="update(gpu)"
                                disabled>
                            <span class="fas fa-save"></span>
                        </button>

                        <button class="btn btn-outline-danger" v-on:click="remove(gpu.id, index)">
                                <span class="fas fa-close"></span>
                        </button>
                        <span :id="'spinner'+gpu.id" class="spinner-border-sm mr-3" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_gpunits.js"></script>
</@common.page>