<#include "parts/security.ftl">
<#import "parts/common.ftl" as common>
<@common.page true>
<div id="phone-manager">
    <div class="col-12 card mt-4 pt-4 pb-4">
        <div class="row">
            <div class="col-6">
                <div class="col-12" id="carouselImages">
                    <div v-if="phone.colorModel.photos.length == 0" class="col-12">
                        <img :src="urlNoImage" class="d-block w-100">
                    </div>
                    <div v-else id="carouselImageIndicators" class="carousel slide col-12"
                         data-ride="carousel">
                    <#--<ol class="carousel-indicators">
                        <li v-for="(photo, indexPhoto) in phone.colorModel.photos"
                            data-target="#carouselImageIndicators"
                            :data-slide-to="indexPhoto"
                            :class="{'active':(indexPhoto==0)}"></li>
                    </ol>-->
                        <div class="carousel-inner">
                            <div v-for="(photo, indexPhoto) in phone.colorModel.photos"
                                 :class="{'carousel-item': true, 'active':(indexPhoto==0)}">
                                <img :src="getImage(photo)"
                                     class="d-block w-100">
                            </div>
                        </div>
                    </div>
                    <a v-if="phone.colorModel.photos.length > 0" class="carousel-control-prev"
                       href="#carouselImageIndicators" role="button" data-slide="prev">
                        <span class="fas fa-chevron-left text-dark" aria-hidden="true"></span>
                    </a>
                    <a v-if="phone.colorModel.photos.length > 0" class="carousel-control-next"
                       href="#carouselImageIndicators" role="button" data-slide="next">
                        <span class="fas fa-chevron-right text-dark" aria-hidden="true"></span>
                    </a>
                </div>
            </div>

            <div class="col-6 mt-2">
                <h2 class="text-info">{{phone.colorModel.model.name}}</h2>
                <h5>{{phone.os.name}} {{phone.colorModel.color.name}}, {{phone.ram}} ГБ х {{phone.storage}} ГБ</h5>
                <div v-if="phone.colorModel.model.description != null">
                    <span class="text-secondary">{{phone.colorModel.model.description}}</span>
                </div>
                <div v-if="phone.colorModel.model.company != null">
                    <span class="text-secondary">- Производитель: <b>{{getCompanyName()}}</b></span>
                </div>
                <div v-if="phone.colorModel.model.cpu != null">
                    <span class="text-secondary">- CPU: <b>{{getCpuName()}}</b></span>
                </div>
                <div v-if="phone.colorModel.model.gpu != null">
                    <span class="text-secondary">- GPU: <b>{{getGpuName()}}</b></span>
                </div>
                <div v-if="phone.colorModel.model.display != null">
                    <span class="text-secondary">- Тип дисплея: <b>{{getDisplayTypeName()}}</b></span>
                </div>
                <div v-if="phone.colorModel.model.display != null">
                    <span class="text-secondary">- Дисплей: <b>{{getDisplayName()}}</b></span>
                </div>
                <div v-if="phone.colorModel.model.mainCamera != null">
                    <span class="text-secondary">- Камера: <b>{{getCameraName()}}</b></span>
                </div>
                <div v-if="phone.colorModel.model.width != null && phone.colorModel.model.height != null">
                    <span class="text-secondary">- Габариты: <b>{{phone.colorModel.model.width}} x {{phone.colorModel.model.height}} мм</b></span>
                </div>
                <div v-if="phone.colorModel.model.weight != null">
                    <span class="text-secondary">- Вес: <b>{{phone.colorModel.model.weight}} г</b></span>
                </div>
                <div v-if="phone.colorModel.model.power != null">
                    <span class="text-secondary">- Батарея: <b>{{phone.colorModel.model.power}} мА*ч</b></span>
                </div>

                <h2 class="mt-4">{{phone.cost}} &#8381</h2>

                 <#if user??>
                 <button v-if="!checkExistPhone()" id="btnBuy" class="btn btn-outline-info"
                         v-on:click="buyPhone">
                     <span class="fas fa-plus mr-1"></span>
                     Добавить в корзину
                 </button>
                 <button v-else id="btnBucket" class="btn btn-info"
                 <#--onclick="window.open('http://localhost:8080/admin/companies')"-->
                         v-on:click="openUrl()">
                     <span class="fas fa-check mr-1"></span>
                     Перейти в корзину
                 </button>
                 </#if>
            </div>
        </div>
    </div>

    <div class="col-12 card mt-2 mb-4 pt-2 pb-2" style="min-height: 400px;">
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active" id="nav-conf-tab" data-toggle="tab" href="#nav-conf" role="tab"
                   aria-controls="nav-conf" aria-selected="true">Другие конфигурации</a>
                <a class="nav-item nav-link" id="nav-comment-tab" data-toggle="tab" href="#nav-comment" role="tab"
                   aria-controls="nav-comment" aria-selected="false">Отзывы</a>
                <#if user??>
                <a class="nav-item nav-link" id="nav-user-comment-tab" data-toggle="tab" href="#nav-user-comment"
                   role="tab"
                   aria-controls="nav-user-comment" aria-selected="false">Ваш отзыв</a>
                </#if>
            </div>
        </nav>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-conf" role="tabpanel" aria-labelledby="nav-conf-tab">
                <div class="col-12">
                    <div class="row mt-2">
                        <div v-for="(colorModel, indexColorModel) in model.colorModels" class="col-12 mt-1 mb-1">
                            <h5 class="col" v-if="colorModel.configurations.length > 0">{{colorModel.color.name}}</h5>
                            <div class="row col-12">
                                <div v-for="(configuration, indexConfiguration) in colorModel.configurations"
                                     class="col-3 mt-1 mb-1">
                                    <button
                                            v-bind:class="[{'btn btn-sm w-100':true}, (configuration.id == phone.id) ? 'btn-secondary' : 'btn-outline-secondary']"
                                            v-on:click="setPhone(configuration)">{{configuration.os.name}},
                                        {{configuration.ram}} ГБ х {{configuration.storage}} ГБ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="nav-comment" role="tabpanel" aria-labelledby="nav-comment-tab">
                <div class="col-12 mt-4 mb-4" v-for="(comment, indexComment) in comments">
                    <div class="row col-12 align-items-center">
                        <div class="col-9">
                            <h3 class="text-info">{{comment.user.username}}</h3>
                        </div>
                        <div class="col">
                            <div class="col">
                                <div class="row justify-content-end">
                                    <img src="/icons/star.svg" height="16px" width="16px"
                                         v-for="n in comment.rating">
                                </div>
                            </div>
                            <div class="d-flex justify-content-end">
                                <span style="font-size: 80%;">{{comment.dateCreated}}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <span style="white-space: pre-wrap;">{{comment.message}}</span>
                    </div>
                    <#if isAdmin>
                    <div class="col mt-2 mb-2">
                        <div class="col d-flex justify-content-end">
                            <button v-show="comment.id" class="btn btn-sm btn-outline-danger ml-2"
                                    v-on:click="removeComment(comment.id, indexComment)">
                                <span class="fas fa-close mr-2"></span>Удалить
                            </button>
                        </div>
                    </div>
                    </#if>
                    <div class="dropdown-divider mt-4"></div>
                </div>
            </div>
            <div class="tab-pane fade" id="nav-user-comment" role="tabpanel" aria-labelledby="nav-user-comment-tab">
                <div class="col-12 mt-4 form-group">
                    <h6>Отзыв</h6>
                    <textarea class="form-control" rows="6" v-model="comment.message"></textarea>
                </div>
                <div class="col-12 mt-2 form-group">
                    <div class="row col-12 mt-2">
                        <select class="col-2 custom-select custom-select"
                                v-model="comment.rating">
                            <option v-bind:value="0" selected>Не оценивать</option>
                            <option v-bind:value="1">1</option>
                            <option v-bind:value="2">2</option>
                            <option v-bind:value="3">3</option>
                            <option v-bind:value="4">4</option>
                            <option v-bind:value="5">5</option>
                        </select>
                        <div class="col row align-items-center">
                            <button class="btn btn-outline-primary ml-2" id="btnSaveComment"
                                    v-on:click="saveComment()"
                            :disabled="(comment.message == null || comment.message == '') && comment.rating == 0">
                                <span v-if="!comment.id">Опубликовать</span>
                                <span v-else>Редактировать</span>
                            </button>
                            <button v-show="comment.id" class="btn btn-outline-danger ml-2" id="btnRemoveComment"
                                    v-on:click="removeComment(comment.id, -1)">
                                <span>Удалить</span>
                            </button>
                            <span id="spinnerComment" class="spinner-border-sm ml-2" role="status"
                                  aria-hidden="true"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <#if idPhone??>
        <input type="hidden" value="${idPhone}" id="phoneId">
    <#else>
        <input type="hidden" value="-1" id="phoneId">
    </#if>
    <#if idModel??>
        <input type="hidden" value="${idModel}" id="modelId">
    <#else>
        <input type="hidden" value="${idModel}" id="modelId">
    </#if>
    <input type="hidden" value="${currentUserId}" id="userId">
    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_phone.js"></script>
</@common.page>