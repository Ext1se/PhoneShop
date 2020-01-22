<#import "parts/common.ftl" as common>

<@common.page true>
<div id="models-manager">
    <div class=" input-group">
        <input type="text" class="form-control" placeholder="Название модели"
               v-model="searchName"
               aria-describedby="buttons">
        <div class="input-group-append" id="buttons">
            <button class="btn btn-primary"
                    v-on:click="getPhonesByName">
                <span class="fas fa-search mr-2"></span>Найти
            </button>
            <button class="btn btn-secondary ml-2"
                    onclick="window.open('http://localhost:8080/admin/model')">
                <span class="fas fa-plus mr-2"></span>Добавить новую модель
            </button>
        </div>
    </div>

    <div class="row mt-2">
        <div class="col-12">
            <div class="card mt-2 mb-2 col-12" v-for="(model, indexModel) in models">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-2">
                            <img class="card-img-top"
                                 :src="getImage(model)">
                        </div>
                        <div class="col-10 ">
                            <div>
                                <h5><a v-bind:href="'model/' + model.id">{{getModelName(model)}}</a></h5>
                            </div>
                            <div v-for="(colorModel, indexColorModel) in model.colorModels">
                                <div v-for="(configuration, indexConfiguration) in colorModel.configurations">
                                    <div>
                        <span>{{colorModel.color.name}}, {{configuration.os.name}},
                            {{configuration.ram}} Гб х {{configuration.storage}} Гб,
                            {{configuration.cost}} руб.
                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-auto">
                                    <button :id="'btnEdit' + indexModel" class="btn btn-sm btn-outline-success"
                                            v-on:click="openUrl(model)">
                                        <span class="fas fa-edit mr-2"></span>Редактировать
                                    </button>
                                    <button :id="'btnRemove' + indexModel" class="btn btn-sm btn-outline-danger"
                                            v-on:click="remove(model, indexModel)">
                                        <span class="fas fa-close mr-2"></span>Удалить
                                    </button>
                                    <span :id="'spinnerModel' + indexModel" class="spinner-border-sm mr-3"
                                          role="status" aria-hidden="true"></span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_models.js"></script>
</@common.page>