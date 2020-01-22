<#import "parts/common.ftl" as common>

<@common.page true>

<div id="color-manager">
    <div class="offset-2 col-8 card pt-4 pb-2 mb-4">
        <h3 class="ml-3">Цвета</h3>
        <div class="col mt-4">
            <div class="form-row">
                <div class="col-1">
                    <input id="color" class="form-control" type="color" v-model="color.value">
                </div>
                <div class="col-8">
                    <input id="name" class="form-control" type="text" placeholder="Название цвета" v-model="color.name"
                           required>
                </div>
                <div>
                    <button class="btn btn-outline-secondary" v-on:click="addColor">
                        <span class="fas fa-plus mr-2"></span>Добавить
                    </button>
                </div>
            </div>
        </div>

        <div class="dropdown-divider mt-2"></div>

        <div class="mt-2 col" v-for="(color, index) in colors">
            <form onsubmit="return false;">
                <div class="form-row">
                    <div class="col-1">
                        <input class="form-control" type="color" v-model.lazy="color.value"
                               v-on:change="onChange(color, index)">
                    </div>
                    <div class="col-8">
                    <#-- v-on:change="onChange($event.target.value -->
                        <!-- v-model v-model.lazy изменяет значения сразу, поэтому невозможно сравнить их потом-->
                        <input class="form-control" type="text" placeholder="Название цвета"
                               v-model.lazy="color.name"
                               v-on:change="onChange(color, index)" required>
                    </div>
                    <div>
                        <button type="submit" :id="'btnUpdate' + color.id"
                                class="btn btn-outline-success mr-2"
                                v-on:click="updateColor(color)"
                                disabled>
                            <span class="fas fa-save"></span>
                        </button>

                        <button class="btn btn-outline-danger" v-on:click="removeColor(color.id, index)">
                            <span class="fas fa-close"></span>
                        </button>

                        <span :id="'spinner'+color.id" class="spinner-border-sm ml-2" role="status"
                              aria-hidden="true"></span>
                    </div>
                </div>
            </form>

        </div>

    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_colors.js"></script>
</@common.page>