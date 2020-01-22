<#import "parts/common.ftl" as common>

<@common.page true>

<div id="company-manager">
    <div class="offset-2 col-8 card pt-4 pb-2 mb-4">
        <div class="col">
            <h3>Производители</h3>
            <div class="form-row mt-4">
                <div class="col-4">
                    <input id="name" class="form-control" type="text" placeholder="Название"
                           v-bind:class="{'is-invalid':(company.name == '' && isValidated)}"
                           v-model="company.name" required>
                </div>
                <div class="col-4">
                    <input id="country" class="form-control" type="text" placeholder="Страна"
                           v-model="company.country">
                </div>
                <div>
                    <button id="btnAdd" class="btn btn-outline-secondary" v-on:click="add">
                        <span class="fas fa-plus mr-2"></span>Добавить
                    </button>
                    <span id="spinner" class="spinner-border-sm mr-3" role="status" aria-hidden="true"></span>
                </div>
            </div>

            <div class="dropdown-divider mt-2"></div>

            <div class="mt-2 mb-1" v-for="(company, index) in companies">
                <div class="align-middle">
                    <div class="form-row">
                        <div class="col-4">
                            <input :id="'name' + company.id" class="form-control" type="text" placeholder="Название"
                                   v-bind:class="{'is-invalid':(company.name == '')}"
                                   v-model.lazy="company.name"
                                   v-on:change="onChange(company, index)" required>
                        </div>
                        <div class="col-4">
                            <input class="form-control" type="text" placeholder="Страна"
                                   v-model="company.country"
                                   v-on:change="onChange(company, index)">
                        </div>
                        <div>
                            <button type="submit" :id="'btnUpdate' + company.id"
                                    class="btn btn-outline-success mr-2"
                                    v-on:click="update(company)"
                                    disabled>
                                <span class="fas fa-save"></span>
                            </button>

                            <button class="btn btn-outline-danger" v-on:click="remove(company.id, index)">
                                <span class="fas fa-close"></span>
                            </button>
                            <span :id="'spinner'+company.id" class="spinner-border-sm mr-3" role="status"
                                  aria-hidden="true"></span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_companies.js"></script>
</@common.page>