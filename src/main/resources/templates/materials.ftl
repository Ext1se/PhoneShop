<#import "parts/common.ftl" as common>

<@common.page true>

<div id="material-manager">
    <div class="offset-2 col-8 card pt-4 pb-4 mb-4">

        <h3 class="col">Материалы корпусов</h3>
        <div class="col mt-4 form-row">
            <div class="col-8">
                <input id="name" class="form-control" type="text" placeholder="Название"
                       v-bind:class="{'is-invalid':(material.name == '' && isValidated)}"
                       v-model="material.name" required>
            </div>
            <div>
                <button id="btnAdd" class="btn btn-outline-secondary" v-on:click="add">
                    <span class="fas fa-plus mr-2"></span>Добавить
                </button>
                <span id="spinner" class="spinner-border-sm mr-3" role="status" aria-hidden="true"></span>
            </div>
        </div>

        <div class="dropdown-divider mt-2"></div>

        <div class="col mt-2" v-for="(material, index) in materials">
            <div class="align-middle">
                <div class="form-row">
                    <div class="col-8">
                        <input :id="'name' + material.id" class="form-control" type="text" placeholder="Название"
                               v-bind:class="{'is-invalid':(material.name == '')}"
                               v-model.lazy="material.name"
                               v-on:change="onChange(material, index)" required>
                    </div>
                    <div>
                        <button type="submit" :id="'btnUpdate' + material.id"
                                class="btn btn-outline-success mr-2"
                                v-on:click="update(material)"
                                disabled>
                            <span class="fas fa-save"></span>
                        </button>

                        <button class="btn btn-outline-danger"  v-on:click="remove(material.id, index)">
                                <span class="fas fa-close"></span>
                        </button>
                        <span :id="'spinner'+material.id" class="spinner-border-sm mr-3" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_materials.js"></script>
</@common.page>