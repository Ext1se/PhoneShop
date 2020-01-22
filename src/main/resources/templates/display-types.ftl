<#import "parts/common.ftl" as common>

<@common.page true>

<div id="display-type-manager">
    <div class="offset-2 col-8 card pt-4 pb-4 mb-4">
        <h3 class="col">Типы дисплеев</h3>

        <form class="col mt-4" onsubmit="return false;">
            <div class="form-row">
                <div class="col-9">
                    <input class="form-control" type="text" placeholder="Название"
                           v-model="displayType.name" required>
                </div>
                <div>
                    <button class="btn btn-outline-secondary" v-on:click="addDisplayType">
                        <span class="fas fa-plus mr-2"></span>Добавить
                    </button>
                </div>
            </div>
        </form>

        <div class="dropdown-divider mt-2"></div>


        <div class="mt-2 col" v-for="(displayType, index) in displayTypes">
            <form onsubmit="return false;">
                <div class="form-row">
                    <div class="col-9">
                        <input class="form-control" type="text" placeholder="Название типа дисплея"
                               v-model.lazy="displayType.name"
                               v-on:change="onChange(displayType, index)" required>
                    </div>
                    <div>
                        <button type="submit" :id="'btnUpdate' + displayType.id"
                                class="btn btn-outline-success mr-2"
                                v-on:click="updateDisplayType(displayType)"
                                disabled>
                            <span class="fas fa-save"></span>
                        </button>

                        <button class="btn btn-outline-danger">
                                <span class="fas fa-close"
                                      v-on:click="removeDisplayType(displayType.id, index)"></span>
                        </button>

                        <span :id="'spinner'+displayType.id" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </form>
        </div>

    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_display_types.js"></script>
</@common.page>