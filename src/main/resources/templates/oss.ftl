<#import "parts/common.ftl" as common>

<@common.page true>

<div id="os-manager">
    <div class="offset-2 col-8 card pt-4 pb-4 mb-4">

        <h3 class="col">Операционные системы</h3>
        <div class="col mt-4 form-row">
            <div class="col-8">
                <input id="name" class="form-control" type="text" placeholder="Название"
                       v-bind:class=""
                       v-model="os.name" required>
            </div>
            <div>
                <button class="btn btn-outline-secondary" v-on:click="add">
                    <span class="fas fa-plus mr-2"></span>Добавить
                </button>
            </div>
        </div>

        <div class="dropdown-divider mt-2"></div>

        <div class="col mt-2" v-for="(os, index) in oss">
            <div class="align-middle">
                <div class="form-row">
                    <div class="col-8">
                        <input :id="'name' + os.id" class="form-control" type="text" placeholder="Название"
                               v-bind:class="{'is-invalid':(os.name == '')}"
                               v-model.lazy="os.name"
                               v-on:change="onChange(os, index)" required>
                    </div>
                    <div>
                        <button type="submit" :id="'btnUpdate' + os.id"
                                class="btn btn-outline-success mr-2"
                                v-on:click="update(os)"
                                disabled>
                            <span class="fas fa-save"></span>
                        </button>

                        <button class="btn btn-outline-danger">
                                <span class="fas fa-close"
                                      v-on:click="remove(os.id, index)"></span>
                        </button>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_oss.js"></script>
</@common.page>