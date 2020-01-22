<#import "parts/common.ftl" as common>

<@common.page true>

<div id="resolution-manager">
    <div class="offset-2 col-8 card pt-4 pb-4 mb-4">

        <h3 class="col">Разрешения</h3>

        <form class="col mt-4" onsubmit="return false;">
            <div class="form-row">
                <div class="col-4">
                    <input class="form-control" type="number" placeholder="X"
                           v-model="resolution.resolutionX" required>
                </div>
                <div class="col-4">
                    <input class="form-control" type="number" placeholder="Y"
                           v-model="resolution.resolutionY" required>
                </div>
                <div>
                    <button class="btn btn-outline-secondary" v-on:click="add">
                        <span class="fas fa-plus mr-2"></span>Добавить
                    </button>
                </div>
            </div>
        </form>

        <div class="dropdown-divider mt-2"></div>

        <div class="col mt-2" v-for="(resolution, index) in resolutions">
            <form onsubmit="return false;">
                <div class="form-row">
                    <div class="col-4">
                        <input class="form-control" type="number" placeholder="X"
                               v-model.lazy="resolution.resolutionX"
                               v-on:change="onChange(resolution, index)" required>
                    </div>
                    <div class="col-4">
                        <input class="form-control" type="number" placeholder="Y"
                               v-model.lazy="resolution.resolutionY"
                               v-on:change="onChange(resolution, index)" required>
                    </div>
                    <div>
                        <button type="submit" :id="'btnUpdate' + resolution.id"
                                class="btn btn-outline-success mr-2"
                                v-on:click="update(resolution)"
                                disabled>
                            <span class="fas fa-save"></span>
                        </button>

                        <button class="btn btn-outline-danger">
                                <span class="fas fa-close"
                                      v-on:click="remove(resolution.id, index)"></span>
                        </button>
                    </div>
                </div>
            </form>
        </div>

    </div>

    <input type="hidden" value="${_csrf.token}" id="_csrf">
    <script src="/js/vue_resolutions.js"></script>
</@common.page>